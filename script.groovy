def fetchCode() {
    echo "Pull Source code from GitHub"
    git branch: 'main', url: 'https://github.com/profebass99/jenkins-terraform-eks.git'
}

def buildCode() {
    echo "Build App with Maven"
    sh 'mvn clean install -DskipTests'
}

def buildImage() {
    echo "Build app with docker"
    dockerImage = docker.build(awsEcrRegistry + ":$BUILD_NUMBER", "./Docker-files/app/multistage/")
}

def pushImage() {
    echo "Push Docker Image to ECR"
    docker.withRegistry (imageRegUrl, awsEcrCreds) {
        dockerImage.push ("$BUILD_NUMBER")
        dockerImage.push ('latest')
    }
}

def provisionEksCluster() {
    withAWS(credentials: 'JenkinsAWSCLI', region: 'us-east-2') {
        dir('terraform') {
            sh 'terraform init -reconfigure'
            sh 'terraform destroy --auto-approve'
            EKS_CLUSTER_NAME = sh(
                script: "terraform output clusterName",
                returnStdout: true
            ).trim()
        }
    }
}

def connectEks() {
    echo "${EKS_CLUSTER_NAME}"
    withAWS(credentials: 'JenkinsAWSCLI', region: 'us-east-2') {
        sh "aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${awsRegion}"
        sh 'kubectl get nodes'
        sh 'kubectl apply -f app.yaml'
        sh 'sudo cp /var/lib/jenkins/.kube/config ~/.kube/.'
        sh 'sudo chown -R ubuntu:ubuntu config'
    }
}

return this 


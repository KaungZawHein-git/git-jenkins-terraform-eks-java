<img src="https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/3f52921a-da83-46fd-8f6e-628de6695421" width="5800">


# Project
A simple Jenkins CI/CD application deployment pipeline to Kubernetes on the AWS infrastructure. Automated with Terraform 

# Overview
Developers commit code to a Git repository, triggering Jenkins to initiate a build process. Jenkins compiles the Java code into an executable WAR file. This WAR file is then packaged with Tomcat into a Docker image and subsequently pushed to Amazon Elastic Container Registry (ECR). Following this, Jenkins employs Terraform to provision an Amazon Elastic Kubernetes Service (EKS) cluster, deploying the Docker image into the cluster. Once deployed, users can conveniently test the application using a web browser.

# Requirements
AWS Infrastructure
VPC following AWS best practice with public and private subnets
Jenkins (Terraform)
GitOps or equivalent
EKS (Jenkins uses terraform)

# Steps 
Setting Up Jenkins on AWS Using Terraform

In this guide, we'll set up a Jenkins server on AWS using Terraform, a tool for infrastructure as code.

We will configure AWS credentials or profiles that Terraform will use to create resources in AWS is a crucial step in the process. Here's how to do it:

## Step 1: Set Up AWS Credentials

* AWS CLI Installation: If you haven't already, install the AWS Command Line Interface (CLI) on your local machine.

* AWS Account: Ensure you have an AWS account with IAM user(you may give it admin previlege) having  the necessary permissions to create EC2 instances, security groups, and other resources.

* AWS Access Key and Secret Key: Obtain your AWS access key ID and secret access key. These are the credentials Terraform will use to authenticate with AWS.

## Step 2: Configure AWS CLI

Open a terminal and run the following command to configure AWS CLI:
`aws configure`

You will be prompted to enter:
* AWS Access Key ID: Enter your access key ID.
* AWS Secret Access Key: Enter your secret access key.
* Default region name: Specify your preferred AWS region (e.g., us-east-1).
* Default output format: You can leave this as the default (e.g., json).

## Step 3: Terraform Script

We have a Terraform script in a repository that automates Jenkins server setup. You can access it [here](https://github.com/profebass99/jenkins-terraform-eks/tree/main/jenkins-server).

## Step 4: Customize

Modify the script as needed for your project, including instance type(as we know is better to use a suitable instance type for jenkins, i recommend using atleast for this project a t2.medium), region, and specific Jenkins configurations.

## Step 5: Execution
Execute the Terraform script:
`terraform init`
`terraform apply`

## Step 6: Post-Deployment & Installing the right plugins for our project
Access the Jenkins web interface using the public ipv4 address and you will be prompted with the image below 
![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/b67f6f53-13d3-4182-8040-b109509eeb94)

Now navigate to the highlighted link in directory in the jenkins server to retrieve the password using the command `sudo cat abovementionedlocation`and you should be good to go.
Next  is to launch your Jenkins instance with the suggested plugins.
First we will install suggested plugins and later we will install tyhe needed plugins for our project :).
Lets go!!!!!
![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/e45b8c02-c35b-468c-a188-3338870a05ef)

Then give the details required, save and continue.

![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/d0c5de7d-e3e5-40f6-a941-4a66e1a71042)

*  Go to Dashboard — Manage Jenkins — Plugins The simplest and most common way of installing plugins is through the Manage Jenkins > Plugins view, available to administrators of a Jenkins environment.
  
![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/676e3688-e60a-4861-b364-7a67cd0bf6c4)


![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/8035e77e-53a9-48f3-899f-f842d6477173)


Here under Available plugins search for these plugins below and install it without restarting.
* CloudBees AWS Credentials
* Amazon ECR
* Docker Pipeline
* Maven integration
* AWS Credentials
* pipeline aws steps

## Step : configure maven and java(jdk) path in jenkins.
How to integrate Maven with Jenkins? 
Understand that we have to build our java application into an executabale Jar file  and then build this jar file into a docker iomage that will be deployed in our EKS clusetr
The reason behind integrating Maven with Jenkins is so that we can execute Maven commands through Jenkins as we will majorly use Maven for Java projects. Hence, JDK also comes as a pre-requisite for this setup. So, let's first quickly see how to can specify the java path in Jenkins:
* In the Jenkins dashboard, go to "Manage Jenkins" > "Global Tool Configuration."
  
![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/b67b6f57-dae4-48ec-94cc-d93e5205541b)

* Under the "JDK" section, click "Add JDK."
* Provide a name (e.g., "JDK 8") and specify the JAVA_HOME path (e.g., /usr/lib/jvm/java-8-openjdk-amd64 for OpenJDK 8).
* You can use this command below in your server where the jenkins is installed to check the path where your java was installed.
* `readlink -f $(which java)`

![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/7d3f3a32-2277-4a3e-b942-bfabdc7bb6cb)


* Now Important!! Scroll down and look for the Maven section and click on add maven, but in our case, this time after providing it a name, check the box **`install  automatically`**

![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/aef3d9a9-29a9-4e9a-a491-e4ddbf32736f)

Save the configuration.

## Step 7: Configuring Jenkins Credentials
Now, let's create AWS credentials in Jenkins:

* In the Jenkins dashboard, go to `"Manage Jenkins" > "Manage Credentials."`

* Under the "Stores scoped to Jenkins" section, click "Jenkins."

* Click "Global credentials (unrestricted)" and then "Add Credentials."

* Choose "AWS Credentials" as the kind of credential.

* In the "ID" field, provide a unique identifier for these credentials (e.g., "AWS_Credentials").

* Enter your AWS Access Key ID and Secret Access Key in the respective fields.

* Optionally, you can provide a description for these credentials.

* Click "OK" to save the credentials.


In our next steps, we'll establish a secure and automated connection between GitHub and Jenkins by generating a new SSH key pair. Adding your public SSH key to GitHub ensures secure authentication, authorizes Jenkins to access your repositories, and establishes trusted communication for secure interaction with your GitHub projects.

Additionally, incorporating this SSH key pair into Jenkins enables secure authentication with GitHub during interactions with repositories, facilitating a seamless and secure automation and integration process between Jenkins and GitHub. In summary, both GitHub and Jenkins rely on this SSH key pair for authentication and mutual trust, enabling a secure and automated collaboration between the two platforms.

### Generate an SSH Key Pair

* If you haven't already, generate an SSH key pair on your Jenkins server. You can use the ssh-keygen command for this purpose. Run the following command:

* `ssh-keygen -t rsa -b 4096 -C "your-email@example.com"`

* Replace "your-email@example.com" with your GitHub email address, and follow the prompts to generate the key pair.

* Add the SSH Public Key to GitHub

* Copy the contents of the public key file (~/.ssh/id_rsa.pub) you just generated.

* Log in to your GitHub account.

* Go to your GitHub account settings by clicking on your profile picture in the upper-right corner, then selecting "Settings."

* In the left sidebar, click on "SSH and GPG keys."

* Click "New SSH key" or "Add SSH key."

* Provide a title (e.g., "Jenkins Server") and paste the SSH public key into the "Key" field.

* Click "Add SSH key" to save.

* Configure Jenkins to Use the SSH Key

* Log in to your Jenkins dashboard.

* In the Jenkins dashboard, click on "Manage Jenkins" > "Manage Credentials."

* Under the "Stores scoped to Jenkins" section, click "Jenkins."

* Click "Global credentials (unrestricted)" and then "Add Credentials."

* Choose "SSH Username with private key" as the kind of credential.

* In the "Username" field, enter your GitHub username.

* In the "Private Key" field, select "Enter directly" and paste the contents of the private key (~/.ssh/id_rsa) you generated earlier.

* Provide a description (e.g., "GitHub SSH Key for Jenkins").

* Click "OK" to save the credentials.

## Step 8: Configure GitHub Webhook
Additionally, we'll set up a webhook trigger between our Jenkins job and GitHub. This webhook will automatically initiate our Jenkins jobs in response to specific push events or code changes in our repository.
To set up a webhook in GitHub to trigger Jenkins builds automatically, follow these steps:
* In your GitHub repository, go to "Settings" > "Webhooks."

* Click "Add webhook."

* In the "Payload URL" field, enter the URL to your Jenkins server, followed by /github-webhook/ (e.g., http://your-jenkins-server/github-webhook/).

* Set the "Content type" to "application/json."

* In the "Secret" field, you can optionally enter a secret token that Jenkins will use to verify the authenticity of the webhook payload. This enhances security.

* Select the events that should trigger the webhook. At a minimum, you'll want to select "Just the push event" to trigger the build when code is pushed to the repository.

* Click "Add webhook" to save your webhook configuration.

## Step 9: Create an ECR on AWS
We will create an ECR repo where our built docker images will be pushed to.
To create an Amazon Elastic Container Registry (ECR) repository in AWS, you can use the AWS Management Console:

**Using the AWS Management Console**
*Log in to your AWS account.

* From the AWS Management Console, go to the "Services" dropdown in the top left corner, and under the "Compute" section, select "ECR" (Elastic Container Registry).

* In the ECR dashboard, click the "Create repository" button.

* Enter a unique name for your repository in the "Repository name" field. Optionally, add a tag immutability policy if desired. Click "Create repository" to create the ECR repository.

## Step 10: Configure Jenkins to run our jobs.
Configure Jenkins Job

In the Jenkins dashboard, create a new pipeline job:

* Click "New Item"
  
![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/a485ed22-4e2d-48a2-8058-9182a4834f05)

* Enter a job name > Select "Pipeline" as the job type > Click "OK."
  
![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/e3178e00-733f-466a-82ca-689a76cdf140)

* In the "Build Triggers" option check the box `GitHub hook trigger for GitScm polling`
  
![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/df8c25d4-8760-478c-94fc-4dd41db08e1d)



* In the job configuration, go to the "Pipeline" section. Choose for the 'Pipeline script from SCM' option since our Jenkinsfile resides within the repository. Provide the repository URL and select the previously created GitHub access credentials in the credentials option. Choose the appropriate branch (e.g., 'main' or 'master') depending on your repo and scm configuration. Specify the Jenkinsfile path; in my case, it's in the root directory, so I'll simply use the filename 'Jenkinsfile'.

![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/bbd685ea-669c-42bd-ac4f-d086e63f8969)


After completing these steps, click 'Save and Apply' and then initiate a build to test our job. Moreover, keep in mind that the job can also be triggered automatically when a push event occurs in our repository; it will start promptly in response to the event.

![image](https://github.com/profebass99/jenkins-terraform-eks/assets/104143346/6052c998-d7da-4ff9-a84e-947adc43fdaf)

# Overview or Description of the Jenkinsfile 
So first of all, As you could see from my codes, i am integrating the Jenkinsfile with my scipt.groovy. Using a Jenkinsfile in conjunction with a Groovy script enables a cleaner and more modular CI/CD configuration. The Jenkinsfile defines the pipeline structure, while the Groovy script handles the detailed implementation of each stage's tasks. This separation enhances code organization, promotes reusability, and simplifies maintenance, making it a more efficient and readable way to manage complex CI/CD processes.

## My Jenkinsfile defines a declarative pipeline with multiple stages for a continuous integration and deployment (CI/CD) process. Here's a breakdown of what each stage is doing:

## Init Stage:
Loads a Groovy script named "script.groovy" and assigns it to the variable gv.

## Fetch Code Stage:
Calls the fetchCode method from the loaded Groovy script (gv) to fetch the source code.

## Build Stage:
Builds the code, using Maven (specified in the "tools" section).
Archives the generated artifacts (War files) upon a successful build.

## Build Image Stage:
Calls the buildImage method, which builds a Docker image from the application code.

## Push Image to ECR Stage:
Pushes the Docker image to Amazon Elastic Container Registry (ECR) using the pushImage method.

## Provision EKS Cluster Stage:
Invokes the provisionEksCluster method, which goes beyond just creating an Amazon Elastic Kubernetes Service (EKS) cluster. It also sets up a Virtual Private Cloud (VPC) with essential components like subnets, an internet gateway, NAT gateway, route table, and more. This entire infrastructure is provisioned using a Terraform module. For a deeper understanding of the context, you can refer to the script.groovy and the terraform folder. 😊

## Connect to EKS Cluster Stage:
Calls the connectEks method, indicating the establishment of a connection to the provisioned EKS cluster. And deploying this pushed image in our EKS cluster

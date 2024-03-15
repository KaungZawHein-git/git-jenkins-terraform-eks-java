data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "jenkins" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.jenkins-sg.name]
  key_name        = var.key_name
  user_data       = file("jenkins.sh")
  user_data_replace_on_change = true

  tags = {
    "Name" = "${var.environment}-Jenkins-Server"
  }
}
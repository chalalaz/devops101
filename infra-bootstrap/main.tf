terraform {
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "jenkins" {
  ami             = "ami-082b1f4237bd816a1" # Ubuntu Server 22.04 LTS
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.jenkins_sg.name]
  user_data       = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install openjdk-11-jdk ca-certificates curl gnupg lsb-release -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
    sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    sudo usermod -aG docker ubuntu jenkins
    sudo apt-get install jenkins -y
    sudo systemctl daemon-reload
    sudo systemctl start jenkins.service
    sudo systemctl status jenkins
    git clone --single-branch --branch nginx-proxy https://github.com/chalalaz/devops101.git && mv devops101 /home/ubuntu
    EOF
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow Jenkins Traffic"

  ingress {
    description      = "Allow from http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

  ingress {
    description      = "Allow from jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

  ingress {
    description      = "Allow from admin NPM"
    from_port        = 81
    to_port          = 81
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

  ingress {
    description      = "Allow from https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

  ingress {
    description      = "Allow SSH inbound"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Jenkins SG"
  }
}
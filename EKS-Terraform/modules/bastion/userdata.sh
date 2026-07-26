#!/bin/bash

yum update -y

####################################
# Java
####################################

dnf install java-21-amazon-corretto -y

####################################
# Git
####################################

dnf install git -y

####################################
# Docker
####################################

dnf install docker -y

systemctl enable docker

systemctl start docker

usermod -aG docker ec2-user

####################################
# Jenkins
####################################

wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf install jenkins -y

systemctl enable jenkins

systemctl start jenkins

####################################
# kubectl
####################################

curl -LO \
https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x kubectl

mv kubectl /usr/local/bin/

####################################
# Helm
####################################

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

####################################
# Terraform
####################################

dnf install -y yum-utils

yum-config-manager --add-repo \
https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

dnf install terraform -y

####################################
# AWS CLI
####################################

dnf install awscli -y

####################################
# eksctl
####################################

curl --silent --location \
"https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
| tar xz -C /tmp

mv /tmp/eksctl /usr/local/bin/
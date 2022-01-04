# IAC-Provisioning


Iac-Kubernetes-AwsCloud
This Project tends to provision EKS Cluster on AWS Cloud while using Git Actions as an Integrating tool and Terraform as IAC Tool

------------------------------------------------------------------------------------------------------------------

Terraform Installation And Setup In AWS EC2 Linux Instances

Using Terraform to provision a fully managed Amazon EKS Cluster

Prerequisite

AWS Acccount.

Create an ubuntu EC2 Instnace.

Create IAM Role With Required Policies.

VPCFullAccess

EC2FullAcces

S3FullAccess ..etc

Administrator Access

Attach IAM Role to EC2 Instance.

# Install Terraform

$ sudo adduser eksadmin

$ sudo echo "eksadmin  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/eksadmin

$ sudo su - eksadmin

$ git clone https://github.com/kiki023/IAC-Provisioning

$ cd /opt

$ wget https://releases.hashicorp.com/terraform/1.1.0/terraform_0.12.26_linux_amd64.zip

$ sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/local/bin/

Export terraform binary path temporally

$ export PATH=$PATH:/usr/local/bin

Add path permanently for current user.By Exporting path in .bashrc file at end of file

$ vi ~/.bashrc

   export PATH="$PATH:/usr/local/bin"
   
Source .bashrc to reflect for current session

Infrastructure As A Code using Terraform

Create Infrastructure(Amazon EKS, IAM Roles, AutoScalingGroups, Launch Configuration, LoadBalancer, NodeGroups,VPC,Subnets,Route Tables,Security Groups, NACLs, ..etc) As A Code Using Terraform Scripts

# Initialise to install plugins

$ terraform init 

# Validate terraform scripts

$ terraform validate 

# Plan terraform scripts which will list resources which is going  be created.

$ terraform plan 

# Apply to create resources

$ terraform apply --auto-approve

##  Destroy Infrastructure  

$ terraform destroy --auto-approve

## create the kubeconfig file  

$ mkdir .kube/ 

$ vi .kube/config

$ kubectl get pod

$ #!/bin/bash 

$ sh iam-authenticator.sh 

$ kubectl get pod

## deploy cluster auto scaler

$ kubectl apply -f clusterautoscaler.yml

##  Destroy Infrastructure  

$ terraform destroy --auto-approve 

EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html


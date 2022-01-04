# IAC-Provisioning


Iac-Kubernetes-AwsCloud
This Project tends to provision EKS Cluster on AWS Cloud while using Git Actions as an Integrating tool and Terraform as IAC Tool

A GitHub account

A Terraform Cloud account

An AWS account and AWS Access Credentials

If you don't have AWS Access Credentials, create your AWS Access Key ID and Secret Access Key by navigating to your IAM security credentials in the AWS console. Click "Create access key" here and download the file. This file contains your access credentials.

In the End, You can track the status of the apply job through GitHub Actions or Terraform Cloud.

------------------------------------------------------------------------------------------------------------------

Terraform Installation And Setup In AWS EC2 Linux Instances CLI
------------------------------------------------------------------------------------------------------------------

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
---------------------------------------------------------------------------------------------------------------------

$ sudo adduser eksadmin

$ sudo echo "eksadmin  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/eksadmin

$ sudo su - eksadmin

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

# Destroy Infrastructure  

$ terraform destroy --auto-approve

------------------------------------------------------------------------------------------------------
 In this repository:
 
 main.tf file: Replace line 25 with your appropriate server path
 
 variables.tf file: Replace line 9 with your servers existing key file



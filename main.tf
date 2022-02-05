terraform {
  required_version = ">= 0.13"
  backend "s3" {
    bucket         = "camchi"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "camchi1"
  }
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0" 
      
    }
  }  
  cloud {
    organization = "LoveChi"

    workspaces {
      name = "gh-actions-dotpay"
    }
  }
}

provider "aws" {
        region = "us-west-1"
        shared_credentials_file = "~/eksadmin/.aws/credentials"
}

terraform {
  required_version = ">= 0.13"

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

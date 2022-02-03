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
        aws_access_key = ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_key = ${{ secrets.AWS_SECRET_ACCESS_KEY }}
}

#
# Provider Configuration
#
provider "kubectl" {
  host                   = data.aws_eks_cluster.demo-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo-cluster.certificate_authority.0.data)

  exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.id]
      command     = "aws"
    }

  load_config_file       = false
}

# provider "aws" {
#  region  = "us-west-1"
# }

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

# data "aws_availability_zones" "available" {}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster-name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster-name

}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  insecure               = false
  config_path            = "./${local.cluster_name}-config" # This must match the module input
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

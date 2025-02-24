terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }


  backend "s3" {
    bucket = "react-with-terraform-bucket"
    key    = "terraform/state"
    region = "us-east-1"
  }

}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host = aws_eks_cluster.eks_cluster.endpoint
  token = data.aws_eks_cluster_auth.eks_auth.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority.0.data)
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.eks_cluster.name
}
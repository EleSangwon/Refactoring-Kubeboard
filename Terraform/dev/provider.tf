terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.2"
    }
  }

  backend "s3" {
    bucket = "elesangwon-terraform-dev"
    key    = "environment/dev/Kubeboard/terraform.tfstate"
    region = "ap-northeast-1"
    # dynamodb_table = "TerraformState"
    profile = "EleSangwon-dev"
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "EleSangwon-dev"
}



provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_id
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
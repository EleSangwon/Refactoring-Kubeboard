terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "kubeboard-tfstates"
    key            = "kubeboard-infra-states/kubeboard-dev-eks-base-services.tfstate"
    profile        = "EleSangwon-user"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "EleSangwon-user"
}
provider "aws" {
  region = "ap-northeast-2"
  profile = "EleSangwon-user"
  alias = "kubeboard-dev"
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket         = "kubeboard-tfstates"
    region         = "ap-northeast-2"
    key            = "kubeboard-infra-states/kubeboard-dev-eks.tfstate"
    profile        = "EleSangwon-user"
    dynamodb_table = "terraform-lock"
  }
}

locals {
  name = "kubeboard-dev"
  tags = {
    Name        = local.name
    Environment = "dev"
    Team        = "kubeboard"
    Project     = "kubeboard"
  }
  eks = data.terraform_remote_state.eks.outputs.eks
}

module "base_services" {

  source                      = "git@github.com:EleSangwon/project-terraform.git//module/eks-base-services"
  name                        = local.name
  tags                        = local.tags
  eks_cluster_id              = local.eks.cluster_id
  external_dns_zones          = ["elesangwon.com"]
 # kubernetes_dashboard_domain = "eks.dev.elesangwon.com"

  providers = {
    aws.dev = aws.kubeboard-dev
  }
}
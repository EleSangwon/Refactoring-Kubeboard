terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "kubeboard-tfstates"
    key            = "kubeboard-infra-states/kubeboard-dev-eks.tfstate"
    profile        = "EleSangwon-user"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "EleSangwon-user"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "kubeboard-tfstates"
    region  = "ap-northeast-2"
    key     = "kubeboard-infra-states/kubeboard-dev-vpc.tfstate"
    profile = "EleSangwon-user"
    dynamodb_table = "terraform-lock"
  }
}

locals {
  name = "kubeboard-dev"
  tags = {
    Name        = local.name
    Environment = "dev"
    Project     = "kubeboard"
    Team        = "kubeboard"
  }
  vpc = data.terraform_remote_state.vpc.outputs.vpc
  private_subnets_by_az = {
    for i, subnet in local.vpc.private_subnets :
    local.vpc.azs[i % length(local.vpc.azs)] => subnet...
  }
}

module "eks" {
  source = "git@github.com:EleSangwon/project-terraform.git//module/eks-base-cluster"
  name   = local.name
  tags   = local.tags

  eks_version = "1.23"

  vpc_id = local.vpc.vpc_id

  private_subnets_by_az = local.private_subnets_by_az

  eks_map_users = []

  eks_map_roles = [
    {
      groups   = ["system:masters"]
      rolearn  = "arn:aws:iam::002174788893:role/kubeboard-dev-devops"
      username = "kubeboard-dev-devops"
    }
  ]
}
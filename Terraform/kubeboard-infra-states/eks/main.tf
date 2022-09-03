terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "kubeboard-tfstates"
    key            = "kubeboard-infra-states/aws-eks.tfstate"
    profile        = "EleSangwon-user"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "ap-northeast-2"
    bucket  = "kubeboard-tfstates"
    key     = "kubeboard-infra-states/aws-vpc.tfstate"
    profile = "EleSangwon-user"
  }
}

locals {
  cluster_name = "kubeboard-${var.aws_region}"
  common_tags = {
    Owner = "EleSangwon-user"
  }
}

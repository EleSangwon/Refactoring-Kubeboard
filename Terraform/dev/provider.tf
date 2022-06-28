terraform {
  # required_providers {
  #   aws = {
  #     source  = "hashicorp/aws"
  #     version = "~> 4.0"
  #   }
  # }

  backend "s3" {
    bucket         = "elesangwon-terraform-dev"
    key            = "environment/dev/Kubeboard/terraform.tfstate"
    region         = "ap-northeast-1"
   # dynamodb_table = "TerraformState"
    profile        = "EleSangwon-dev"
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "EleSangwon-dev"
}



provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

terraform {
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

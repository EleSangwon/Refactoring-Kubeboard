terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "kubeboard-tfstates"
    key            = "kubeboard-infra-states/kubeboard-dev-vpc.tfstate"
    profile        = "EleSangwon-user"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "EleSangwon-user"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "kubeboard-dev"
  cidr               = "10.0.0.0/16"
  enable_nat_gateway = true
  single_nat_gateway = true
  azs                = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  private_subnets    = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public_subnets     = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]

  private_subnet_tags = { "kubernetes.io/role/internal-elb" = 1 }
  public_subnet_tags  = { "kubernetes.io/role/elb" = 1 }

  tags = {
    "kubernetes.io/cluster/kubeboard-dev" = "shared"
    Terraform                             = "true"
    Environment                           = "dev"
    Project                               = "kubeboard"
    Team                                  = "kubeboard"
  }
}

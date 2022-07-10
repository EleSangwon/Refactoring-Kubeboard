module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.22"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets_by_az


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = [var.node_group_instance_type]
  }

  eks_managed_node_groups = {
    blue = {}
    # green = {
    #   min_size     = 1
    #   max_size     = 10
    #   desired_size = 1

    #   instance_types = ["t3.small"]
    #   capacity_type  = "SPOT"
    # }
  }

}

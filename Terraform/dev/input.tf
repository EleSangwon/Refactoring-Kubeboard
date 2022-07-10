variable "private_subnets_by_az" {
  type    = list(string)
  default = ["subnet-f08294ab", "subnet-a4e7498f", "subnet-96e740de"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-732c3614"
}

variable "node_group_instance_type" {
  type    = string
  default = "t3.small"
}
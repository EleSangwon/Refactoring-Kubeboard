variable "account_id" {
  type        = string
  description = "aws account id"
  default     = 002174788893
}

variable "profile" {
  type        = string
  description = "aws profile (yor mfa profile name)"
  default     = "EleSangwon-user"
}

variable "aws_region" {
  type        = string
  description = "aws region"
  default     = "ap-northeast-2"
}

variable "cluster_enabled_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "instance_types" {
  type        = list(string)
  description = "node instance types"
  default     = ["t3.medium","t3.large"]
}

variable "create_kube_proxy" {
  type        = bool
  description = "Create kube-proxy"
  default     = true
}

variable "kube_proxy_version" {
  type        = string
  description = "The EKS kube-proxy version"
  default     = "v1.22.6-eksbuild.1"
}

variable "create_vpc_cni" {
  type        = bool
  description = "Create vpc-cni"
  default     = true
}

variable "vpc_cni_version" {
  type        = string
  description = "The EKS vpc-cni version"
  default     = "v1.11.0-eksbuild.1"
}

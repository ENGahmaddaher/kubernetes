variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "microservices-demo"
}

variable "cluster_version" {
  description = "Kubernetes Version"
  type        = string
  default     = "1.29"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "node_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.medium"
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 5
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name for Terraform State"
  type        = string
  default     = "microservices-demo-terraform-state"
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts"
  type        = bool
  default     = true
}

variable "github_org" {
  description = "GitHub Organization for OIDC"
  type        = string
  default     = "ENGahmaddaher"
}

variable "github_repo" {
  description = "GitHub Repository for OIDC"
  type        = string
  default     = "kubernetes"
}

variable "common_tags" {
  description = "Common Tags for all resources"
  type        = map(string)
  default = {
    Project     = "microservices-demo"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

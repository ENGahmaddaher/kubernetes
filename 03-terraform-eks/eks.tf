module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }
  }

  eks_managed_node_group_defaults = {
    instance_types = [var.node_instance_type]
    capacity_type  = "ON_DEMAND"
  }

  eks_managed_node_groups = {
    main = {
      desired_size = var.node_desired_size
      max_size     = var.node_max_size
      min_size     = var.node_min_size
      instance_types = [var.node_instance_type]
      tags = { Name = "${var.cluster_name}-worker-node" }
    }
  }

  enable_irsa = var.enable_irsa
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "terraform_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "etcd_backup_bucket" {
  value = aws_s3_bucket.etcd_backup.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.terraform_state_lock.name
}

output "argocd_role_arn" {
  value = aws_iam_role.argocd.arn
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "etcd_backup_role_arn" {
  value = aws_iam_role.etcd_backup.arn
}

output "etcd_backup_service_account" {
  value = kubernetes_service_account.etcd_backup.metadata[0].name
}

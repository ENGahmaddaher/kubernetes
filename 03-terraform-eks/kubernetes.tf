# ========================================
# ServiceAccount لـ etcd Backup (مع IRSA)
# ========================================
resource "kubernetes_service_account" "etcd_backup" {
  metadata {
    name      = "etcd-backup-sa"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.etcd_backup.arn
    }
    labels = {
      app       = "etcd-backup"
      managedBy = "terraform"
    }
  }
}

# ========================================
# ServiceAccount لـ External Secrets
# ========================================
resource "kubernetes_service_account" "external_secrets" {
  metadata {
    name      = "external-secrets-sa"
    namespace = "external-secrets"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.external_secrets.arn
    }
    labels = {
      app       = "external-secrets"
      managedBy = "terraform"
    }
  }
}

# ========================================
# Namespace للمراقبة
# ========================================
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      purpose   = "monitoring"
      managedBy = "terraform"
    }
  }
}

# ========================================
# Namespace للتطبيق
# ========================================
resource "kubernetes_namespace" "microservices_demo" {
  metadata {
    name = "microservices-demo"
    labels = {
      app       = "microservices-demo"
      managedBy = "terraform"
    }
  }
}

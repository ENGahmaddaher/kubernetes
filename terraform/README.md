
# Etcd Backup Architecture

## Flow
Terraform (AWS) Kubernetes (EKS)
───────────────── ──────────────────
S3 Bucket ←─────────────── CronJob Pod
IAM Role ←── IRSA ────── ServiceAccount
↑
Annotation:
eks.amazonaws.com/role-arn

text

## How It Works

| Step | What Happens |
|------|--------------|
| 1 | Terraform creates S3 bucket + IAM Role (S3 access) |
| 2 | Terraform creates ServiceAccount with IRSA annotation |
| 3 | ServiceAccount links Pod → IAM Role → S3 |
| 4 | CronJob runs every 6h on Control Plane |
| 5 | Pod uses `etcdctl` to snapshot etcd |
| 6 | Pod uses `aws s3 cp` to upload to S3 |

## Key Point

**CronJob lives inside EKS** - it doesn't "connect" to EKS.  
It's deployed to EKS via `kubectl apply`, stored in etcd, and scheduled by Kubernetes.

## Files

| File | Purpose |
|------|---------|
| `terraform/s3.tf` | S3 bucket for backups |
| `terraform/iam.tf` | IAM Role + S3 policy |
| `terraform/kubernetes.tf` | ServiceAccount with IRSA |
| `CronJob.yaml` | Scheduled etcd backup job |
| `ServiceAccount.yaml` | SA with IAM role annotation |

# ============================================
# Etcd Backup - Deployment Commands
# ============================================

# 1. Create AWS Infrastructure (Terraform)
terraform init
terraform plan
terraform apply -auto-approve

# 2. Connect to EKS Cluster
aws eks update-kubeconfig --region us-east-1 --name microservices-demo

# 3. Deploy CronJob
kubectl apply -k kubernete_aws/base/etcd-backup/

# 4. Verify Deployment
kubectl get cronjob -n kube-system etcd-backup
kubectl get serviceaccount -n kube-system etcd-backup-sa

# 5. Manual Test (Run Job Immediately)
kubectl create job --from=cronjob/etcd-backup manual-test -n kube-system

# 6. Check Logs
kubectl logs -n kube-system job/manual-test -f

# 7. Verify S3 Upload
aws s3 ls s3://microservices-demo-etcd-backup/etcd-backups/

# 8. Cleanup Test Job
kubectl delete job manual-test -n kube-system

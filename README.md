
# 🚀 Demo Application on Kubernetes

> **Complete microservices deployment with GitOps, Monitoring, and AWS Infrastructure**

[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28+-326CE5?logo=kubernetes&logoColor=white)](https://kubernetes.io)
[![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?logo=argo&logoColor=white)](https://argoproj.github.io/cd/)
[![Terraform](https://img.shields.io/badge/Terraform-AWS-7B42BC?logo=terraform&logoColor=white)](https://terraform.io)
[![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus&logoColor=white)](https://prometheus.io)
[![React](https://img.shields.io/badge/React-Frontend-61DAFB?logo=react&logoColor=black)](https://reactjs.org)
[![Node.js](https://img.shields.io/badge/Node.js-API-339933?logo=nodedotjs&logoColor=white)](https://nodejs.org)

---

## 📋 **What's Inside?**
┌─────────────────────────────────────────────────────────────────────────────┐
│ 🏗️ Full Stack Microservices │
├─────────────────────────────────────────────────────────────────────────────┤
│ │
│ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ │
│ │ React │────▶│ Node.js │────▶│ PostgreSQL │ │
│ │ Frontend │ │ API │ │ Database │ │
│ │ :4321 │ │ :3001 │ │ :5432 │ │
│ └─────────────┘ └─────────────┘ └─────────────┘ │
│ │ │ │ │
│ └───────────────────┼───────────────────┘ │
│ │ │
│ ┌────────▼────────┐ │
│ │ Ingress NGINX │ │
│ │ (Load Balancer)│ │
│ └────────┬────────┘ │
│ │ │
│ ┌──────────────┼──────────────┐ │
│ │ │ │ │
│ ┌──────▼──────┐ ┌──────▼──────┐ ┌──────▼──────┐ │
│ │ Prometheus │ │ Grafana │ │ ArgoCD │ │
│ │ Monitoring │ │ Dashboards │ │ GitOps │ │
│ └─────────────┘ └─────────────┘ └─────────────┘ │
│ │
└─────────────────────────────────────────────────────────────────────────────┘

text

---

## 🎯 **Components Overview**

### **📦 Application Stack**

| Component | Technology | Port | Description |
|-----------|-----------|------|-------------|
| **Frontend** | React | 4321 | Client UI with auto-scaling |
| **Backend API** | Node.js | 3001 | REST API with HPA |
| **Database** | PostgreSQL | 5432 | StatefulSet with PVC |
| **Migrations** | SQL Job | - | One-time database setup |

### **🔧 Infrastructure (Kubernetes)**

| Component | Purpose |
|-----------|---------|
| **Deployment** | Application pods with resource limits |
| **Service (ClusterIP)** | Internal load balancing |
| **Horizontal Pod Autoscaler (HPA)** | Scale based on CPU |
| **Vertical Pod Autoscaler (VPA)** | Resource recommendations |
| **PodDisruptionBudget** | Safe evictions |
| **NetworkPolicy** | Zero-trust security |
| **Ingress** | External access with routing |
| **StatefulSet** | PostgreSQL with persistent storage |

### **📊 Monitoring Stack (Helm)**

| Tool | Purpose | Access |
|------|---------|--------|
| **Prometheus** | Metrics collection | `:9090` |
| **Grafana** | Visualization | `:3000` (admin/admin123) |
| **PodMonitors** | Custom metrics scraping | Auto-discovered |

### **⚙️ GitOps & CI/CD**

| Tool | Purpose |
|------|---------|
| **ArgoCD** | GitOps controller, syncs from Git |
| **GitHub Actions** | CI pipeline (build & push) |
| **Terraform** | AWS EKS infrastructure |

### **☁️ AWS Infrastructure (Terraform)**

| Resource | Purpose |
|----------|---------|
| **EKS Cluster** | Managed Kubernetes |
| **VPC** | Networking with public/private subnets |
| **S3** | Terraform state backend |
| **IAM** | Roles and policies |

---

## 📁 **Project Structure**
📂 demo-microservices/
│
├── 📂 01-demo-application/
│ ├── api-node/ # Node.js backend
│ ├── client-react/ # React frontend
│ └── postgres-migrations/# SQL migration scripts
│
├── 📂 02-deploy-demo-application-kubernetes/
│ ├── base/ # Common configurations
│ │ ├── api-node/
│ │ │ ├── Deployment.yaml
│ │ │ ├── Service.yaml
│ │ │ ├── AutoScalingHPA.yaml
│ │ │ ├── NetworkPolicy.yaml
│ │ │ └── PodDisruptionBudget.yaml
│ │ ├── client-react/
│ │ │ ├── Deployment.yaml
│ │ │ ├── Service.yaml
│ │ │ └── AutoScalingHPA.yaml
│ │ ├── postgresql/
│ │ │ ├── StateFulSet.yaml
│ │ │ ├── HService.yaml
│ │ │ ├── PGSecret.yaml
│ │ │ ├── PGConfigMap.yaml
│ │ │ ├── MigrationSQLJob.yaml
│ │ │ └── AutoScalingVPA.yaml
│ │ ├── monitoring/
│ │ │ ├── podmonitor-api.yaml
│ │ │ └── podmonitor-client.yaml
│ │ ├── ingress.yaml
│ │ ├── namespace.yaml
│ │ └── kustomization.yaml
│ │
│ └── staging/ # Staging overrides
│ ├── kustomization.yaml
│ └── patches/
│ ├── replicas.yaml
│ └── ingress-host.yaml
│
├── 📂 03-terraform-eks/
│ ├── versions.tf # Provider versions
│ ├── variables.tf # Input variables
│ ├── main.tf # Main configuration
│ ├── vpc.tf # VPC with subnets
│ ├── s3.tf # State backend
│ ├── eks.tf # EKS cluster
│ ├── iam.tf # IAM roles
│ ├── kubernetes.tf # K8s provider
│ ├── outputs.tf # Output values
│ └── terraform.tfvars.example
│
├── 📂 .github/workflows/
│ └── ci-cd.yaml # GitHub Actions pipeline
│
├── 📂 UsefulScripts/
│ ├── backup-namespace.sh
│ ├── restore-namespace.sh
│ ├── collect-all-logs.sh
│ ├── health-check-all.sh
│ └── add-labels-to-all-pods.sh
│
├── ArgoCD.yaml
├── kind-config.yaml
└── README.md

text

---

## 🚀 **Quick Start (5 Minutes)**

### **Prerequisites**

```bash
# Required tools
✅ kubectl
✅ kind (or AWS CLI for EKS)
✅ helm
✅ task
✅ terraform (for AWS)
Option 1: Local Development (Kind)
bash
# 1. Create Kind cluster
task kind-create

# 2. Install components (metrics-server, ingress, argocd)
task install-metrics-server
task install-ingress
task install-argocd

# 3. Deploy the application
task deploy

# 4. Check status
task status
Option 2: AWS EKS (Production)
bash
# 1. Deploy infrastructure
cd 03-terraform-eks
terraform init
terraform plan
terraform apply

# 2. Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name microservices-demo

# 3. Deploy application (same as Option 1)
task deploy
📊 Access Services
Application
bash
# Port-forward Ingress
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80
# Open: http://localhost:8080
Service	URL	Credentials
React Frontend	/	Public
Node.js API	/api	Public
Monitoring (Grafana)
bash
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
# Open: http://localhost:3000
Login	Password
admin	admin123
GitOps (ArgoCD)
bash
task argocd-portforward
# Open: http://localhost:8443
bash
# Get admin password
task argocd-password
# Login: admin / <output-password>
API Direct Access
bash
task portforward-api
# API available at: http://localhost:3001
React Direct Access
bash
task portforward-react
# React available at: http://localhost:4321
🛠️ Useful Commands (Taskfile)
Command	Description
task kind-create	Create Kind cluster
task kind-delete	Delete Kind cluster
task install-metrics-server	Install metrics-server
task install-ingress	Install NGINX Ingress
task install-argocd	Install ArgoCD
task argocd-password	Get ArgoCD admin password
task argocd-portforward	Port-forward ArgoCD UI
task deploy	Deploy all microservices
task delete-all	Delete everything in namespace
task status	Show pod status
task top	Show resource usage
task logs-api	Show API logs
task logs-react	Show React logs
task logs-postgres	Show PostgreSQL logs
task portforward-api	API on localhost:3001
task portforward-react	React on localhost:4321
task exec-postgres	Enter PostgreSQL pod
task restart-api	Restart API deployment
task restart-react	Restart React deployment
task describe-pods	Describe all pods
task events	Show recent events
task setup	Complete setup (cluster + components + deploy)
task destroy	Destroy everything
🔧 Kubernetes Components Explained
Horizontal Pod Autoscaler (HPA)
yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-node-hpa
spec:
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        averageUtilization: 70
Vertical Pod Autoscaler (VPA)
yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: postgres-vpa
spec:
  targetRef:
    kind: StatefulSet
    name: postgres
  updatePolicy:
    updateMode: "Auto"
NetworkPolicy (Zero-Trust)
yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-network-policy
spec:
  podSelector:
    matchLabels:
      app: api-node
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: client-react
    ports:
    - port: 3001
📈 Monitoring with Prometheus
PodMonitors
yaml
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: api-node
spec:
  selector:
    matchLabels:
      app: api-node
  podMetricsEndpoints:
  - port: metrics
    interval: 30s
Custom metrics exposed: Request rate, latency, error rate, active connections

Grafana Dashboards
Pre-configured dashboards:

Node.js API: Request rate, latency (P95/P99), error rate, memory usage

React Frontend: Page views, API call duration

PostgreSQL: Connections, query performance, replication lag

🔄 CI/CD Pipeline (GitHub Actions)
yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
    - name: Build Docker image
    - name: Push to ECR
    - name: Update kustomize manifest

  deploy:
    needs: build-and-push
    runs-on: ubuntu-latest
    steps:
    - name: ArgoCD sync
☁️ Terraform (AWS EKS)
Infrastructure Components
hcl
# VPC with public/private subnets
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
}

# EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
}

# S3 Backend
terraform {
  backend "s3" {
    bucket = "microservices-demo-tfstate"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
Apply Infrastructure
bash
cd 03-terraform-eks

# Copy and edit variables
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars

# Deploy
terraform init
terraform plan
terraform apply
📊 Troubleshooting & Health Checks
Quick Health Check
bash
# Check all pods in namespace
./UsefulScripts/health-check-all.sh

# Collect all logs for debugging
./UsefulScripts/collect-all-logs.sh

# Backup namespace configuration
./UsefulScripts/backup-namespace.sh

# Restore from backup
./UsefulScripts/restore-namespace.sh

# Add monitoring labels to all pods
./UsefulScripts/add-labels-to-all-pods.sh
Common Issues
Issue	Solution
Pods stuck in Pending	Check resources: kubectl top nodes
ImagePullBackOff	Check image name and registry
Database connection refused	Check PostgreSQL is ready: kubectl exec -it postgres-0 -- pg_isready
Ingress not routing	Check ingress controller: kubectl get pods -n ingress-nginx
🗂️ Useful Scripts
Script	Purpose
backup-namespace.sh	YAML backup of all resources
restore-namespace.sh	Restore from backup
collect-all-logs.sh	Collect logs from all pods
health-check-all.sh	Check pod readiness
add-labels-to-all-pods.sh	Bulk label addition
🧹 Cleanup
bash
# Delete everything in microservices-demo namespace
task delete-all

# Destroy Kind cluster
task kind-delete

# Destroy AWS infrastructure
cd 03-terraform-eks
terraform destroy
📚 References
Kubernetes Documentation

ArgoCD Documentation

Prometheus Operator

Terraform AWS EKS Module

📄 License
MIT


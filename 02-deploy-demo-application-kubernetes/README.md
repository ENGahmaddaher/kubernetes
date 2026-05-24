# Deploying the Demo Application on Kubernetes

This section defines kubernetes manifests to deploy:

- React frontend (`client-react`)
- Node.js API (`api-node`)
- PostgreSQL database (StatefulSet with PVC)
- Prometheus + Grafana monitoring (via Helm)
- ArgoCD for GitOps

## Layout

The following shows the layout of this directory:
```
├── ArgoCD.yaml
├── kind-config.yaml
├── 02-deploy-demo-application-kubernetes
│ ├── base
│ │ ├── api-node
│ │ │ ├── Deployment.yaml
│ │ │ ├── Service.yaml
│ │ │ ├── AutoScalingHPA.yaml
│ │ │ ├── NetworkPolicy.yaml
│ │ │ └── PodDisruptionBudget.yaml
│ │ ├── client-react
│ │ │ ├── Deployment.yaml
│ │ │ ├── Service.yaml
│ │ │ └── AutoScalingHPA.yaml
│ │ ├── postgresql
│ │ │ ├── StateFulSet.yaml
│ │ │ ├── HService.yaml
│ │ │ ├── PGSecret.yaml
│ │ │ ├── PGConfigMap.yaml
│ │ │ ├── MigrationSQLJob.yaml
│ │ │ └── AutoScalingVPA.yaml
│ │ ├── monitoring
│ │ │ ├── podmonitor-api.yaml
│ │ │ └── podmonitor-client.yaml
│ │ ├── ingress.yaml
│ │ ├── namespace.yaml
│ │ └── kustomization.yaml
│ └── staging
│ ├── kustomization.yaml
│ └── patches
│ ├── replicas.yaml
│ └── ingress-host.yaml
└── UsefulScripts
├── backup-namespace.sh
├── restore-namespace.sh
├── collect-all-logs.sh
├── health-check-all.sh
└── add-labels-to-all-pods.sh
```

## Breakdown

Helm is used to install:

1. `Prometheus + Grafana` (kube-prometheus-stack)
2. `ArgoCD` (GitOps controller)
3. `Ingress NGINX` (ingress controller)
4. `Metrics Server` (for HPA/VPA)

Each service effectively gets broken down into:

1. `Deployment`: Contains the application with resource limits and probes
2. `Secret`: Contains database credentials
3. `Service`: Internal ClusterIP load balancer routing traffic to the deployment pods
4. `HPA`: Horizontal scaling based on CPU utilization

The database migration is structured as a Kubernetes `Job`.

## Tasks

The top level `Taskfile` provides all necessary commands to deploy the application:
```
❯ task --list-all
task: Available tasks for this project:

kind-create: Create Kind cluster

kind-delete: Delete Kind cluster

install-metrics-server: Install metrics-server for Kind

install-ingress: Install NGINX Ingress Controller

install-argocd: Install ArgoCD

argocd-password: Get ArgoCD admin password

argocd-portforward: Port-forward ArgoCD UI to localhost:8080

deploy: Deploy all microservices to Kind

delete-all: Delete everything in microservices-demo namespace

status: Show status of all pods

top: Show resource usage

logs-api: Show logs of api-node

logs-react: Show logs of client-react

logs-postgres: Show logs of postgres

portforward-api: Port-forward API to localhost:3001

portforward-react: Port-forward React to localhost:4321

exec-postgres: Enter PostgreSQL pod

restart-api: Restart api-node deployment

restart-react: Restart client-react deployment

describe-pods: Describe all pods in namespace

events: Show recent events

setup: Complete setup (cluster + components + deploy)

destroy: Destroy everything
```

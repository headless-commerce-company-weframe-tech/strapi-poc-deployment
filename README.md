# 🚀 Minikube GitOps POC Deployment

This repository bootstraps a complete local Kubernetes POC using Minikube, ArgoCD, and Helm — mirroring a production infrastructure vision based on Rancher and F5 BIG-IP.

---

## 🎯 Purpose

- Deploy and manage shared backend services (Strapi CMS, Mautic CRM)
- Serve separate frontend deployments for each product (News, Health, Travel)
- Use GitOps (ArgoCD) to manage Kubernetes state
- Structure namespaces for scalability and maintainability
- Test components that align with production architecture

---

## 🧱 Core Components

| Component  | Description                    | Namespace    |
|------------|--------------------------------|--------------|
| MariaDB    | Shared DB for Strapi & Mautic | `ed-data`    |
| Strapi     | CMS backend w/ plugins        | `ed-backend` |
| Mautic     | CRM & automation              | `ed-backend` |
| Astro Apps | Frontends (Health, News, Travel) | `ed-frontend` |

---

## 🔁 GitOps Structure

project-root/
├── bootstrap/ # ArgoCD app-of-apps manifest
│ └── app-of-apps.yaml
│
├── environments/poc/ # ArgoCD apps per service
│ ├── namespace.yaml
│ ├── strapi.yaml
│ ├── mautic.yaml
│ ├── mariadb.yaml
│ ├── health-frontend.yaml
│ ├── news-frontend.yaml
│ ├── travel-frontend.yaml
│ └── apache.yaml
│
├── charts/ # Helm charts per app
│ ├── astro/
│ ├── strapi/
│ ├── mautic/
│ └── mariadb/
│
├── docker/ # Custom Dockerfiles
│ ├── strapi/
│ └── astro/
│
├── setup/ # Setup scripts and TLS
│ ├── setup.sh
│ ├── gitops-init.sh
│ └── tls/
│
└── README.md

## 🧪 Local Environment Setup

### ✅ Prerequisites

- WSL2 or Linux VM
- Docker & Minikube
- `kubectl`, `helm`, `mkcert`, `gh` (GitHub CLI)

### ▶️ Quickstart

# Start Minikube with Ingress
minikube start --driver=docker --cpus=4 --memory=8192 --addons=ingress

# Setup namespaces, TLS secret, ArgoCD
./setup/setup.sh

# Push repo to GitHub & bootstrap GitOps
./setup/gitops-init.sh
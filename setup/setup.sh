#!/bin/bash

set -e

# -------------------------
# 🌱 Step 1: Namespace Setup
# -------------------------
echo "📁 Creating namespaces..."

kubectl create namespace ed-data || true
kubectl create namespace ed-backend || true
kubectl create namespace ed-frontend || true
kubectl create namespace argocd || true

# -------------------------
# 🔐 Step 2: TLS Secret Setup
# -------------------------
echo "🔐 Creating TLS secret in ed-frontend..."

kubectl create secret tls local-tls \
  --cert=setup/tls/_wildcard.local.pem \
  --key=setup/tls/_wildcard.local-key.pem \
  -n ed-frontend || echo "⚠️ TLS secret may already exist."

# -------------------------
# 🚀 Step 3: ArgoCD Install
# -------------------------
echo "🚀 Installing ArgoCD..."

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# -------------------------
# 🌐 Step 4: Port-forward ArgoCD UI (optional)
# -------------------------
echo "🌐 To access ArgoCD UI: run the following in a separate terminal:"
echo "    kubectl port-forward svc/argocd-server -n argocd 8080:443"

# -------------------------
# 🔑 Step 5: Print ArgoCD admin password
# -------------------------
echo "🔑 Fetching ArgoCD initial admin password..."
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo

echo "✅ Setup complete."

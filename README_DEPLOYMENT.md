# Deployment (deploy/) — Docker Hub, AWS ECR, and GitHub

This folder contains deployment artifacts and helper scripts.

Contents
- `deploy/k8s/` — Kubernetes manifests
- `deploy/.gitlab-ci.yml` — CI template (adjust variables)
- `deploy/push_dockerhub.sh` — script to build and push images to Docker Hub
- `deploy/push_ecr.sh` — script to build and push images to AWS ECR

Quick notes — Docker Hub

1. Create a Docker Hub repository (e.g., `youruser/congdon-backend` and `youruser/congdon-frontend`).
2. Locally, run:

```bash
export DOCKERHUB_USER=youruser
export DOCKERHUB_PASS=yourpassword
cd <repo-root>
./deploy/push_dockerhub.sh
```

Quick notes — AWS ECR (recommended for AWS deployments)

1. Create an ECR repository or let the script create it. Set AWS credentials and region.

```bash
export AWS_PROFILE=your-profile
export AWS_REGION=us-east-1
export ECR_ACCOUNT=123456789012  # your account ID
./deploy/push_ecr.sh
```

2. After images are in ECR, update `deploy/k8s/*` or use image names with ECR registry and apply manifests.

Deploy to Kubernetes (example, using kubeconfig)

```bash
kubectl apply -f deploy/k8s/
```

CI/CD notes (GitLab)

- Set `DOCKER_REGISTRY`, `CI_REGISTRY_USER`, `CI_REGISTRY_PASSWORD` in CI variables for Docker Hub or registry.
- Set `KUBE_CONFIG` (base64-encoded kubeconfig) in CI variables to allow `kubectl` in the pipeline.

Add project to GitHub

1. Initialize local git (if not already):

```bash
git init
git add .
git commit -m "Initial commit - deployment artifacts"
```

2. Create a GitHub repo (via web UI or `gh`):

```bash
# using GitHub CLI
gh repo create yourusername/your-repo --public --source=. --remote=origin --push

# or manually add remote and push
git remote add origin https://github.com/yourusername/your-repo.git
git branch -M main
git push -u origin main
```

Security & next steps
- Use private registries or private repos for production images.
- Use IAM roles for service accounts (IRSA) when deploying to EKS.
- Add Terraform to provision EKS, VPC, and RDS (I can scaffold this next).
- Add Helm charts for Prometheus/Grafana or install via `helm install kube-prometheus-stack`.

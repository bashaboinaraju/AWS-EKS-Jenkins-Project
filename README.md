# AWS-EKS-Jenkins-Project

This repository is structured for an industry-standard DevOps delivery flow using Terraform, Jenkins, GitHub, Argo CD, and Kubernetes.

## Architecture

- Terraform provisions the AWS EKS cluster, networking, IAM, node groups, and RDS dependencies.
- Jenkins builds container images from the application code and pushes them to Amazon ECR.
- GitHub stores the source code and Kubernetes manifests.
- Argo CD continuously deploys the manifests from Git to the EKS cluster.

## Repository Structure

```text
microservices-project
├── backend
├── frontend
├── k8s-argocd
├── EKS-Terraform
├── Jenkinsfile
├── README.md
└── scripts
```

## Prerequisites

- AWS account with permissions for EKS, ECR, IAM, VPC, and RDS
- Jenkins server with Docker, AWS CLI, kubectl, and Git installed
- GitHub repository with webhook or polling enabled
- Argo CD installed on the EKS cluster
- Terraform installed locally or in CI

## 1. Provision Infrastructure with Terraform

```bash
cd EKS-Terraform
terraform init
terraform plan
terraform apply -auto-approve
```

## 2. Configure Jenkins

Create these Jenkins credentials:

- aws-creds
- aws-account-id
- github-token

The pipeline in [Jenkinsfile](Jenkinsfile) will:

1. Checkout the repository
2. Build backend and frontend images
3. Push images to ECR
4. Update image references in the Kubernetes manifests
5. Push the updated manifests back to GitHub

## 3. Install Argo CD on EKS

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

Create the namespaces:

```bash
kubectl create namespace microservices
kubectl create namespace kube-logging
```

Apply the Argo CD applications:

```bash
kubectl apply -f k8s-argocd/backend/backend.yaml
kubectl apply -f k8s-argocd/frontend/frontend-main.yml
kubectl apply -f k8s-argocd/efk-stack/efk.yaml
```

## 4. Deploy the Application

Once Argo CD is synced, the application will be deployed in the cluster.

Check status:

```bash
kubectl get applications -n argocd
kubectl get pods -n microservices
kubectl get svc -n microservices
```

## 5. Access the Application

Use the ingress or service endpoint exposed by the cluster to access the frontend and backend.

## 6. Optional Database Setup

For RDS or MariaDB initialization:

```bash
sudo dnf install mariadb105-server -y
mysql -h <rds-endpoint> -u admin -p < backend/test.sql
```

## Notes

- Replace the ECR image names and repository URL if your AWS account or GitHub repository differs.
- For production, use separate environments such as dev, staging, and prod with isolated namespaces and Argo CD projects.

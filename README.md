# binelek-infra

Infrastructure as Code for Binelek platform deployment

## Contents

### Terraform
- AWS infrastructure provisioning
- EKS cluster setup
- RDS, Neo4j, Qdrant, Kafka infrastructure
- VPC, subnets, security groups

### Helm Charts
- Kubernetes deployments for all services
- ConfigMaps and Secrets management
- Service discovery configuration

### Docker
- docker-compose.yml for local development
- Dockerfiles for all services
- Multi-stage build configurations

### Kubernetes
- Raw manifests (for reference)
- Ingress configurations
- Network policies

## Quick Start

### Local Development
```bash
# Start all services locally
docker-compose up -d
```

### AWS Deployment
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Kubernetes Deployment
```bash
cd helm
helm install binelek ./binelek-platform
```

## Prerequisites

- Docker & Docker Compose
- Terraform 1.5+
- kubectl
- Helm 3.x
- AWS CLI (for AWS deployments)

## Repository Structure

```
binelek-infra/
├── terraform/        # AWS infrastructure
├── helm/             # Helm charts
├── docker/           # Docker configs
├── kubernetes/       # K8s manifests
└── docs/             # Deployment guides
```

## Documentation

See [docs/](docs/) for:
- Deployment guides
- Architecture diagrams
- Troubleshooting
- Security configurations

## License

MIT License - See [LICENSE](LICENSE)

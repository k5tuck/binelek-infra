# Binelek Infrastructure Guide

This repository contains all infrastructure-as-code, deployment configurations, and operational scripts for the Binelek platform.

## 📁 Repository Structure

```
binelek-infra/
├── kafka-init/          # Kafka topic initialization
│   └── init-topics.sh   # Auto-creates all required Kafka topics
│
├── terraform/           # Infrastructure as Code (AWS, GCP, Azure)
│   ├── modules/         # Reusable Terraform modules
│   ├── environments/    # Environment-specific configs
│   │   ├── dev/
│   │   ├── staging/
│   │   └── production/
│   └── README.md
│
├── kubernetes/          # Kubernetes manifests
│   ├── base/            # Base configurations
│   ├── overlays/        # Kustomize overlays per environment
│   │   ├── dev/
│   │   ├── staging/
│   │   └── production/
│   └── README.md
│
├── helm/                # Helm charts
│   ├── binelek-services/    # Main services chart
│   ├── binelek-monitoring/  # Monitoring stack
│   └── binelek-infrastructure/ # Infrastructure components
│
├── docker/              # Dockerfiles and container configs
│   ├── base-images/     # Custom base images
│   └── README.md
│
├── monitoring/          # Monitoring & Observability
│   ├── prometheus/      # Prometheus configuration
│   ├── grafana/         # Grafana dashboards
│   ├── loki/            # Loki logging
│   └── alerts/          # Alert rules
│
├── scripts/             # Operational scripts
│   ├── check-all-services.sh  # Health check all services
│   ├── deploy-staging.sh      # Deploy to staging
│   ├── deploy-production.sh   # Deploy to production
│   ├── backup-all.sh          # Backup databases
│   └── README.md
│
└── backup/              # Backup configurations (gitignored)
    └── README.md
```

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Terraform >= 1.5
- kubectl >= 1.28
- Helm >= 3.12
- AWS CLI (for AWS deployments)

### Local Development

```bash
# Clone the repository
git clone https://github.com/k5tuck/binelek-infra.git
cd binelek-infra

# Initialize Kafka topics (run from orchestration repo)
docker-compose up -d kafka
docker-compose up kafka-init

# Check service health
./scripts/check-all-services.sh
```

### Production Deployment

```bash
# Deploy infrastructure with Terraform
cd terraform/environments/production
terraform init
terraform plan
terraform apply

# Deploy services with Helm
cd ../../../helm
helm upgrade --install binelek-services ./binelek-services \
  -n production \
  -f values-production.yaml
```

## 📊 Monitoring & Observability

### Metrics Collection

- **Prometheus** - Metrics aggregation
- **Grafana** - Visualization dashboards
- **Loki** - Log aggregation

### Dashboards

Access Grafana dashboards at:
- **Development**: http://localhost:3000
- **Production**: https://monitoring.binelek.com

### Alert Rules

Critical alerts are configured in `monitoring/alerts/`:
- Service health
- Database performance
- Kafka lag
- Error rates

## 🔧 Infrastructure Components

### Kafka Topic Initialization

All Kafka topics are automatically created on startup via `kafka-init/init-topics.sh`:

- **33 topics** for all services
- **3 partitions** per topic (configurable)
- **Replication factor 1** (increase in production)

### Database Management

Database initialization is managed in the **orchestration repository** (`binelek-backend/database/`):

- PostgreSQL schemas
- Neo4j graph initialization
- Seed data

**Why not in infra?**
- Tightly coupled to docker-compose for local development
- Production uses managed databases (RDS, Neo4j AuraDB)
- Different initialization strategies per environment

### Backup Strategy

See `backup/README.md` for comprehensive backup documentation:

- **Daily backups** - 7 day retention
- **Weekly backups** - 4 week retention
- **Monthly backups** - 12 month retention
- **Cross-region replication** (production only)

## 🛠️ Utility Scripts

### Health Checks

```bash
# Check all services and infrastructure
./scripts/check-all-services.sh

# Output:
# ✅ Ontology: Healthy (HTTP 200)
# ✅ Auth: Healthy (HTTP 200)
# ✅ PostgreSQL: Healthy
# ✅ Kafka: Healthy
```

### Deployment

```bash
# Deploy to staging
./scripts/deploy-staging.sh

# Deploy to production (requires approval)
./scripts/deploy-production.sh
```

### Backup & Restore

```bash
# Backup all databases
./scripts/backup-all.sh

# Restore from backup
./scripts/restore-from-backup.sh --date 2025-11-22
```

## 🏗️ Terraform Modules

### Available Modules

- **vpc** - Network infrastructure
- **eks** - Kubernetes cluster
- **rds** - PostgreSQL databases
- **documentdb** - Neo4j-compatible graph database
- **s3** - Object storage
- **cloudfront** - CDN
- **elasticache** - Redis clusters

### Usage Example

```hcl
module "vpc" {
  source = "../../modules/vpc"

  environment = "production"
  cidr_block  = "10.0.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}
```

## ☸️ Kubernetes Deployment

### Environments

- **Development** - Minikube/Docker Desktop
- **Staging** - EKS cluster in us-east-1
- **Production** - Multi-region EKS (us-east-1, eu-west-1)

### Deployment with Kustomize

```bash
# Deploy to staging
kubectl apply -k kubernetes/overlays/staging/

# Deploy to production
kubectl apply -k kubernetes/overlays/production/
```

### Deployment with Helm

```bash
# Install/upgrade services
helm upgrade --install binelek-services ./helm/binelek-services \
  -n production \
  -f values-production.yaml

# Install monitoring stack
helm upgrade --install monitoring ./helm/binelek-monitoring \
  -n monitoring \
  -f values-monitoring.yaml
```

## 🔐 Security

### Secrets Management

- **Development**: `.env` files (gitignored)
- **Staging/Production**: AWS Secrets Manager
- **Kubernetes**: Sealed Secrets

### Network Security

- VPC isolation per environment
- Security groups limit ingress/egress
- WAF for public-facing services
- Private subnets for databases

## 📝 Contributing

### Adding New Infrastructure

1. Create Terraform module in `terraform/modules/`
2. Add to environment configs in `terraform/environments/`
3. Create Kubernetes manifests in `kubernetes/base/`
4. Add monitoring dashboards in `monitoring/grafana/`
5. Update this README

### Testing Changes

```bash
# Test Terraform changes
cd terraform/environments/staging
terraform plan

# Test Kubernetes changes
kubectl apply -k kubernetes/overlays/staging/ --dry-run=client

# Test scripts
./scripts/check-all-services.sh
```

## 🆘 Troubleshooting

### Common Issues

**Issue**: Kafka topics not created
- **Solution**: Check `docker logs binelek-kafka-init`
- **Solution**: Verify Kafka is healthy before running init

**Issue**: Terraform state locked
- **Solution**: `terraform force-unlock <lock-id>`

**Issue**: Kubernetes pods not starting
- **Solution**: `kubectl describe pod <pod-name>`
- **Solution**: Check resource limits and image pull secrets

## 📚 Related Documentation

- [Orchestration Repo](../README.md) - Main repository guide
- [CLAUDE.md](../CLAUDE.md) - AI assistant guide
- [Service Documentation](../docs/developer-site/docs/internal/services/) - Individual services
- [Architecture](../docs/developer-site/docs/internal/ARCHITECTURE.md) - Platform architecture

## 📧 Support

- **Issues**: https://github.com/k5tuck/binelek-infra/issues
- **Team**: infra@binelek.com
- **On-call**: PagerDuty rotation

---

**Last Updated**: 2025-11-22
**Version**: 1.1.0
**Maintained By**: Binelek Infrastructure Team

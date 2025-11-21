# Infrastructure Documentation

Deployment guides, architecture diagrams, and troubleshooting for Binelek infrastructure.

## Documentation Index

### Deployment Guides

- [AWS Deployment Guide](deployment/aws-deployment.md) - Step-by-step AWS setup
- [Kubernetes Deployment](deployment/kubernetes.md) - K8s deployment best practices
- [Local Development Setup](deployment/local-setup.md) - Docker Compose local environment
- [CI/CD Pipeline Setup](deployment/cicd.md) - GitHub Actions workflows

### Architecture

- [Infrastructure Architecture](architecture/overview.md) - High-level architecture
- [Network Architecture](architecture/networking.md) - VPC, subnets, security groups
- [Database Architecture](architecture/databases.md) - PostgreSQL, Neo4j, Redis, Qdrant
- [Kubernetes Architecture](architecture/kubernetes.md) - EKS cluster design

### Security

- [Security Configuration](security/overview.md) - Security best practices
- [Secrets Management](security/secrets.md) - AWS Secrets Manager setup
- [IAM Policies](security/iam.md) - IAM roles and policies
- [Network Security](security/network.md) - Security groups, NACLs

### Monitoring

- [Monitoring Setup](monitoring/setup.md) - Prometheus + Grafana
- [Logging](monitoring/logging.md) - CloudWatch Logs
- [Alerting](monitoring/alerts.md) - Alert rules and notifications
- [Dashboards](monitoring/dashboards.md) - Grafana dashboard templates

### Troubleshooting

- [Common Issues](troubleshooting/common-issues.md) - FAQ and solutions
- [Database Issues](troubleshooting/databases.md) - DB-specific problems
- [Networking Issues](troubleshooting/networking.md) - Connectivity problems
- [Service Issues](troubleshooting/services.md) - Service-specific debugging

### Runbooks

- [Backup and Restore](runbooks/backup-restore.md) - Backup procedures
- [Scaling](runbooks/scaling.md) - Horizontal and vertical scaling
- [Disaster Recovery](runbooks/disaster-recovery.md) - DR procedures
- [Upgrades](runbooks/upgrades.md) - Platform upgrade process

## Quick Reference

### Terraform Commands

```bash
# Initialize
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy infrastructure
terraform destroy
```

### Helm Commands

```bash
# Install
helm install binelek ./charts/binelek-platform

# Upgrade
helm upgrade binelek ./charts/binelek-platform

# Rollback
helm rollback binelek

# Uninstall
helm uninstall binelek
```

### Kubectl Commands

```bash
# Get pods
kubectl get pods -n binelek

# Get logs
kubectl logs -f <pod-name> -n binelek

# Execute command in pod
kubectl exec -it <pod-name> -n binelek -- /bin/bash

# Port forward
kubectl port-forward <pod-name> 8092:8092 -n binelek
```

## Support

For infrastructure support, contact: devops@binelek.com

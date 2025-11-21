# Terraform Infrastructure

Infrastructure as Code for AWS deployment of Binelek platform.

## Directory Structure

```
terraform/
├── modules/              # Reusable Terraform modules
│   ├── vpc/             # VPC configuration
│   ├── eks/             # EKS cluster setup
│   ├── rds/             # RDS PostgreSQL databases
│   ├── neo4j/           # Neo4j deployment
│   ├── kafka/           # Kafka cluster
│   └── qdrant/          # Qdrant vector database
├── environments/
│   ├── dev/             # Development environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/         # Staging environment
│   └── prod/            # Production environment
└── README.md            # This file
```

## Prerequisites

- Terraform 1.5+
- AWS CLI configured
- AWS credentials with appropriate permissions

## Usage

### Development Environment

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Production Environment

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

## Resources Created

- **VPC**: Virtual Private Cloud with public/private subnets
- **EKS**: Kubernetes cluster for service orchestration
- **RDS**: PostgreSQL databases for each service
- **Neo4j**: Graph database (Primary + Data Network)
- **Kafka**: Event streaming platform
- **Qdrant**: Vector database for embeddings
- **Redis**: Caching layer
- **S3**: Object storage for artifacts
- **CloudWatch**: Logging and monitoring

## Terraform State

State is stored in S3 backend with DynamoDB locking for safety.

## Security

- All databases in private subnets
- Security groups restrict access
- Secrets managed via AWS Secrets Manager
- IAM roles follow least privilege principle

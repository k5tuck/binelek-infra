# Helm Charts

Kubernetes deployments for Binelek platform services.

## Directory Structure

```
helm/
├── charts/
│   ├── binelek-platform/     # Umbrella chart for all services
│   ├── binah-api/             # Individual service charts
│   ├── binah-auth/
│   ├── binah-ontology/
│   ├── binah-pipeline/
│   ├── binah-context/
│   ├── binah-search/
│   ├── binah-aip/
│   ├── binah-ml/
│   ├── binah-billing/
│   ├── binah-webhooks/
│   ├── binah-regen/
│   ├── binah-domain-registry/
│   ├── binah-governance/
│   ├── binah-bridge/
│   └── binah-discovery/
└── README.md                  # This file
```

## Prerequisites

- Kubernetes cluster (EKS, GKE, or local)
- Helm 3.x installed
- kubectl configured

## Usage

### Install Platform (All Services)

```bash
helm install binelek ./charts/binelek-platform \
  --namespace binelek \
  --create-namespace \
  --values values-prod.yaml
```

### Install Individual Service

```bash
helm install binah-api ./charts/binah-api \
  --namespace binelek \
  --values values-prod.yaml
```

### Upgrade Service

```bash
helm upgrade binah-api ./charts/binah-api \
  --namespace binelek
```

### Uninstall

```bash
helm uninstall binelek --namespace binelek
```

## Configuration

Each chart has a `values.yaml` file with configurable parameters:

- **Image**: Docker image repository and tag
- **Resources**: CPU/memory requests and limits
- **Replicas**: Number of pod replicas
- **Environment**: Environment variables
- **Secrets**: References to Kubernetes secrets
- **Ingress**: Ingress configuration
- **Service**: Service type and ports

## Environment-Specific Values

- `values-dev.yaml` - Development configuration
- `values-staging.yaml` - Staging configuration
- `values-prod.yaml` - Production configuration

## Dependencies

The umbrella chart `binelek-platform` includes all service dependencies and manages deployment order.

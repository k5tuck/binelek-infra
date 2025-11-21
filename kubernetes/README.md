# Kubernetes Manifests

Raw Kubernetes manifests for Binelek platform (for reference or direct deployment).

## Directory Structure

```
kubernetes/
├── manifests/
│   ├── namespaces/          # Namespace definitions
│   ├── configmaps/          # ConfigMaps for services
│   ├── secrets/             # Secret templates (not committed)
│   ├── deployments/         # Deployment manifests
│   ├── services/            # Service definitions
│   ├── ingress/             # Ingress controllers and rules
│   ├── networkpolicies/     # Network policy definitions
│   ├── rbac/                # RBAC roles and bindings
│   └── monitoring/          # Prometheus/Grafana configs
└── README.md                # This file
```

## Usage

**Note:** Helm charts (in `../helm/`) are the recommended deployment method. These raw manifests are provided for:
- Reference
- Custom deployments
- CI/CD pipelines
- Advanced use cases

### Apply All Manifests

```bash
kubectl apply -f manifests/namespaces/
kubectl apply -f manifests/configmaps/
kubectl apply -f manifests/secrets/
kubectl apply -f manifests/deployments/
kubectl apply -f manifests/services/
kubectl apply -f manifests/ingress/
```

### Apply Individual Service

```bash
kubectl apply -f manifests/deployments/binah-api.yaml
kubectl apply -f manifests/services/binah-api.yaml
```

## Network Policies

Network policies enforce security boundaries:
- Services only communicate with required dependencies
- External access restricted to API Gateway
- Database access limited to authorized services

## Ingress

Ingress configuration includes:
- TLS termination
- Path-based routing
- Rate limiting
- CORS configuration

## Monitoring

Prometheus ServiceMonitor and Grafana dashboards for:
- Service health metrics
- Request rates and latencies
- Database connection pools
- Kafka consumer lag
- Neo4j query performance

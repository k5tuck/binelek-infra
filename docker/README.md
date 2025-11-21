# Docker Configuration

Docker and Docker Compose configurations for local development.

## Directory Structure

```
docker/
├── docker-compose.yml           # Main compose file (all services)
├── docker-compose.infra.yml     # Infrastructure only
├── docker-compose.services.yml  # Services only
├── .env.example                 # Environment variables template
├── dockerfiles/                 # Custom Dockerfiles
│   ├── binah-api.Dockerfile
│   ├── binah-auth.Dockerfile
│   └── ... (one per service)
└── README.md                    # This file
```

## Quick Start

### Start All Services

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your configuration
nano .env

# Start everything
docker-compose up -d
```

### Start Infrastructure Only

```bash
docker-compose -f docker-compose.infra.yml up -d
```

This starts:
- PostgreSQL
- Neo4j (Primary + Data Network)
- Kafka + Zookeeper
- Redis
- Qdrant
- Elasticsearch
- MLflow
- Prometheus
- Grafana

Then run services locally for development.

### Start Individual Service

```bash
docker-compose up -d binah-api
docker-compose up -d binah-auth
```

## Health Checks

Check service health:

```bash
# All services
docker-compose ps

# Specific service logs
docker-compose logs -f binah-api

# Health check endpoint
curl http://localhost:8092/health
```

## Ports

| Service | Port | Purpose |
|---------|------|---------|
| PostgreSQL | 5432 | Database |
| Neo4j Primary | 7474, 7687 | Graph DB |
| Neo4j Data Network | 7475, 7688 | Analytics Graph |
| Kafka | 9092 | Event streaming |
| Redis | 6379 | Caching |
| Qdrant | 6333 | Vector search |
| binah-api | 8092 | API Gateway |
| binah-auth | 8093 | Authentication |
| binah-ontology | 8091 | Knowledge graph |
| ... | ... | (See services/overview.md) |

## Multi-Stage Builds

All Dockerfiles use multi-stage builds:
- **Build stage**: Compile and build application
- **Runtime stage**: Minimal image with only runtime dependencies

Benefits:
- Smaller image sizes
- Faster deployments
- Better security

## Development vs Production

- **Development**: Mount source code as volumes for hot-reload
- **Production**: Copy built artifacts into image

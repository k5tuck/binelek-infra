# Monitoring Configuration

This directory contains monitoring and observability configurations for the Binelek platform.

## Contents

- **prometheus/** - Prometheus configuration
- **grafana/** - Grafana dashboards
- **loki/** - Loki logging configuration
- **alerts/** - Alert rules

## Services Monitored

- All microservices (health, metrics, traces)
- PostgreSQL
- Neo4j
- Kafka
- Qdrant
- Elasticsearch

## Usage

### Local Development

```bash
docker-compose -f monitoring/docker-compose.monitoring.yml up -d
```

### Production

Monitoring is deployed via Helm charts in `../helm/binelek-monitoring/`

## Dashboards

- **System Overview** - Overall platform health
- **Service Metrics** - Per-service performance
- **Database Metrics** - PostgreSQL, Neo4j health
- **Kafka Metrics** - Event streaming health
- **AI Metrics** - ML model performance

## Alerts

Critical alerts are sent to:
- Email
- Slack
- PagerDuty (production only)

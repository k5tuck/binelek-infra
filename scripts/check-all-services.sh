#!/bin/bash
# Health Check Script for All Binelek Services
# Verifies that all microservices and infrastructure are healthy

set -e

SERVICES=(
  "http://localhost:8091/health:Ontology"
  "http://localhost:8092/health:API Gateway"
  "http://localhost:8093/health:Auth"
  "http://localhost:8094/health:Pipeline"
  "http://localhost:8095/health:Billing"
  "http://localhost:8096/health:Context"
  "http://localhost:8097/health:Search"
  "http://localhost:8098/health:Webhooks"
  "http://localhost:8100/health:AIP"
  "http://localhost:8101/health:Domain Registry"
  "http://localhost:8102/health:ML Service"
)

INFRA=(
  "http://localhost:5432:PostgreSQL"
  "http://localhost:7474:Neo4j"
  "http://localhost:6333:Qdrant"
  "http://localhost:9200:Elasticsearch"
  "http://localhost:9092:Kafka"
)

echo "🔍 Checking Binelek Services..."
echo ""

FAILED=0

# Check services
for service in "${SERVICES[@]}"; do
  URL="${service%%:*}"
  NAME="${service##*:}"

  printf "%-20s " "$NAME:"

  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL" 2>/dev/null || echo "000")

  if [ "$HTTP_CODE" -eq 200 ]; then
    echo "✅ Healthy (HTTP $HTTP_CODE)"
  else
    echo "❌ Unhealthy (HTTP $HTTP_CODE)"
    FAILED=$((FAILED + 1))
  fi
done

echo ""
echo "🔧 Checking Infrastructure..."
echo ""

# Check infrastructure (basic connectivity)
for infra in "${INFRA[@]}"; do
  URL="${infra%%:*}"
  NAME="${infra##*:}"

  printf "%-20s " "$NAME:"

  # Just check if port is open (different check for each)
  case $NAME in
    "PostgreSQL")
      if docker exec binelek-postgres pg_isready -U postgres > /dev/null 2>&1; then
        echo "✅ Healthy"
      else
        echo "❌ Unhealthy"
        FAILED=$((FAILED + 1))
      fi
      ;;
    "Neo4j")
      if curl -s "$URL" > /dev/null 2>&1; then
        echo "✅ Healthy"
      else
        echo "❌ Unhealthy"
        FAILED=$((FAILED + 1))
      fi
      ;;
    "Kafka")
      if docker exec binelek-kafka kafka-broker-api-versions --bootstrap-server localhost:9092 > /dev/null 2>&1; then
        echo "✅ Healthy"
      else
        echo "❌ Unhealthy"
        FAILED=$((FAILED + 1))
      fi
      ;;
    *)
      if curl -s "$URL" > /dev/null 2>&1; then
        echo "✅ Healthy"
      else
        echo "❌ Unhealthy"
        FAILED=$((FAILED + 1))
      fi
      ;;
  esac
done

echo ""
if [ $FAILED -eq 0 ]; then
  echo "✅ All systems operational!"
  exit 0
else
  echo "❌ $FAILED service(s) unhealthy"
  exit 1
fi

#!/bin/bash
# Kafka Topic Initialization Script
# Creates all required Kafka topics on startup

set -e

echo "Waiting for Kafka to be ready..."
while ! kafka-broker-api-versions --bootstrap-server kafka:9092 > /dev/null 2>&1; do
  echo "Kafka not ready yet, waiting..."
  sleep 2
done

echo "Kafka is ready! Creating topics..."

# Function to create topic if it doesn't exist
create_topic() {
  local topic=$1
  local partitions=${2:-3}
  local replication=${3:-1}

  echo "Creating topic: $topic (partitions: $partitions, replication: $replication)"
  kafka-topics --create \
    --bootstrap-server kafka:9092 \
    --topic "$topic" \
    --partitions "$partitions" \
    --replication-factor "$replication" \
    --if-not-exists || true
}

# ============================================================================
# ONTOLOGY SERVICE TOPICS
# ============================================================================
echo "Creating ontology service topics..."
create_topic "binah.ontology.entity.created" 3 1
create_topic "binah.ontology.entity.updated" 3 1
create_topic "binah.ontology.entity.deleted" 3 1
create_topic "binah.ontology.relationship.created" 3 1
create_topic "binah.ontology.relationship.updated" 3 1
create_topic "binah.ontology.relationship.deleted" 3 1

# Versioned topics (for event-driven consumers)
create_topic "ontology.entity.created.v1" 3 1
create_topic "ontology.entity.updated.v1" 3 1
create_topic "ontology.entity.deleted.v1" 3 1
create_topic "ontology.relationship.created.v1" 3 1
create_topic "ontology.relationship.updated.v1" 3 1
create_topic "ontology.relationship.deleted.v1" 3 1

# ============================================================================
# GENERAL EVENT TOPICS (Capital B for backward compatibility)
# ============================================================================
echo "Creating general event topics..."
create_topic "Binah.ontology.events" 3 1
create_topic "Binah.context.events" 3 1
create_topic "Binah.integration.events" 3 1
create_topic "Binah.pipeline.events" 3 1
create_topic "Binah.search.events" 3 1
create_topic "Binah.billing.events" 3 1
create_topic "Binah.webhooks.events" 3 1

# ============================================================================
# PIPELINE SERVICE TOPICS
# ============================================================================
echo "Creating pipeline service topics..."
create_topic "binah.pipeline.execution.started" 3 1
create_topic "binah.pipeline.execution.completed" 3 1
create_topic "binah.pipeline.execution.failed" 3 1

# ============================================================================
# CONTEXT SERVICE TOPICS
# ============================================================================
echo "Creating context service topics..."
create_topic "binah.context.embedding.created" 3 1
create_topic "binah.context.enrichment.completed" 3 1

# ============================================================================
# SEARCH SERVICE TOPICS
# ============================================================================
echo "Creating search service topics..."
create_topic "binah.search.index.created" 3 1
create_topic "binah.search.index.updated" 3 1

# ============================================================================
# BILLING SERVICE TOPICS
# ============================================================================
echo "Creating billing service topics..."
create_topic "binah.billing.subscription.created" 3 1
create_topic "binah.billing.subscription.updated" 3 1
create_topic "binah.billing.invoice.created" 3 1

# ============================================================================
# WEBHOOKS SERVICE TOPICS
# ============================================================================
echo "Creating webhooks service topics..."
create_topic "binah.webhooks.delivery.succeeded" 3 1
create_topic "binah.webhooks.delivery.failed" 3 1

echo ""
echo "✅ All topics created successfully!"
echo ""
echo "Listing all topics:"
kafka-topics --list --bootstrap-server kafka:9092

echo ""
echo "Topic initialization complete!"

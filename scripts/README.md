# Infrastructure Scripts

Utility scripts for infrastructure management, deployment, and maintenance.

## Scripts

### Health Checks
- **check-all-services.sh** - Verify all services are healthy
- **check-databases.sh** - Verify database connectivity

### Deployment
- **deploy-staging.sh** - Deploy to staging environment
- **deploy-production.sh** - Deploy to production
- **rollback.sh** - Rollback to previous version

### Backup & Restore
- **backup-all.sh** - Backup all databases
- **restore-from-backup.sh** - Restore from backup
- **snapshot-neo4j.sh** - Create Neo4j snapshot

### Development
- **reset-local-env.sh** - Reset local development environment
- **seed-test-data.sh** - Load test data

## Usage

```bash
# Make scripts executable
chmod +x scripts/*.sh

# Run a script
./scripts/check-all-services.sh
```

## Environment Variables

Scripts expect these environment variables:
- `ENVIRONMENT` - development, staging, production
- `BACKUP_DIR` - Backup storage location
- `AWS_REGION` - AWS region (for S3 backups)

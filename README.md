# Paperless-ngx Helm Chart

This Helm chart deploys Paperless-ngx, a document management system that processes and categorizes your physical documents.

## Components

- **Webserver**: The Paperless-ngx application
- **Database**: PostgreSQL for data storage (deployed as StatefulSet)
- **Redis**: Used as a broker/cache

## Installation

```bash
# From the paperless-chart directory
helm install paperless .
```

## Configuration

Edit the `values.yaml` file to customize the deployment. Key configurations:

### Storage

All components use persistent storage by default:

- `persistence.data`: Document data
- `persistence.media`: Media files
- `persistence.consume`: Consumption directory
- `persistence.export`: Export directory  
- `postgres.persistence`: PostgreSQL data
- `redis.persistence`: Redis data

### Web Server

```yaml
webserver:
  image:
    repository: ghcr.io/paperless-ngx/paperless-ngx
    tag: latest
  service:
    type: ClusterIP
    port: 8000
  env:
    # Additional environment variables beyond PAPERLESS_REDIS and PAPERLESS_DBHOST
    PAPERLESS_OCR_LANGUAGE: "eng+fra"  # Example of adding French language support
```

Common environment variables are set in the configmap:

```yaml
# In templates/configmap.yaml
data:
  PAPERLESS_TIME_ZONE: "UTC"
  PAPERLESS_CONSUMER_POLLING: "60"
  PAPERLESS_OCR_LANGUAGE: "eng"
```

### PostgreSQL (StatefulSet)

PostgreSQL is deployed as a StatefulSet for better data consistency and reliability:

```yaml
postgres:
  podManagementPolicy: OrderedReady  # or Parallel
  updateStrategy:
    type: RollingUpdate
  securityContext:
    fsGroup: 999
    runAsUser: 999
  env:
    POSTGRES_DB: paperless
    POSTGRES_USER: paperless
    POSTGRES_PASSWORD: paperless
    PGDATA: /var/lib/postgresql/data/postgres
  persistence:
    enabled: true
    storageClass: ""
    size: 10Gi
```

## Security Note

For production use, you should:

1. Set proper passwords for the database
2. Consider using Kubernetes secrets for sensitive data
3. Use specific image tags rather than 'latest'
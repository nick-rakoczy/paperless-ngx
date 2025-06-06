# OpenCode Context for paperless-ngx Helm Chart

## Project Overview
This repository contains a Helm chart for deploying Paperless-ngx, a document management system. It includes configurations for the webserver, PostgreSQL database, and Redis.

## Build & Deployment Commands
- Package the chart: `make paperless-ngx-0.1.0.tgz` or `helm package .`
- Install the chart: `helm install paperless .` (from the chart directory)
- Push to OCI registry: `make install` or `helm push paperless-ngx-0.1.0.tgz oci://registry/library`

## Code Style & Conventions (Kubernetes YAML)
- **Indentation**: Use 2 spaces for indentation in YAML files.
- **Naming**: Follow Kubernetes naming conventions (e.g., lowercase, use hyphens for separation).
- **Secrets**: For production, use Kubernetes secrets for sensitive data like passwords. Avoid hardcoding them directly in `values.yaml` or templates.
- **Image Tags**: Use specific image tags instead of `latest` for production deployments to ensure stability.
- **Resource Management**: Define resource requests and limits for containers.
- **Comments**: Use comments in `values.yaml` to explain non-obvious configurations.
- **Helm Templating**: Utilize Helm's templating functions and variables effectively. Prefer built-in Helm objects where possible.
- **ConfigMaps**: Store non-sensitive configuration data in ConfigMaps.
- **StatefulSets**: Use StatefulSets for stateful applications like PostgreSQL.
- **Persistence**: Clearly define and document persistent volume claims.

## Testing (Helm)
- Lint the chart: `helm lint .`
- Test the chart deployment (dry run): `helm install --dry-run --debug paperless .`
- To test a specific template or rendered output, you can use: `helm template . > rendered-chart.yaml` and inspect the output.

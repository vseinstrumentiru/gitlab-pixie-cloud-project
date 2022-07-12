# Pixie-cloud
Pixie Cloud is Pixie's control plane for serving Pixie's API and UI, and managing and tracking metadata (e.g. orgs, users, Viziers).\
[Check out Pixie's architecture here.](https://docs.px.dev/reference/architecture/)
## Requirements
Kubernetes v1.16+ is required.
## Dependencies
Pixie Cloud uses Elasticsearch 7 and PostgreSQL for saving its state. This chart installs non-HA versions of them by default using helm dependencies. This can be tweaked. \
You can also use external clusters. 
## Installation
https://docs.px.dev/installing-pixie/requirements/
1. Install dependencies:
```console
helm dependency update
```
2. Generate necessary secrets using `cloud_secrets.sh` or manually
3. Install the chart:
```console
helm install pixie-cloud ./ --namespace plc --create-namespace
```
## Notes
- This chart by default tries to set up nginx ingress, and get HTTPS certificate from Let’s Encrypt using route53 challenge, you can disable them both.
- You can assign components to specific nodes using corresponding `nodeSelector` and `tolerations` values.

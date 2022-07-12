# Pixie-cloud 
This is the sample Gitlab project to deploy [Pixie Cloud](https://github.com/pixie-io/pixie/tree/main/k8s/cloud) to a k8s cluster using the official Helm terraform provider.
## Usage
This is a Gitlab project with a sample CI/CD configuration which can be run as a [Gitlab CI/CD project](https://docs.gitlab.com/ee/ci/). It uses Terraform, and basically can be run as an ordinary terraform project:
```console
$ cd ./deployment/local
$ terraform init
$ terraform plan
$ terraform apply
```
There are several variables to configure:

| Variable | Type | Default | Comment |
| ------ | ------ | -------  | ---------- |
| config_path | string | ~/.kube/config | kubeconfig path |
| pixie_cloud_ns | string | plc | namespace to deploy chart to |
| domain_name | string | dev.withpixie.dev | Pixie Cloud domain name |
| stan_storage_class | string | "" | *STAN persistent volume storage class (if ommited, "standard" will be used) |
| cloud_components_node_selector | object{label, value} | null | node selector for Pixie Cloud components |
| cloud_components_tolerations | list(object{effect, key, value}) | null |  tolerations for Pixie Cloud components |
| postgresql_storage_class | string | "" | PostgreSQL persistent volume storage class (if ommited, "standard" will be used) |
| postgresql_node_selector | object{label, value} | null | node selector for PostgreSQL deployed with dependent chart |
| postgresql_tolerations | list(object{effect, key, value}) | null |  tolerations for PostgreSQL deployed with dependent chart |
| elasticsearch_storage_class | string | "" | Elasticsearch persistent volume storage class (if ommited, "standard" will be used) |
| elasticsearch_node_selector | object{label= string, value = string} | null | node selector for Elasticsearch DB deployed with dependent chart |
| elasticsearch_tolerations | list(object({effect = string, key = string, value = string})) | null |  tolerations for Elasticsearch DB deployed with dependent chart |

***NATS/STAN**: The Cloud's message bus system for distributing messages between services in Pixie Clouds. STAN is addtionally used for any messages that may need persistence.

Helm chart used by this project installs non-HA versions of Elasticsearch and PostgreSQL by default using helm dependencies. 

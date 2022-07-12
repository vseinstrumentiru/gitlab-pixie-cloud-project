terraform {
  backend "local" {
  }
}

module "main-local" {
  source           = "../../modules/main"
  config_path      = var.config_path
  config_context   = "default"
  pixie_cloud_ns   = var.pixie_cloud_ns
  domain_name      = var.domain_name
  cloud_components_node_selector = var.cloud_components_node_selector
  cloud_components_tolerations = var.cloud_components_tolerations
  stan_storage_class = var.stan_storage_class
  postgresql_storage_class = var.postgresql_storage_class
  postgresql_node_selector = var.postgresql_node_selector
  postgresql_tolerations = var.postgresql_tolerations
  elasticsearch_storage_class = var.elasticsearch_storage_class
  elasticsearch_node_selector = var.elasticsearch_node_selector
  elasticsearch_tolerations = var.elasticsearch_tolerations
}

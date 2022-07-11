terraform {
  backend "http" {
  }
}

module "main-local" {
  source           = "../../modules/main"
  config_path      = var.config_path
  config_context   = "prod"
  pixie_cloud_ns   = var.pixie_cloud_ns
  domain_name      = var.domain_name
}

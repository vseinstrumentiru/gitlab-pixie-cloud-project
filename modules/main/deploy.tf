module "pixie_cloud" {
  source = "../../modules/pixie-cloud"

  pixie_cloud_ns   = var.pixie_cloud_ns
  domain_name = var.domain_name
}

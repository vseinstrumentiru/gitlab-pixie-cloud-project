provider "helm" {
  kubernetes {
    config_path    = var.config_path
    config_context = var.config_context
  }
}

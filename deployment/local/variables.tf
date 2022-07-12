variable "config_path" {
  type = string
  default = "~/.kube/config"
}
variable "pixie_cloud_ns" {
  type    = string
  default = "plc"
}
variable "domain_name" {
  type = string
  default = "dev.withpixie.dev"
}
variable "cloud_components_node_selector" {
  type = object({
    label = string
    value  = string
  })
  default = null
}
variable "cloud_components_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = null
}
variable "stan_storage_class" {
  type = string
  default = ""
}
variable "postgresql_storage_class" {
  type = string
  default = ""
}
variable "postgresql_node_selector" {
  type = object({
    label = string
    value  = string
  })
  default = null
}
variable "postgresql_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = null
}
variable "elasticsearch_storage_class" {
  type = string
  default = ""
}
variable "elasticsearch_node_selector" {
  type = object({
    label = string
    value  = string
  })
  default = null
}
variable "elasticsearch_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = null
}
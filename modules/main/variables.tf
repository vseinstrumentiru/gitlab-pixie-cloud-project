variable "config_path" {
  type = string
}
variable "config_context" {
  type = string
}
variable "pixie_cloud_ns" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "cloud_components_node_selector" {
  type = object({
    label = string
    value  = string
  })
}
variable "cloud_components_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
}
variable "stan_storage_class" {
  type = string
}
variable "postgresql_storage_class" {
  type = string
}
variable "postgresql_node_selector" {
  type = object({
    label = string
    value  = string
  })
}
variable "postgresql_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
}
variable "elasticsearch_storage_class" {
  type = string
}
variable "elasticsearch_node_selector" {
  type = object({
    label = string
    value  = string
  })
}
variable "elasticsearch_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
}
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
  default = {
    label = "dedicated"
    value = "px"
  }
}
variable "cloud_components_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = [
    {
      "effect" = "NoExecute"
      "key"    = "dedicated"
      "value"  = "px"
    }
  ]
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
  default = {
    label = "dedicated"
    value = "px"
  }
}
variable "postgresql_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = [
    {
      "effect" = "NoExecute"
      "key"    = "dedicated"
      "value"  = "px"
    }
  ]
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
  default = {
    label = "dedicated"
    value = "px"
  }
}
variable "elasticsearch_tolerations" {
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = [
    {
      "effect" = "NoExecute"
      "key"    = "dedicated"
      "value"  = "px"
    }
  ]
}
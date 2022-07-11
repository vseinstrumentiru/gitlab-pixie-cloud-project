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
  default = "pixie.mydomain.dev"
}

terraform {
  required_version = ">= 1.2.4"

  required_providers {
    helm       = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
    null       = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

terraform {
  required_version = "1.4.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.72.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "=3.5.1"
    }
  }

  backend "remote" {
    organization = "osafune-cho"
    workspaces {
      name = "coco-infrastructure"
    }
  }
}

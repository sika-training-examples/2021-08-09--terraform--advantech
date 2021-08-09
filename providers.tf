terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.71.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "null" {}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.12"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
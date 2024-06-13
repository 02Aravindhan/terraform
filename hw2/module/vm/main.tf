terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}
provider "azurerm" {
  features {}
}
data "azurerm_resource_group" "rg" {
    name="project2"
  
}
resource "azurerm_" "name" {
  
}
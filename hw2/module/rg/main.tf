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
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "vnet" {
   name=var.vnetname
   resource_group_name=azurerm_resource_group.rg.name
   location=azurerm_resource_group.rg.location
   addres_space=var.adresspace
  
} 
resource "azurerm_subnet" "subnet" {
  name = var.subnet
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name=azurerm_virtual_network.vnet.name
  
  depends_on = [ azurerm_virtual_network .vnet ]
}

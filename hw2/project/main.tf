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
variable "resource_group_name" {
    type = string
    default = "project2"
  
}
variable "location" {
    type = string
    default = "east asia"
}
variable "vnet" {
  type = string
  default = "vnet"
  
}

variable"addresspace"{
  type = string
  default = "10.0.0.0/16"
}
variable "subnet" {
  type = string
  default = "subnet"
  
}

  
module "rg" {
    source = "../module/rg"
    resource_group_name=var.resource_group_name
    location = var.location
    azurerm_virtual_network=var.vnet
    addres_space=var.adresspace
    subnet = var.subnet
    
}
 


  
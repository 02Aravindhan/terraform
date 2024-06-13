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
data"azurerm_resource_group" "rg"{
    name="aravindh-rg"
}
resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets
  name  =each.key
  address_space = [ each.value.address_space ]
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location

  dynamic "subnet"{
    for_each = each.value.subnets

  content {
       name           = subnet.value.name
      address_prefix = cidrsubnet(each.value.address_space, subnet.value.newbits, subnet.value.netnum)
    }
  }
   depends_on = [data.azurerm_resource_group.rg]
    
}
resource "azurerm_network_security_group" "nsg" {
  for_each = toset(local.nsg_name)

  name                = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  dynamic "security_rule" {
    for_each = { for rule in local.csv : rule.name => rule }
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  for_each = { for idx, subnet_id in flatten([for vnet in local.vnet_ids : vnet]) : idx => subnet_id }

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nsg[local.nsg_name[each.key]].id

  depends_on = [azurerm_network_security_group.nsg]
}


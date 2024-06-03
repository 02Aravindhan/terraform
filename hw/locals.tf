locals {
  count=4
  csv = csvdecode(file(var.rules))
  nsg_name=[for i in range (local.count) : "subnet${i}"]

        vnet_ids = {
    for vnet_key, vnet_val in azurerm_virtual_network.vnet:
    vnet_key => [for subnet in vnet_val.subnet : subnet.id]
  
  }


}


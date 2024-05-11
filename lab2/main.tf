terraform{
    required_providers {
      azurerm={
        source = "hashipcorp/azurerm"
        version = "~>3.0.2"
      }
    }
    required_version = ">=1.1.0"
}
provider"azurerm"{
    featureas{}
}
resource"azurerm_resource_group""rg"{
    name=var.rgn
    location=var.loc
}
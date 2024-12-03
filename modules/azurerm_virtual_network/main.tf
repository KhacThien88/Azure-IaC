resource "azurerm_virtual_network" "vmn" {
  name                = var.virtual-network-name
  # address_space       = ["172.20.0.0/16"]
  address_space = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.name_rg
}
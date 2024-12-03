resource "azurerm_subnet" "sub" {
  name                 = var.subnet-name
  resource_group_name  = var.name_rg
  virtual_network_name = var.virtual-network-name
  address_prefixes     = ["10.0.1.0/24"]
}
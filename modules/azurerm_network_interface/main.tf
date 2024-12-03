resource "azurerm_network_interface" "ni" {
  name                = var.networkInterface_name
  resource_group_name = var.name_rg
  location            = var.location
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.idsub
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.publicip
  }
}

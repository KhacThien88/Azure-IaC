resource "azurerm_public_ip" "app_public_ip" {
  name           = var.publicip_name
  resource_group_name = var.name_rg
  location       = var.location
  allocation_method   = "Static"    
}
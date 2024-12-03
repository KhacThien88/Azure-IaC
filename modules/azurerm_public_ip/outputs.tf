output "public_ip_address_ip_id" {
   value = azurerm_public_ip.app_public_ip.id
}
output "public_ip" {
  value = azurerm_public_ip.app_public_ip.ip_address
}
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.name_vm
  resource_group_name = var.name_rg
  location            = var.location
  size                = var.VMSize
  admin_username      = "adminuser"
  admin_password      = "111111aA@"
  disable_password_authentication = false
  network_interface_ids = [
    var.idsub,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = {
    environment = var.environment
  }
}
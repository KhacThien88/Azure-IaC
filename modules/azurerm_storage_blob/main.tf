resource "azurerm_storage_blob" "state_blob" {
  name                   = "Blob-Storage-Account"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  source_content         = "Initial state content"
}

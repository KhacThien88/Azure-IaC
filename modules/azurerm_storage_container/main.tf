
resource "azurerm_storage_container" "tf-container" {
  name = "tf-state"
  storage_account_id = var.tf_state_id
  container_access_type = "private"
  lifecycle {
    prevent_destroy = true
  }
}

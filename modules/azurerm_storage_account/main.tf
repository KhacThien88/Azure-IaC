resource "azurerm_storage_account" "tf_state" {
  name = "tfstorage15122004"
  location = var.location
  resource_group_name = var.name_rg
  account_tier = "Standard"
  account_replication_type = "LRS"
}
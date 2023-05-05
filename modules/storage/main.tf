resource "azurerm_storage_account" "this" {
  name                     = "tfbugtest${var.suffix}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_management_lock" "this" {
  name       = "${azurerm_storage_account.this.name}-no-delete"
  scope      = azurerm_storage_account.this.id
  lock_level = "CanNotDelete"
}

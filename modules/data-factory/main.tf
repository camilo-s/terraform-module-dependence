resource "azurerm_data_factory" "this" {
  name                = "adf-tfbugtest-${var.suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "this" {

  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_data_factory.this.identity[0].principal_id
  description          = "Some description"
}

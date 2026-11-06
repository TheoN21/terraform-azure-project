data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "team" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.existing.name
  location                 = data.azurerm_resource_group.existing.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "team" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.team.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "terraform_blob_access" {
  scope                = azurerm_storage_account.team.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.user_object_id
  principal_type       = "User"
}
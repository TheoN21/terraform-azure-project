# Resource Group
resource "azurerm_resource_group" "resourcegroup_terraform_ref" {
  name     = var.resource_group_name
  location = var.location
}

# Managed Identity (User assigned)
resource "azurerm_user_assigned_identity" "managed_identity_terraform_ref" {
  name                = var.managed_identity_name
  location            = azurerm_resource_group.resourcegroup_terraform_ref.location
  resource_group_name = azurerm_resource_group.resourcegroup_terraform_ref.name
}

# Client config needed for Key Vault
data "azurerm_client_config" "current" {}

# Key Vault Storage
resource "azurerm_key_vault" "keyvault_terraform_ref" {
  name                       = var.key_vault_name
  location                   = azurerm_resource_group.resourcegroup_terraform_ref.location
  resource_group_name        = azurerm_resource_group.resourcegroup_terraform_ref.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  rbac_authorization_enabled = true
}


# Logic App
resource "azurerm_logic_app_workflow" "logic_app_terraform_ref" {
  name                = var.logic_app_name
  location            = azurerm_resource_group.resourcegroup_terraform_ref.location
  resource_group_name = azurerm_resource_group.resourcegroup_terraform_ref.name
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.managed_identity_terraform_ref.id
    ]
  }
}

# Role Assignment of Managed Identity to be Key Vault Secrets User
resource "azurerm_role_assignment" "kv_secrets_user_terraform_ref" {
  scope                = azurerm_key_vault.keyvault_terraform_ref.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.managed_identity_terraform_ref.principal_id
}



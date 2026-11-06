variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Austria East"
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "managed_identity_name" {
  description = "User Assigned Managed Identity name"
  type        = string
}

variable "key_vault_name" {
  description = "Key Vault name"
  type        = string
}

variable "logic_app_name" {
  description = "Logic App name"
  type        = string
}
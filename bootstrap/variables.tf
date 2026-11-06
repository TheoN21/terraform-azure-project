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
  description = "Name of the existing Resource Group"
  type        = string
}

variable "storage_account_name" {
  description = "Storage Account name for Terraform State"
  type        = string
}

variable "container_name" {
  description = "Name of the Storage Container for Terraform State"
  type        = string
}

variable "user_object_id" {
  description = "Object ID of the user running Terraform"
  type        = string
}
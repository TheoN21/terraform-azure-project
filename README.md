# Azure Infrastructure with Terraform

This project uses Terraform to deploy Azure infrastructure for a Logic App that accesses Azure Key Vault through a User Assigned Managed Identity.

## Resources

The deployment includes:

- Resource Group
- User Assigned Managed Identity
- Azure Key Vault (Standard) with RBAC
- Azure Logic App (Consumption)
- Key Vault Secrets User role assignment
- Storage Account and Blob Container for Terraform remote state

The Logic App uses its Managed Identity to authenticate with Key Vault. The assigned `Key Vault Secrets User` role allows it to read secrets without storing credentials in the application.

Terraform state is stored in Azure Blob Storage and accessed using Microsoft Entra ID authentication.

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure subscription with sufficient permissions

Log in to Azure:

```bash
az login
az account set --subscription "YOUR-SUBSCRIPTION-ID"
```

## Configuration

Clone the repository and configure your variables in `terraform.tfvars`.

```hcl
subscription_id       = "YOUR-SUBSCRIPTION-ID"
location              = "West Europe"
resource_group_name   = "YOUR-RESOURCE-GROUP"
managed_identity_name = "YOUR-MANAGED-IDENTITY"
key_vault_name        = "YOUR-KEY-VAULT-NAME"
logic_app_name        = "YOUR-LOGIC-APP-NAME"
```

Do not commit your actual `.tfvars` files or other sensitive information.

## Deployment

First, deploy the main infrastructure using local Terraform state:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Next, create the Storage Account and Blob Container for remote state using the Bootstrap configuration:

```bash
cd bootstrap
terraform init
terraform plan
terraform apply
```

After creating the storage resources, configure `backend.tf` in the main project and migrate the existing state:

```bash
terraform init -migrate-state
```

Confirm the migration when prompted.

To check the deployment:

```bash
terraform plan
```

## Project Structure

```text
terraform-azure/
├── main.tf
├── variables.tf
├── provider.tf
├── backend.tf
└── bootstrap/
    ├── main.tf
    ├── variables.tf
    └── provider.tf
```

## Notes

This is a personal learning project focused on Terraform and Azure. It is also an opportunity to explore Managed Identities, RBAC, Key Vault and remote state management.

Some ideas for further improvements:
- Add an Azure DevOps pipeline.
- Configure the Logic App workflow to retrieve a Key Vault secret.
- Add automated Terraform validation.

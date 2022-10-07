terraform {
  backend "azurerm" {
    resource_group_name  = "test-base-RG"
    storage_account_name = "testbasestgaccount"
    container_name       = "testbasestgconatiner"
    key                  = "single_tier/terraform.tfstate"
  }
}

locals {
  infra_env = terraform.workspace
}
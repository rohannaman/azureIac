provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "base_rg" {
  name     = "${var.resource_prefix}-base-RG"
  location = var.location
}

resource "azurerm_storage_account" "base_stg_ac" {
  name                     = "${var.resource_prefix}basestgaccount"
  resource_group_name      = azurerm_resource_group.base_rg.name
  location                 = azurerm_resource_group.base_rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "base_stg_container" {
  name                  = "${var.resource_prefix}basestgconatiner"
  storage_account_name  = azurerm_storage_account.base_stg_ac.name
  container_access_type = var.container_access_type
}
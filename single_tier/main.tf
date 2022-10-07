terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "main_RG" {
  name     = "${var.resource_prefix}-RG-${local.infra_env}"
  location = var.location
  tags = {
    environment = local.infra_env
  }
}

module "vpn_module" {
  source = "./module/network"
  resource_group_name = azurerm_resource_group.main_RG.name
  location = azurerm_resource_group.main_RG.location
  prefix = var.resource_prefix
}

module "vm_module" {
  source = "./module/virtual_machine"
  resource_group_name = azurerm_resource_group.main_RG.name
  location = azurerm_resource_group.main_RG.location
  prefix = var.resource_prefix
  network_interface_id = module.vpn_module.nic
}
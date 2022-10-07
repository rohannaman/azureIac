locals {
  infra_env = terraform.workspace
}

resource "azurerm_virtual_network" "main_VM" {
  name                = "${var.prefix}-VM"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = local.infra_env
  }
}

resource "azurerm_subnet" "main_subnet" {
  name                 = "${var.prefix}subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_VM.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main_public_ip"{
  name = "${var.prefix}-publicIP"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Dynamic"

    tags = {
    environment = local.infra_env
  }
}

resource "azurerm_network_security_group" "main_nsg" {
  name                = "${var.prefix}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "${var.prefix}NSGRule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = local.infra_env
  }
}

resource "azurerm_network_interface" "main_network_interface" {
  name                = "${var.prefix}-NIC"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.prefix}IPConfig"
    subnet_id                     = azurerm_subnet.main_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "main_nicsg" {
  network_interface_id      = azurerm_network_interface.main_network_interface.id
  network_security_group_id = azurerm_network_security_group.main_nsg.id
}
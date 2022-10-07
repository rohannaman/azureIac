locals {
  infra_env = terraform.workspace
}

resource "azurerm_windows_virtual_machine" "main_virtual_machine" {
  name                = "${var.prefix}-VM"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    var.network_interface_id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/794b9f9c-1182-422d-b969-f3e818caedbc/resourceGroups/packer-rg/providers/Microsoft.Compute/images/myPackerImage"

  tags = {
    environment = local.infra_env
  }
}

## <https://www.terraform.io/docs/providers/azurerm/r/windows_virtual_machine.html>
resource "azurerm_windows_virtual_machine" "example1" {
  name                = "${var.machine_details.name}-1"
  computer_name       = "${var.machine_details.name}-1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = var.machine_details.size
  admin_username      = var.machine_details.username
  admin_password      = var.machine_details.password
  network_interface_ids = [
    azurerm_network_interface.example1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "example2" {
  name                = "${var.machine_details.name}-2"
  computer_name       = "${var.machine_details.name}-2"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_resource_group.rg2.location
  size                = var.machine_details.size
  admin_username      = var.machine_details.username
  admin_password      = var.machine_details.password
  network_interface_ids = [
    azurerm_network_interface.example2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}


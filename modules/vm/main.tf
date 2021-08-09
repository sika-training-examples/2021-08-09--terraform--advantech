resource "azurerm_network_interface" "main" {
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  name = var.name

  ip_configuration {
    name                          = "dafault"
    subnet_id                     = var.subnet.id
    public_ip_address_id          = var.public_ip != null ? var.public_ip.id : null
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  name           = var.name
  size           = var.size
  admin_username = "default"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "default"
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

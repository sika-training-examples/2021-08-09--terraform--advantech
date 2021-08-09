resource "azurerm_resource_group" "default" {
  name     = "default"
  location = "westeurope"
}

resource "azurerm_virtual_network" "default" {
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  name          = "default-network"
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vms" {
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name

  name             = "vms"
  address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "example" {
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name              = "example"
  allocation_method = "Static"
}

output "example-ip" {
  value = azurerm_public_ip.example.ip_address
}

resource "azurerm_network_interface" "example" {
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  name = "example"

  ip_configuration {
    name                          = "dafault"
    subnet_id                     = azurerm_subnet.vms.id
    public_ip_address_id          = azurerm_public_ip.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name = "example"
  # Sizes: https://docs.microsoft.com/en-us/azure/cloud-services/cloud-services-sizes-specs
  size           = "Standard_A1_v2"
  admin_username = "default"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "default"
    public_key = file("~/.ssh/id_rsa.pub")
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

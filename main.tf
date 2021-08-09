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

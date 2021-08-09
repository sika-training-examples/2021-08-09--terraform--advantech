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

module "vm-example" {
  source = "./modules/vm"

  resource_group = azurerm_resource_group.default
  name           = "example"
  public_ip      = azurerm_public_ip.example
  subnet         = azurerm_subnet.vms
  ssh_key        = file("~/.ssh/id_rsa.pub")
}

resource "random_pet" "postgres1" {
  length = 3
}

module "postgres-1" {
  source = "./modules/postgres"

  resource_group = azurerm_resource_group.default
  name           = random_pet.postgres1.id
}

output "postgres1-host" {
  value = module.postgres-1.host
}

output "postgres1-password" {
  value     = module.postgres-1.password
  sensitive = true
}

resource "null_resource" "prevent_destroy" {
  depends_on = [
    module.vm-example,
    module.postgres-1,
  ]
  lifecycle {
    prevent_destroy = true
  }
}

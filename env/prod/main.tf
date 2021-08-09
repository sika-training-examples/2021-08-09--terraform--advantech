resource "azurerm_resource_group" "main" {
  name     = "prod"
  location = "westeurope"
}

module "azure-k8s-dogo" {
  source                 = "ondrejsika/azure-k8s/module"
  version                = "0.2.0"
  name                   = "dogo"
  kubernetes_version     = "1.21.2"
  azurerm_resource_group = azurerm_resource_group.main
}

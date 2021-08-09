resource "random_password" "main" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "azurerm_postgresql_server" "main" {
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  name                         = var.name
  administrator_login          = "postgres"
  administrator_login_password = random_password.main.result

  sku_name   = var.vm_size
  version    = var.postgres_version
  storage_mb = var.storage_size_gb * 1024

  backup_retention_days = 7
  auto_grow_enabled     = true

  public_network_access_enabled = true
  ssl_enforcement_enabled       = false
}

resource "azurerm_postgresql_firewall_rule" "main" {
  name                = var.name
  resource_group_name = var.resource_group.name
  server_name         = azurerm_postgresql_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_postgresql_database" "main" {
  name                = "default"
  resource_group_name = var.resource_group.name
  server_name         = azurerm_postgresql_server.main.name
  charset             = "UTF8"
  collation           = "en-US"
}

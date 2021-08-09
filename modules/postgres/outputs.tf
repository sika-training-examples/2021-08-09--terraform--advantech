output "password" {
  value     = random_password.main.result
  sensitive = true
}

output "host" {
  value = azurerm_postgresql_server.main.fqdn
}

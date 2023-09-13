resource "azurerm_postgresql_server" "postgresql_server" {
  name                = "coco-postgresql-server"
  location            = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name

  sku_name = "B_Gen5_2"

  storage_mb                   = 51200
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false
  administrator_login          = "coco"
  administrator_login_password = random_password.postgresql_password.result
  version                      = "11"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "coco_database" {
  name                = "coco"
  resource_group_name = azurerm_resource_group.region.name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "postgresql_firewall_rule" {
  name                = "AllowAllWindowsAzureIps"
  server_name         = azurerm_postgresql_server.postgresql_server.name
  resource_group_name = azurerm_resource_group.region.name
  start_ip_address    = azurerm_public_ip.public_ip.ip_address
  end_ip_address      = azurerm_public_ip.public_ip.ip_address
}

resource "azurerm_postgresql_server" "postgresql_server" {
  name = "coco-postgresql-server"
  location = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name

  sku_name = "B_Gen5_2"

  storage_mb = 51200
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled = false
  administrator_login = "coco"
  administrator_login_password = random_password.postgresql_password.result
  version = "11"
  ssl_enforcement_enabled = true
}

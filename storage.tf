resource "azurerm_storage_account" "storage" {
  name                     = "coco${random_id.random_id.hex}"
  resource_group_name      = azurerm_resource_group.region.name
  location                 = azurerm_resource_group.region.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "coco${random_id.random_id.hex}"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}

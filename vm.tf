resource "azurerm_virtual_machine" "vm" {
  name                  = "coco-vm"
  location              = azurerm_resource_group.region.location
  resource_group_name   = azurerm_resource_group.region.name
  network_interface_ids = [azurerm_network_interface.interface.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "coco-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "coco-vm"
    admin_username = "coco"

    custom_data = templatefile(
      "${path.module}/scripts/cloud-init.sh",
      {
        DB_HOST                      = azurerm_postgresql_server.postgresql_server.fqdn
        DB_USER                      = "coco"
        DB_PASSWORD                  = random_password.postgresql_password.result
        DB_NAME                      = "coco"
        DB_PORT                      = 5432
        AZURE_STORAGE_ACCOUNT_NAME   = azurerm_storage_account.storage.name
        AZURE_STORAGE_ACCOUNT_KEY    = azurerm_storage_account.storage.primary_access_key
        AZURE_STORAGE_CONTAINER_NAME = azurerm_storage_container.storage_container.name
      }
    )
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = var.coco_vm_ssh_public_key
      path     = "/home/coco/.ssh/authorized_keys"
    }
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

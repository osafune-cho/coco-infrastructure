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

resource "azurerm_resource_group" "region" {
  name = "coco-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "network" {
  name = "coco-network"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name
}

resource "azurerm_subnet" "subnet" {
  name = "coco-subnet"
  resource_group_name = azurerm_resource_group.region.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "interface" {
  name = "coco-interface"
  location = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_public_ip" "public_ip" {
  name = "coco-public-ip"
  location = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name
  allocation_method = "Static"
}

resource "azurerm_virtual_machine" "vm" {
  name = "coco-vm"
  location = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name
  network_interface_ids = [azurerm_network_interface.interface.id]
  vm_size = "Standard_DS1_v2"

  storage_os_disk {
    name = "coco-osdisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "coco-vm"
    admin_username = "coco"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = var.coco_vm_ssh_public_key
      path = "/home/coco/.ssh/authorized_keys"
    }
  }

  storage_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
}

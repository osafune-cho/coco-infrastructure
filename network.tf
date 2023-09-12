resource "azurerm_virtual_network" "network" {
  name                = "coco-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "coco-subnet"
  resource_group_name  = azurerm_resource_group.region.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "interface" {
  name                = "coco-interface"
  location            = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "coco-public-ip"
  location            = azurerm_resource_group.region.location
  resource_group_name = azurerm_resource_group.region.name
  allocation_method   = "Static"
}

resource "azurerm_virtual_network" "FoggyKitchen_VNet" {
  name                = "FoggyKitchen_VNet"
  address_space       = [var.azure_VNet_CIDR]
  location            = azurerm_resource_group.FoggyKitchen_Resource_Group.location
  resource_group_name = azurerm_resource_group.FoggyKitchen_Resource_Group.name
}

resource "azurerm_subnet" "FoggyKitchen_Public_Subnet" {
  name                 = "FoggyKitchen_Public_Subnet"
  resource_group_name  = azurerm_resource_group.FoggyKitchen_Resource_Group.name
  virtual_network_name = azurerm_virtual_network.FoggyKitchen_VNet.name
  address_prefixes     = [var.azure_public_subnet_CIDR]
}

resource "azurerm_subnet" "FoggyKitchen_Private_Subnet" {
  name                 = "FoggyKitchen_Private_Subnet"
  resource_group_name  = azurerm_resource_group.FoggyKitchen_Resource_Group.name
  virtual_network_name = azurerm_virtual_network.FoggyKitchen_VNet.name
  address_prefixes     = [var.azure_private_subnet_CIDR]

  delegation {
    name = "Oracle.Database/networkAttachments"

    service_delegation {
      name    = "Oracle.Database/networkAttachments"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_public_ip" "FoggyKitchen_Public_IP" {
  name                    = "FoggyKitchen_Public_IP"
  location                = azurerm_resource_group.FoggyKitchen_Resource_Group.location
  resource_group_name     = azurerm_resource_group.FoggyKitchen_Resource_Group.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "FoggyKitchen"
  }
}

resource "azurerm_network_interface" "FoggyKitchen_Network_Interface1" {
  name                = "fk-nic1"
  location            = azurerm_resource_group.FoggyKitchen_Resource_Group.location
  resource_group_name = azurerm_resource_group.FoggyKitchen_Resource_Group.name

  ip_configuration {
    name                          = "FoggyKitchen_ipconfig"
    subnet_id                     = azurerm_subnet.FoggyKitchen_Public_Subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.azure_private_ip1
    public_ip_address_id          = azurerm_public_ip.FoggyKitchen_Public_IP.id
  }
}

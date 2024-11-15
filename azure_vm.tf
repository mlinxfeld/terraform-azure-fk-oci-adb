resource "azurerm_virtual_machine" "FoggyKitchen_Azure_VM1" {
  name                  = "FoggyKitchen_Azure_VM1"
  location              = azurerm_resource_group.FoggyKitchen_Resource_Group.location
  resource_group_name   = azurerm_resource_group.FoggyKitchen_Resource_Group.name
  network_interface_ids = [azurerm_network_interface.FoggyKitchen_Network_Interface1.id]
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19_10-daily-gen2"
    version   = "latest" 
  }

  storage_os_disk {
    name              = "FoggyKitchenVMDisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "fkazurevm1"
    admin_username = var.azure_admin_username
    admin_password = var.azure_admin_password
  }
  
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.azure_admin_username}/.ssh/authorized_keys"
      key_data = tls_private_key.public_private_key_pair.public_key_openssh
    }
  }

  tags = {
    environment = "FoggyKitchen"
  }
}
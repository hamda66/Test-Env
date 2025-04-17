

//Notes: Windows servers cannot have special characters or more than 15 characters

resource "azurerm_virtual_machine" "mainserver" {
  resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    
    name = var.Server_name
    network_interface_ids = [azurerm_network_interface.nic.id]
    vm_size = var.Server_vm_size
    
 
     storage_image_reference {
    publisher = var.Server_publisher
    offer     = var.Server_offer
    sku       = var.Server_sku
    version   = var.Server_version

  }

  os_profile {
    computer_name  = "mainserver"
    admin_username = "Hamda"
    admin_password = "Password123!"

  }

  storage_os_disk {
    name              = "ServerDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile_windows_config {
   enable_automatic_upgrades = false
   
  }

  
    
}

//Note: Resource name cannot be all capitals

resource "azurerm_network_interface" "nic" {
    resource_group_name = var.resource_group_name
    location = var.location
    name = "nic"
    ip_configuration {
      name = "Server_nic_config"
      subnet_id = azurerm_subnet.sub.id
      private_ip_address_allocation = "Static"
      private_ip_address = "10.10.0.5"
      public_ip_address_id = azurerm_public_ip.serverippub.id
      
    }
    
  
}

//Server script extension

resource "azurerm_virtual_machine_extension" "server_script" {

  name = "InstallAD"
  virtual_machine_id = azurerm_virtual_machine.mainserver.id
  type = "CustomScriptExtension"
  publisher = "Microsoft.compute"
  type_handler_version = "1.10"

  settings = <<SETTINGS
  { "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -Command \"${replace(replace(file("script.ps1"), "\"", "\\\""), "\n", " ")}\""}

  SETTINGS

  depends_on = [ azurerm_virtual_machine.mainserver]

  
}
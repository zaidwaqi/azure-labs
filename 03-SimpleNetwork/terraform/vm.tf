# Public IPs
resource "azurerm_public_ip" "pip1" {
  name                = "pip-subnet1-${random_integer.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "pip2" {
  name                = "pip-subnet2-${random_integer.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interfaces
resource "azurerm_network_interface" "nic1" {
  name                = "nic-subnet1-${random_integer.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.pip1.id
  }
}

resource "azurerm_network_interface" "nic2" {
  name                = "nic-subnet2-${random_integer.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.pip2.id
  }
}

# Generate a random password
resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}"
}

# Linux VM in Subnet 1
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "vm-subnet1-${random_integer.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"  # 2 vCPU, 8 GB RAM
  admin_username      = "azureuser"
  admin_password      = random_password.vm_password.result
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.nic1.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "almalinux"
    offer     = "almalinux-x86_64"
    sku       = "10-gen2"
    version   = "latest"
  }
}

# Linux VM in Subnet 2
resource "azurerm_linux_virtual_machine" "vm2" {
  name                = "vm-subnet2-${random_integer.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"  # 2 vCPU, 8 GB RAM
  admin_username      = "azureuser"
  admin_password      = random_password.vm_password.result

  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic2.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "almalinux"
    offer     = "almalinux-x86_64"
    sku       = "10-gen2"
    version   = "latest"
  }
}

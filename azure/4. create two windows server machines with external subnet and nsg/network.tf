## <https://www.terraform.io/docs/providers/azurerm/r/network_interface.html>
resource "azurerm_network_interface" "example1" {
  name                = "example-nic1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myvm1publicip1.id
  }
}

resource "azurerm_network_interface" "example2" {
  name                = "example-nic2"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myvm1publicip2.id
  }
}

resource "azurerm_public_ip" "myvm1publicip1" {
  name                = "${var.public_ip.name}-1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = var.public_ip.allocation_method
  sku                 = var.public_ip.sku
}

resource "azurerm_public_ip" "myvm1publicip2" {
  name                = "${var.public_ip.name}-2"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  allocation_method   = var.public_ip.allocation_method
  sku                 = var.public_ip.sku
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.network_security_group_id
}

# Resource Group Outputs
output "location" {
  value = azurerm_resource_group.rg1.location
}

output "public_ip1" {
  value = azurerm_public_ip.myvm1publicip1.ip_address
}

output "public_ip2" {
  value = azurerm_public_ip.myvm1publicip2.ip_address
}



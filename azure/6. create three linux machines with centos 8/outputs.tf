output "vm_id" {
  value = azurerm_linux_virtual_machine.linuxvm.id
}

output "vm_ip" {
  value = azurerm_linux_virtual_machine.linuxvm.public_ip_address
}

output "vm_id2" {
  value = azurerm_linux_virtual_machine.linuxvm2.id
}

output "vm_ip2" {
  value = azurerm_linux_virtual_machine.linuxvm2.public_ip_address
}

output "vm_id3" {
  value = azurerm_linux_virtual_machine.linuxvm3.id
}

output "vm_ip3" {
  value = azurerm_linux_virtual_machine.linuxvm3.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}

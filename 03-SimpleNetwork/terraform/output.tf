output "vm_password" {
  value       = random_password.vm_password.result
  sensitive   = true
  description = "Random password for VM"
}

output "vm1_public_ip" {
  value       = azurerm_public_ip.pip1.ip_address
  description = "Public IP of VM1"
}

output "vm2_public_ip" {
  value       = azurerm_public_ip.pip2.ip_address
  description = "Public IP of VM2"
}
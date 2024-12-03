# output "ansible_inventory" {
#   value = templatefile("./modules/ansible_playbook/inventory.tpl", {
#     managers        = var.managers
#     workers         = var.workers
#     managers_public = module.azure_public_ip_1.public_ip
#     manager_private= module.azurerm_network_interface_1.private_ip_address
#     workers_public  = module.azure_public_ip_2.public_ip
#     workers_private   = module.azurerm_network_interface_2.private_ip_address
#   })
#   depends_on = [module.azure_public_ip_1, module.azure_public_ip_2]
#   sensitive = true
# }
output "public_ip_vm_1" {
  value = module.azure_public_ip_1.public_ip
}
output "public_ip_vm_2" {
  value = module.azure_public_ip_2.public_ip
}
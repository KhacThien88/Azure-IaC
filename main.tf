module "resources_group" {
  source   = "./modules/azurerm_resource_group"
  name     = var.name
  location = var.location
  tags = {
    "project" = "demojenkins"
  }
}
module "storage_account" {
  source     = "./modules/azurerm_storage_account"
  name_rg    = module.resources_group.name
  location   = module.resources_group.location
  depends_on = [module.resources_group]
}

module "storage_container" {
  source      = "./modules/azurerm_storage_container"
  tf_state_id = module.storage_account.storage_account_id
  depends_on  = [module.storage_account]
}

# module "storage_blob" {
#   source                  = "./modules/azurerm_storage_blob"
#   storage_account_name    = module.storage_account.name
#   storage_container_name  = module.storage_container.name
# }
module "virtual_network" {
  source               = "./modules/azurerm_virtual_network"
  virtual-network-name = var.virtual-network-name
  name_rg              = module.resources_group.name
  location             = module.resources_group.location
}

module "azurerm_subnet" {
  source               = "./modules/azurerm_subnet"
  name_rg              = module.resources_group.name
  subnet-name          = var.subnet-name
  virtual-network-name = module.virtual_network.virtual_network_name
  ip_subnet            = "10.0.1.0/24"
  depends_on           = [module.resources_group, module.virtual_network]
}

module "azurerm_network_interface_1" {
  # ipprivate             = var.range_privateip[0]count
  count_vm              = var.count_vm
  networkInterface_name = var.network-interface-name[0]
  name_rg               = module.resources_group.name
  source                = "./modules/azurerm_network_interface"
  idsub                 = module.azurerm_subnet.subnet_id
  publicip              = module.azure_public_ip_1.public_ip_address_ip_id
  depends_on            = [module.resources_group, module.azure_public_ip_1]
  location              = module.resources_group.location
}
module "azurerm_network_interface_2" {
  # ipprivate             = var.range_privateip[1]
  count_vm              = var.count_vm
  name_rg               = module.resources_group.name
  source                = "./modules/azurerm_network_interface"
  idsub                 = module.azurerm_subnet.subnet_id
  publicip              = module.azure_public_ip_2.public_ip_address_ip_id
  depends_on            = [module.resources_group, module.azure_public_ip_2]
  location              = module.resources_group.location
  networkInterface_name = var.network-interface-name[1]
}
module "nsg" {
  source              = "./modules/azurerm_network_security_group"
  location            = module.resources_group.location
  resource_group_name = module.resources_group.name

}
module "nic_association_1" {

  source = "./modules/azurerm_network_interface_security_group_association"
  nic_id = module.azurerm_network_interface_1.network_interface_id
  nsg_id = module.nsg.nsg_id
  depends_on = [
    module.azurerm_network_interface_1,
    module.nsg
  ]
}
module "nic_association_2" {

  source = "./modules/azurerm_network_interface_security_group_association"
  nic_id = module.azurerm_network_interface_2.network_interface_id
  nsg_id = module.nsg.nsg_id
  depends_on = [
    module.azurerm_network_interface_2,
    module.nsg
  ]
}
module "azurerm_linux_virtual_machine_1" {
  name_vm     = var.name_vm[0]
  count_vm    = var.count_vm
  location    = var.location
  VMSize      = var.VMSize1
  name_rg     = module.resources_group.name
  source      = "./modules/azurerm_linux_virtual_machine"
  environment = "development"
  idsub       = module.azurerm_network_interface_1.network_interface_id
  depends_on  = [module.resources_group]
}
module "azurerm_linux_virtual_machine_2" {
  name_vm     = var.name_vm[1]
  count_vm    = var.count_vm
  location    = var.location
  VMSize      = var.VMSize2
  name_rg     = module.resources_group.name
  source      = "./modules/azurerm_linux_virtual_machine"
  environment = "development"
  idsub       = module.azurerm_network_interface_2.network_interface_id
  depends_on  = [module.resources_group]
}
module "azure_public_ip_1" {
  source        = "./modules/azurerm_public_ip"
  count_vm      = var.count_vm
  name_rg       = module.resources_group.name
  location      = module.resources_group.location
  publicip_name = var.public_ip_names[0]
}
module "azure_public_ip_2" {
  source        = "./modules/azurerm_public_ip"
  count_vm      = var.count_vm
  name_rg       = module.resources_group.name
  location      = module.resources_group.location
  publicip_name = var.public_ip_names[1]
}

# module "azurerm_subnet_eks" {
#   source               = "./modules/azurerm_subnet"
#   name_rg              = module.resources_group.name 
#   subnet-name          = var.subnet-name
#   virtual-network-name = module.virtual_network.virtual_network_name 
#   depends_on          = [module.resources_group , module.virtual_network]
#   ip_subnet = "172.20.0.0/24"
# }

# module "azure_kubernetes_server" {
#   source = "./modules/azurerm_kubernetes_cluster"
#   location = module.resources_group.location
#   name_rg = module.resources_group.name
#   id_subnet = module.azurerm_subnet_eks.subnet_id
# }

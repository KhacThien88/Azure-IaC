resource "azurerm_kubernetes_cluster" "aks" {
  name                = "demo-aks1"
  location            = var.location
  resource_group_name = var.name_rg
  dns_prefix          = "aks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = var.id_subnet
  }
   linux_profile {
     admin_username = "khacthien"
     ssh_key {
       key_data = var.ssh_key
     }
   }
   network_profile {
     network_plugin = "kubenet"
     service_cidr   = "172.20.3.0/24"
     dns_service_ip = "172.20.3.10"
   }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
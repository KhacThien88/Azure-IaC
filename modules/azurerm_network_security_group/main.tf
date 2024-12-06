resource "azurerm_network_security_group" "this" {
  name                = "vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

security_rule {
  name                       = "Allow-SSH"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "22"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}

security_rule {
  name                       = "Allow-Kubernetes"
  priority                   = 101
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "6443"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Kubernetes-ab"
  priority                   = 103
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "2379"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Kubernetess-a"
  priority                   = 104
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "2380"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Kubernetessss"
  priority                   = 110
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "10250"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Kubernetesss"
  priority                   = 107
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "10251"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Kubernetess"
  priority                   = 106
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "10252"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Kubernetes-Outbound"
  priority                   = 102
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "6443"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Jenkins-Outbound"
  priority                   = 120
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "32000"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-Jenkins-Inbound"
  priority                   = 130
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "32000"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-SavingAccountFEIn"
  priority                   = 160
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "32100"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
security_rule {
  name                       = "Allow-SavingAccountFEOut"
  priority                   = 170
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                  = "Tcp"
  source_port_range         = "*"
  destination_port_range    = "32100"
  source_address_prefix     = "*"
  destination_address_prefix = "*"
}
}
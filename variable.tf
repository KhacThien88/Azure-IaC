variable "name" {
  type        = string
  description = "The name of the resource group"
  default     = "rg_linuxhcmusdemo"
}
variable "location" {
  type        = string
  description = "The name of region of VM hosting"
  default     = "australiaeast"
}
variable "tags" {
  type        = map(string)
  description = "Map of tags for the resource group"
  default     = {}
}
variable "enable-monitoring" {
  type    = bool
  default = false
}
variable "virtual-network-name" {
  type    = string
  default = "vm-vn"
}
variable "subnet-name" {
  type    = string
  default = "subnetofvm"
}
variable "network-interface-name" {
  type    = list(string)
  default = ["nic-1", "nic-2"]
}
variable "count_vm" {
  type    = number
  default = 2
}
variable "VMSize" {
  type    = string
  default = "Standard_B4ms"
}
variable "environment" {
  type    = string
  default = "Development"
}
variable "nic_id" {
  description = "The ID of the Network Interface"
  type        = string
  default     = "nic"
}
variable "public_ip_names" {
  description = "Danh sách tên các public IP"
  type        = list(string)
  default     = ["public-ip-vm1", "public-ip-vm2"]
}
variable "name_vm" {
  type        = list(string)
  description = "The name of the resource group"
  default     = ["vm-01", "vm-02"]
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "subscription_id" {
  type = string
}
# variable "range_privateip" {
#   type    = list(string)
#   default = ["172.20.20.20", "172.20.20.19"]
# }
# variable "managers" {
#   type    = list(string)
#   default = ["vm-01"]
# }

# variable "workers" {
#   type    = list(string)
#   default = ["vm-02"]
# }

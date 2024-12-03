variable "name_rg" {
  type = string
  description = "The name of the resource group"
}
variable "location" {
  type = string
  description = "The name of region of VM hosting"
}

variable "idsub"{
    type = string
}
variable "publicip" {
  type = string
}
variable "count_vm"{
    type = number
}
variable "networkInterface_name" {
  type = string
}
# variable "ipprivate" {
#   type = string
# }
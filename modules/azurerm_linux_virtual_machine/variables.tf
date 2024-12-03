variable "name_rg" {
  type = string
  description = "The name of the resource group"
}
variable "location" {
  type = string
  description = "The name of region of VM hosting"
}
variable "count_vm"{
    type = number
}
variable "VMSize"{
    type = string
}
variable "environment"{
    type = string
}
variable "idsub"{
    type = string
}
variable "name_vm" {
  type = string
}
variable "name" {
  type = string
  description = "The name of the resource group"
}
variable "location" {
  type = string
  description = "The name of region of VM hosting"
}
variable "tags" {
  type = map(string)
  description = "Map of tags for the resource group"
}

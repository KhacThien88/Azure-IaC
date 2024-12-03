variable "name_rg" {
  type = string
  description = "The name of the resource group"
}
variable "location" {
  type = string
  description = "The name of region of VM hosting"
}
variable "ssh_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDb5uA/KH4kbuBOuCW8s3alJf9K6N6kd9jfYpYri4EQY2Rs/8k364evgy9cI2oG9ih4JhisC0+19REv7IHXEuHysMP53DwsnAx3WiSFioaq0Z2RxBaCAeW56nsfiylSEF3Ab+KegYEjaNL7YLyYEbjJjSOMQZxh6H62oHX2hsr5Z8TAFn/21P7JBqnQRE2pTwDf/45gyrm0MvJy5UyWH4R3RasA6mxCZnttLnYwa3X1/XvxZgVIrjV9SamwV/AInfy+msPWwqsLGmgSKS+Cyln+3yBaO1v+RYJTtd+R7lKwkk5SCCiR6Ek3RuOwQdWnRCQASTY9e0TkUOhWvcxfav6EExAD2tx1llmMDta60OLAbyDDzHKtMLkNDoAkvF+2n2Y9pZVlavAVv4nqN3Nx9qOj5QsZQZ765MepkgmmVvk6I7qXjip97pkAAHPeKpx3Ds/vQcCiuY/2mFoQAAwJg7WWo7yqQNtTHWiItW4dPCweccFlzyxpSkkrSrlVlPtBDJQrg0hmqs/s2lKstyftogi1i+UTHQfRP7H/9wFT3jbnf/gsf5SfKD64icLVSP+SsNP5CNe9LLreWyuSFy3vmVv4Se+kD1NE2PGLvNaDPcw1Npe9ruKSNlo6T4VEKxf1uX6KxwG8sy7XEVFWAFXc9EGniZbFil8fo+RJTXDk8QMEKQ== admin@LAPTOP-J5UQH6VM"
}
variable "id_subnet" {
  type = string
}
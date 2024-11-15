variable "azure_VNet_CIDR" {
  default = "10.0.0.0/16"
}

variable "azure_public_subnet_CIDR" {
  default = "10.0.1.0/24"
}

variable "azure_private_subnet_CIDR" {
  default = "10.0.2.0/24"
}

variable "azure_private_ip1" {
  default = "10.0.1.4"
}

variable "azure_admin_username" {
  default = "azureuser"
}

variable "azure_admin_password" {
    default = ""
}
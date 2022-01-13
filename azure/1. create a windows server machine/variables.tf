variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  default     = "eastus"
}

variable "public_ip" {
 

  default = {
      name              = "pip1"
      allocation_method = "Dynamic"
      sku               = "Basic"
    }
  
  
}

variable "nsg" {
  type        = string
  description = "Azure NSG"
  default     = "example-nsg"
}

variable "machine_details" {
  
  default = {
      name             = "example-vm"
      size = "Standard_E2s_v3" #"Standard_F2"
      username               = "adminuser"
      password = "Notallowed1!"
    }
  
}

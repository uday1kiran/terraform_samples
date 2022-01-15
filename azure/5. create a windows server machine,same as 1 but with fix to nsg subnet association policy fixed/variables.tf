variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  default     = "eastus2"
}

variable "public_ip" {
 type = object({
    name = string
    allocation_method = string
    sku = string
  })

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
  type = object({
    name = string
    size = string
    username = string
    password = string
  })

  default = {
      name = "example-vm"
      size = "Standard_F2"
      username  = "adminuser"
      password = "Notallowed1!"
    }
  
}
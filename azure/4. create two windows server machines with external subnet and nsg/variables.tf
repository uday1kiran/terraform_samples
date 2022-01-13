variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  default     = "centralus"
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

## policy issuefixes
variable "subnet_id" {
  type        = string
  description = "This variable defines the Resource Group"
  default     = "/subscriptions/<subscription_id>/resourceGroups/PacktPub/providers/Microsoft.Network/virtualNetworks/myVNET/subnets/mySubNet"
}

variable "network_security_group_id" {
  type        = string
  description = "This variable defines the Resource Group"
  default     = "/subscriptions/<subscription_id>/resourceGroups/PacktPub/providers/Microsoft.Network/networkSecurityGroups/MyNsg"
}

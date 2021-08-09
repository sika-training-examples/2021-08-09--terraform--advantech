variable "resource_group" {
  description = "Resource Group Terraform object"
}

variable "public_ip" {
  description = "Public IP Terraform object"
  default     = null
}

variable "subnet" {
  description = "Network Subnet Terraform object"
}

variable "name" {
  type        = string
  description = "Name of virtual machine"
}

variable "size" {
  type        = string
  description = "Size of VM. Available sizes: https://docs.microsoft.com/en-us/azure/cloud-services/cloud-services-sizes-specs"
  default     = "Standard_A1_v2"
}

variable "ssh_key" {
  type        = string
  description = "Admin user SSH key"
}

variable "resource_group" {
  description = "Resource Group Terraform object"
}

variable "name" {
  type        = string
  description = "Name of virtual machine"
}

variable "vm_size" {
  type        = string
  description = "Size of VM running Postgres."
  default     = "B_Gen5_1"
}

variable "storage_size_gb" {
  type        = number
  description = "Storage size in GB"
  default     = 30
}

variable "postgres_version" {
  type    = string
  default = "11"
}

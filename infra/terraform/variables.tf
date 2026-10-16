variable "project" {
  description = "Short project name used in resource names"
  type        = string
  default     = "helloaks"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "VM size for AKS nodes (B-series keeps lab cost low)"
  type        = string
  default     = "Standard_B2s_v2"
}

variable "tags" {
  description = "Tags applied to every resource"
  type        = map(string)
  default = {
    project    = "aks-cicd"
    managed_by = "terraform"
  }
}

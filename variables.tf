variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "resource_group_name" {
  description = "resource group name"
}

variable "location" {
  description = "Azure location"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "public_agents_additional_rules" {
  description = "Additional list of rules for public agents. These Rules are an additon to the default rules."
  default     = []
}

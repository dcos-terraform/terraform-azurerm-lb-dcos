variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "resource_group_name" {
  description = "Name of the azure resource group"
}

variable "location" {
  description = "Azure Region"
}

variable "name_prefix" {
  description = "Name Prefix"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "masters_instance_nic_ids" {
  description = "List of master instance nic ids"
  type        = list(string)
}

variable "public_agents_instance_nic_ids" {
  description = "List of public agents instance nic ids"
  type        = list(string)
}

variable "public_agents_additional_rules" {
  description = "Additional list of rules for public agents. These Rules are an additon to the default rules."
  default     = []
}

variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
}

variable "num_public_agents" {
  description = "Specify the amount of public agents. These agents will host marathon-lb and edgelb"
}


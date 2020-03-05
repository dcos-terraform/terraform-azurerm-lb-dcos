/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/buildStatus/icon?job=dcos-terraform%2Fterraform-azurerm-lb-dcos%2Fsupport%252F0.2.x)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-dcos/job/support%252F0.2.x/)
 *
 * Azure LB DC/OS
 * ============
 * This module creates three load balancers for DC/OS.
 *
 * External masters load balancer
 * ------------------------------
 * This load balancer keeps an redundant entry point to the masters
 *
 * Internal masters load balancer
 * ------------------------------
 * this load balancer is used for internal communication to masters
 *
 * External public agents load balancer
 * ------------------------------------
 * This load balancer keeps a single entry point to your public agents no matter how many you're running.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "lb-dcos" {
 *   source  = "dcos-terraform/lb-dcos/azurerm"
 *   version = "~> 0.2.0"
 *
 *   cluster_name = "production"
 *
 *   location                       = ["North Europe"]
 *   resource_group_name            = "my-resource-group"
 *   subnet_id                      = "subnet/id/the/load-balancer/should/be/in"
 *   public_agents_additional_rules = [{ frontend_port = 8080 }]
 * }
 *```
 */

module "masters" {
  source  = "dcos-terraform/lb-masters/azurerm"
  version = "~> 0.2.0"

  cluster_name                = "${var.cluster_name}"
  name_prefix                 = "${var.name_prefix}"
  location                    = "${var.location}"
  resource_group_name         = "${var.resource_group_name}"
  instance_nic_ids            = ["${var.masters_instance_nic_ids}"]
  num                         = "${var.num_masters}"
  adminrouter_grpc_proxy_port = "${var.adminrouter_grpc_proxy_port}"

  tags = "${var.tags}"
}

module "masters-internal" {
  source  = "dcos-terraform/lb-masters-internal/azurerm"
  version = "~> 0.2.0"

  cluster_name                = "${var.cluster_name}"
  name_prefix                 = "${var.name_prefix}"
  location                    = "${var.location}"
  resource_group_name         = "${var.resource_group_name}"
  subnet_id                   = "${var.subnet_id}"
  instance_nic_ids            = ["${var.masters_instance_nic_ids}"]
  num                         = "${var.num_masters}"
  adminrouter_grpc_proxy_port = "${var.adminrouter_grpc_proxy_port}"

  tags = "${var.tags}"
}

module "public-agents" {
  source  = "dcos-terraform/lb-public-agents/azurerm"
  version = "~> 0.2.0"

  cluster_name        = "${var.cluster_name}"
  name_prefix         = "${var.name_prefix}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  additional_rules    = "${var.public_agents_additional_rules}"
  instance_nic_ids    = ["${var.public_agents_instance_nic_ids}"]
  num                 = "${var.num_public_agents}"

  tags = "${var.tags}"
}

[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/buildStatus/icon?job=dcos-terraform%2Fterraform-azurerm-lb-dcos%2Fsupport%252F0.1.x)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-lb-dcos/job/support%252F0.1.x/)

Azure LB DC/OS
============
This module creates three load balancers for DC/OS.

External masters load balancer
------------------------------
This load balancer keeps an redundant entry point to the masters

Internal masters load balancer
------------------------------
this load balancer is used for internal communication to masters

External public agents load balancer
------------------------------------
This load balancer keeps a single entry point to your public agents no matter how many you're running.

EXAMPLE
-------

```hcl
module "lb-dcos" {
  source  = "dcos-terraform/lb-dcos/azurerm"
  version = "~> 0.1.0"

  cluster_name = "production"

  location                       = ["North Europe"]
  resource_group_name            = "my-resource-group"
  subnet_id                      = "subnet/id/the/load-balancer/should/be/in"
  public_agents_additional_rules = [{ frontend_port = 8080 }]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| location | Azure Region | string | n/a | yes |
| resource\_group\_name | Name of the azure resource group | string | n/a | yes |
| subnet\_id | Subnet ID | string | n/a | yes |
| public\_agents\_additional\_rules | Additional list of rules for public agents. These Rules are an additon to the default rules. | list | `<list>` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| masters-internal.backend\_address\_pool | backend address pool |
| masters-internal.lb\_address | lb address |
| masters.backend\_address\_pool | backend address pool |
| masters.lb\_address | lb address |
| public-agents.backend\_address\_pool | backend address pool |
| public-agents.lb\_address | lb address |


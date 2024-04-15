# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }

    tfe = {
      source = "hashicorp/tfe"
      version = "0.53.0"
    }
  }
}

variable "pet" {
  type = string
}

variable "instances" {
  type = number
}

resource "null_resource" "this" {
  count = var.instances

  triggers = {
    pet = var.pet
  }
}

data "tfe_organization" "my_org" {
  name = "hashicorp"
}

resource "tfe_workspace" "tester" {
  name       = "pet-nulls-tester"
  organization = data.tfe_organization.my_org.id
}

# resource "null_resource" "dns_check" {
#   count = 1
#
#   provisioner "local-exec" {
#     command     = "false"
#     interpreter = ["bash", "-c"]
#   }
# }

resource "null_resource" "errorplz" {
  triggers = {
    pet = 3
  }
}

resource "null_resource" "dependant" {
  triggers = {
   pet = jsondecode("${null_resource.errorplz.id}")
  }
}

output "ids" {
  value = [for n in null_resource.this: n.id]
}

output "exit" {
  value = jsondecode("${null_resource.errorplz.id}")
}


# output "name" {
#   value = local.name
# }

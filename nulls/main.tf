# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
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
    pet = 1
  }
}


output "ids" {
  value = [for n in null_resource.this: n.id]
}

output "exit" {
  value = jsondecode(null_resource.errorplz.id)
}

output "name" {
  value = local.name
}

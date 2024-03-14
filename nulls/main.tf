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

locals {
  name = "aha!"

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

output "ids" {
  value = [for n in null_resource.this: n.id]
}

output "name" {
  value = local.name
  }

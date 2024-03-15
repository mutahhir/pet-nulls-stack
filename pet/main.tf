# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

locals {
  length = -1
}


variable "prefix" {
  type = string
}

resource "random_pet" "this" {
  prefix = var.prefix
  length = local.length
}

output "name" {
  value = random_pet.this.id
}

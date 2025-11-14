# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

variable "prefix" {
  type = string
}

resource "random_pet" "this" {
  prefix = var.prefix
  length = 5
}

output "name" {
  value = random_pet.this.id
}

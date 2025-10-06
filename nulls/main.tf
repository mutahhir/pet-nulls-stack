# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }

    bufo = {
      source  = "austinvalle/bufo"
      version = "2.1.0"
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

  lifecycle {
    action_trigger {
      events  = [after_create]
      actions = [action.bufo_print.success]

    }
  }

  triggers = {
    pet = var.pet
  }
}

action "bufo_print" "success" {
  config {
    name = "bufo-the-builder"
  }
}

output "ids" {
  value = [for n in null_resource.this : n.id]
}

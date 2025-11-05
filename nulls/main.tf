# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }

    bufo = {
      source  = "austinvalle/bufo"
      version = "2.1.0"
    }

    #   tfcoremock = {
    #     source  = "hashicorp/tfcoremock"
    #     version = "0.6.0-beta2"
    #   }
  }
}

variable "pet" {
  type = string
}

variable "instances" {
  type = number
}

action "bufo_print" "meh" {
  config {
    name = local.secret_name
  }
}

# resource "tfcoremock_simple_resource" "this" {
#   id = "defer-me"
#
#   lifecycle {
#     action_trigger {
#       events  = [before_create]
#       actions = [action.bufo_print.meh]
#     }
#   }
# }

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

locals {
  secret_name = sensitive("bufo-the-builder")
}

action "bufo_print" "success" {
  config {
    name = local.secret_name
  }
}

output "ids" {
  value = [for n in null_resource.this : n.id]
}

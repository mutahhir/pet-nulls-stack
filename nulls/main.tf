# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
  shell = {
      source = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}

provider "shell" {
    environment = {
        GO_PATH = "/Users/Admin/go"
    }
    interpreter = ["/bin/sh", "-c"]
    enable_parallelism = false
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
    pet = 3
  }
}

resource "null_resource" "dependant" {
  triggers = {
   pet = jsondecode("{${null_resource.errorplz.id}")
  }
}

output "ids" {
  value = [for n in null_resource.this: n.id]
}

output "exit" {
  value = jsondecode("{${null_resource.errorplz.id}")
}


resource "shell_script" "github_repository" {
    lifecycle_commands {
        //I suggest having these command be as separate files if they are non-trivial
        create = file("${path.module}/scripts/create.sh")
        read   = file("${path.module}/scripts/read.sh")
        update = file("${path.module}/scripts/update.sh")
        delete = file("${path.module}/scripts/delete.sh")
    }

    environment = {
        //changes to one of these will trigger an update
        NAME        = "HELLO-WORLD"
        DESCRIPTION = "description"
    }


    //sensitive environment variables are exactly the
    //same as environment variables except they don't
    //show up in log files
    sensitive_environment = {
        USERNAME = var.username
        PASSWORD = var.password
    }

    //this overrides the provider supplied interpreter
    //if you do not specify this then the default for your
    //machine will be used (/bin/sh for linux/mac and cmd for windows)
    interpreter = ["/bin/bash", "-c"]

    //sets current working directory
    working_directory = path.module

    //triggers a force new update if value changes, like null_resource
    triggers = {
        when_value_changed = var.some_value
    }
}

# output "name" {
#   value = local.name
# }

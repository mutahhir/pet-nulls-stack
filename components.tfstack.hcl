# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.3.2"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.1.1"
  }

  shell = {
      source = "scottwinkler/shell"
      version = "1.7.10"
    }
}

provider "random" "this" {}
provider "null" "this" {}
provider "shell" "this" {
    environment = {
        GO_PATH = "/Users/Admin/go"
    }
    interpreter = ["/bin/sh", "-c"]
    enable_parallelism = false
}

component "pet" {
  source = "./pet"

  inputs = {
    prefix = var.prefix
  }

  providers = {
    random = provider.random.this
  }
}

component "nulls" {
  source = "./nulls"

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
  }
}

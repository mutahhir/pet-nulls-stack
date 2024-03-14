# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

locals {
  name = "pet-nulls"
  petName = "AHA!-${component.pet.name}"
}


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
}

provider "random" "this" {}
provider "null" "this" {}

component "pet" {
  source = "./pet"

  inputs = {
    prefix = "${local.name}-${var.prefix}"
  }

  providers = {
    random = provider.random.this
  }
}

component "nulls" {
  source = "./nulls"

  inputs = {
    pet       = local.petName
    instances = var.instances
  }

  providers = {
    null = provider.null.this
  }
}

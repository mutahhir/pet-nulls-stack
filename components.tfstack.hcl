# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

variable "token" {
  type = string
}

variable "hostname" {
  type = string
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

  tfe = {
      source = "hashicorp/tfe"
      version = "0.53.0"
  }
}

provider "random" "this" {}
provider "null" "this" {}
provider "tfe" "this" {
  config {
    token = var.token
    hostname = var.hostname
  }
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
    tfe = provider.tfe.this
  }
}

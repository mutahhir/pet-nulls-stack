# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
#

deployment_group "simple" {
}

deployment_group "complex" {

}


deployment "simple" {
  inputs = {
    prefix           = "simple"
    instances        = 1
  }

  deployment_group = deployment_group.simple
}

deployment "complex" {
  inputs = {
    prefix           = "complex"
    instances        = 3
  }

  deployment_group = deployment_group.complex
}

# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

deployment "simple" {
  variables = {
    prefix           = "simple"
    instances        = 1
    hostname = "foo"
    token = "bar"
  }
}

deployment "complex" {
  variables = {
    prefix           = "complex"
    instances        = 3
    hostname = "foo"
    token = "bar"
    
  }
}

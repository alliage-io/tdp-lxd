# Copyright 2022 SAS Adaltas
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "1.7.1"
    }
  }
}

provider "lxd" {
  generate_client_certificates = true
  accept_remote_certificate    = true
}

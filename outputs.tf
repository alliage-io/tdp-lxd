# Copyright 2022 SAS Adaltas
# SPDX-License-Identifier: Apache-2.0

output "tdp_containers" {
  value = values(lxd_container.tdp_containers).*.name
}

# Copyright 2022 Adaltas
# SPDX-License-Identifier: MIT

output "tdp_containers" {
  value = values(lxd_container.tdp_containers).*.name
}

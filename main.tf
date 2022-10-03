# Copyright 2022 Adaltas
# SPDX-License-Identifier: MIT

# Networks
resource "lxd_network" "tdp_network" {
  name = "tdpbr0"

  config = {
    "ipv4.address" = var.tdp_network.ipv4.address
    "ipv4.nat"     = "true"
    "ipv6.address" = "none"
  }
}

# Profiles
resource "lxd_profile" "tdp_node" {
  name = "tdp_node"

  config = {
    "boot.autostart" = false
  }

  device {
    type = "disk"
    name = "root"

    properties = {
      pool = var.lxd_storage_pool
      path = "/"
    }
  }
}

resource "lxd_profile" "tdp_profiles" {
  for_each = {
    for index, profile in var.tdp_profiles :
    profile.name => profile.limits
  }

  name = each.key

  config = {
    "limits.cpu"    = each.value.cpu
    "limits.memory" = each.value.memory
  }
}

# Ansible hosts.ini templating
resource "local_file" "ansible_hosts" {
  content = templatefile(
    "${path.module}/hosts.tftpl",
    {
      tdp_containers = var.tdp_containers
      tdp_domain     = var.tdp_domain
    }
  )
  filename = "hosts.ini"
}

# Containers
resource "lxd_container" "tdp_containers" {
  depends_on = [
    local_file.ansible_hosts,
    lxd_network.tdp_network,
    lxd_profile.tdp_profiles,
    lxd_profile.tdp_node
  ]

  for_each = {
    for index, container in var.tdp_containers :
    container.name => container
  }

  name  = each.key
  image = var.tdp_image
  profiles = [
    lxd_profile.tdp_node.name,
    each.value.profile
  ]

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = lxd_network.tdp_network.name
      "ipv4.address" = "${each.value.ip}"
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook playbooks/provision.yml -i hosts.ini -l ${each.key}"
  }
}

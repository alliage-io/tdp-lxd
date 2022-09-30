# Copyright 2022 Adaltas
# SPDX-License-Identifier: MIT

tdp_network = {
  ipv4 = { address = "192.168.57.1/24" }
}

tdp_domain = "tdp"

tdp_profiles = [
  {
    name = "tdp_master"
    limits = {
      cpu    = 3
      memory = "3GB"
    }
  },
  {
    name = "tdp_worker"
    limits = {
      cpu    = 2
      memory = "2GB"
    }
  },
  {
    name = "tdp_edge"
    limits = {
      cpu    = 2
      memory = "2GB"
    }
  }
]

# tdp_image = "images:rockylinux/8"
tdp_image = "images:centos/7"

tdp_containers = [
  {
    name    = "master-01"
    profile = "tdp_master"
    ip      = "192.168.57.11"
    ansible_groups = [
      "master",
      "master1"
    ]
  },
  {
    name    = "master-02"
    profile = "tdp_master"
    ip      = "192.168.57.12"
    ansible_groups = [
      "master",
      "master2"
    ]
  },
  {
    name    = "master-03"
    profile = "tdp_master"
    ip      = "192.168.57.13"
    ansible_groups = [
      "master",
      "master3"
    ]
  },
  {
    name    = "worker-01"
    profile = "tdp_worker"
    ip      = "192.168.57.14"
    ansible_groups = [
      "worker"
    ]
  },
  {
    name    = "worker-02"
    profile = "tdp_worker"
    ip      = "192.168.57.15"
    ansible_groups = [
      "worker"
    ]
  },
  {
    name    = "worker-03"
    profile = "tdp_worker"
    ip      = "192.168.57.16"
    ansible_groups = [
      "worker"
    ]
  },
  {
    name    = "edge-01"
    profile = "tdp_worker"
    ip      = "192.168.57.10"
    ansible_groups = [
      "edge"
    ]
  }
]

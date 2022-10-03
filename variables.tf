# Copyright 2022 Adaltas
# SPDX-License-Identifier: MIT

variable "lxd_storage_pool" {
  type    = string
  default = "default"
}

variable "tdp_network" {
  type = object({
    ipv4 = object({
      address = string
    })
  })
}

variable "tdp_domain" {
  type = string
}

variable "tdp_profiles" {
  type = list(object({
    name = string
    limits = object({
      cpu    = number
      memory = string
    })
  }))
}

variable "tdp_image" {
  type    = string
  default = "images:centos/7"
}

variable "tdp_containers" {
  type = list(object({
    name           = string
    profile        = string
    ip             = string
    ansible_groups = list(string)
  }))
}

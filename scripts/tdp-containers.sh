#!/bin/bash

# Copyright 2022 Adaltas
# SPDX-License-Identifier: MIT

# Start|stop|restart LXD containers handled by terraform
# $1 = Action to execute
# $2 = Container group name

print_usage() {
  echo "Usage: lxd-containers.sh [start|stop|restart]"
}

if [ "$#" -eq 1 ]; then
  case "$1" in
  start)
    invalid_status=Running
    action=Starting
    ;;
  stop)
    invalid_status=Stopped
    action=Stopping
    ;;
  restart)
    invalid_status=Stopped
    action=Restarting
    ;;
  *)
    print_usage && exit 1
    ;;
  esac

  # cd to tdp-lxd root dir
  parent_dir=$(realpath "$(dirname "$0")")
  cd "$parent_dir/.." || exit 1

  containers_list=$(terraform output -json "tdp_containers" | jq -r '.[]')

  for c in $containers_list; do
    status=$(lxc query "/1.0/containers/$c" | jq -r '.status')
    if [ "$status" = "$invalid_status" ]; then
      echo "$c is already $invalid_status"
    else
      echo "$action $c..."
      lxc "$1" "$c"
    fi
  done

else
  print_usage && exit 1
fi

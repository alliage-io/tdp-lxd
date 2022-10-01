#!/bin/bash

# Copyright 2022 Adaltas
# SPDX-License-Identifier: MIT

CLEAN="false"

parse_cmdline() {
	local OPTIND
	while getopts 'c' options; do
		case "$options" in
		c) CLEAN="true" ;;
		*) return 1 ;;
		esac
	done
	shift $((OPTIND - 1))
	return 0
}

create_symlink_if_needed() {
	local target=$1
	local link_name=$2
	if [[ "$CLEAN" == "true" ]]; then
		echo "Remove '${link_name}'"
		rm -rf "$link_name"
	fi
	if [[ -e "$link_name" ]] || [[ -L "$link_name" ]]; then
		echo "File '${link_name}' exists, nothing to do"
		return 0
	fi
	echo "Create symlink '${link_name}'"
	ln -s "$target" "$link_name"
}

parse_cmdline "$@"

create_symlink_if_needed "../tdp-lxd/hosts.ini" "inventory/hosts.ini"

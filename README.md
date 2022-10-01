# TDP LXD

Launch a fully-featured virtual TDP Hadoop cluster with a single command _or_ customize the infrastructure.

This is an alternative to [tdp-vagrant](https://github.com/TOSIT-IO/tdp-vagrant) which uses LXD containers instead of VMs.

## Requirements

**Hardware:**

- 20+ GB of RAM available
- 4+ CPU cores

**Software:**

- LXD (to operate Linux containers)
- Terraform >= 0.13 (to automatize containers lifecycle managment)
- Ansible >= 2.9.6 (to provision the containers)
- Linux cgroup v2 (to run recent Linux containers like Rocky 8)

### Linux cgroup v2

To check if your host uses cgroup v2, run:

```sh
stat -fc %T /sys/fs/cgroup
# cgroup2fs => cgroup v2
# tmpfs     => cgroup v1
```

Recent distributions use cgroup v2 by default (check the list [here](https://rootlesscontaine.rs/getting-started/common/cgroup2/#checking-whether-cgroup-v2-is-already-enabled)) but the feature is available on all hosts that run a Linux kernel >= 5.2 (e.g. Ubuntu 20.04). To enable it, see [Enabling cgroup v2](https://rootlesscontaine.rs/getting-started/common/cgroup2/#enabling-cgroup-v2).

## Using in tdp-getting-started

```bash
cd /path/to/tdp-getting-started

# Clone this repo
git clone https://github.com/alliage-io/tdp-lxd.git

# Setup the Ansible inventory symlink
./tdp-lxd/scripts/setup.sh -c

# Init the Terraform project
terraform -chdir='tdp-lxd' init
```

## Provision the cluster

```bash
# From tdp-getting-started
terraform -chdir='tdp-lxd' apply
```

## Connect to a machine

```bash
# Connect to edge-01
lxc shell edge-01
```

## Start and stop containers

Terraform only controls the creation/update of resources, but not the status of the containers. The script `lxd-containers.sh` is provided to start/stop/restart all containers.

```bash
# Stop all containers (also works with 'start' and 'restart')
# From tdp-getting-started
./tdp-lxd/scripts/tdp-containers.sh stop

# To control a single container, use lxc CLI
lxc stop master-01
```

## Destroy the cluster

```bash
# From tdp-getting-started
terraform -chdir='tdp-lxd' destroy
```

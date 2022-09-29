# TDP LXD

Launch a fully-featured virtual TDP Hadoop cluster with a single command _or_ customize the infrastructure.

This is an alternative to [tdp-vagrant](https://github.com/TOSIT-IO/tdp-vagrant) which uses LXD containers instead of VMs.

## Requirements

- LXD (to operate Linux containers)
- Terraform >= 0.13 (to automatize containers lifecycle managment)

Install the Terraform modules with `terraform init`.

## Launch cluster

```bash
terraform apply
```

## Connect to machine

```bash
# Connect to edge
lxc shell edge-01
```

## Destroy cluster

```bash
terraform destroy
```

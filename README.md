## Homelab Terraform: Proxmox Infrastructure

This directory contains the **Terraform project** for provisioning homelab infrastructure on a Proxmox server.

### What it creates

- Virtual machines for:
  - `k3s-master-01` (k3s control-plane)
  - `k3s-worker-01` (k3s worker)
  - `gitlab` (self-hosted GitLab)
  - `harbor` (Harbor registry)
  - `jenkins` (CI/CD)
  - `monitoring` (VictoriaMetrics + Grafana + Loki)
  - `ingress` (Traefik / edge)
- Basic networking (bridge, IP addressing via cloud-init)
- Cloud-init based SSH access via your public key

### Structure

- `main.tf` — root Terraform configuration, Proxmox provider and module calls
- `variables.tf` — input variables for Proxmox connection and base template
- `modules/proxmox-vm/` — reusable module to create a VM from a cloud-init template

### Prerequisites

- Proxmox VE cluster or single node
- Terraform `>= 1.5.0`
- Proxmox API user with permissions to manage VMs
- Existing cloud-init template in Proxmox (Ubuntu/Debian recommended)

### Configuration

Provide values via `terraform.tfvars` or environment variables:

- `proxmox_api_url` — Proxmox API URL (e.g. `https://pve.local:8006/api2/json`)
- `proxmox_user` — Proxmox user (e.g. `root@pam` or `terraform@pve`)
- `proxmox_password` — user password (sensitive)
- `proxmox_tls_insecure` — allow self-signed certificates (default: `true`)
- `proxmox_node` — Proxmox node name where VMs will be created
- `base_template` — name/ID of the cloud-init template
- `ssh_public_key` — SSH public key to inject into VMs

### Usage

```bash
cd terraform

terraform init
terraform plan
terraform apply
```

After `apply`, Terraform will output **IP addresses of the key VMs**, which can be used as inventory for Ansible.


terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 3.0.0"
    }
  }
}

provider "proxmox" {
  # Defaults can be overridden via environment variables or tfvars.
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = var.proxmox_tls_insecure
}

# Basic example of creating several VMs via a module.
module "k3s_master" {
  source = "./modules/proxmox-vm"

  name        = "k3s-master-01"
  target_node = var.proxmox_node
  vmid        = 110

  cores  = 4
  memory = 8192
  disk_gb = 80

  template      = var.base_template
  ssh_public_key = var.ssh_public_key
}

module "k3s_worker_01" {
  source = "./modules/proxmox-vm"

  name        = "k3s-worker-01"
  target_node = var.proxmox_node
  vmid        = 120

  cores  = 4
  memory = 8192
  disk_gb = 80

  template       = var.base_template
  ssh_public_key = var.ssh_public_key
}

module "gitlab" {
  source = "./modules/proxmox-vm"

  name        = "gitlab"
  target_node = var.proxmox_node
  vmid        = 130

  cores  = 4
  memory = 8192
  disk_gb = 120

  template       = var.base_template
  ssh_public_key = var.ssh_public_key
}

module "harbor" {
  source = "./modules/proxmox-vm"

  name        = "harbor"
  target_node = var.proxmox_node
  vmid        = 140

  cores  = 4
  memory = 8192
  disk_gb = 80

  template       = var.base_template
  ssh_public_key = var.ssh_public_key
}

module "jenkins" {
  source = "./modules/proxmox-vm"

  name        = "jenkins"
  target_node = var.proxmox_node
  vmid        = 150

  cores  = 4
  memory = 8192
  disk_gb = 80

  template       = var.base_template
  ssh_public_key = var.ssh_public_key
}

module "monitoring" {
  source = "./modules/proxmox-vm"

  name        = "monitoring"
  target_node = var.proxmox_node
  vmid        = 160

  cores  = 4
  memory = 8192
  disk_gb = 80

  template       = var.base_template
  ssh_public_key = var.ssh_public_key
}

module "ingress" {
  source = "./modules/proxmox-vm"

  name        = "ingress"
  target_node = var.proxmox_node
  vmid        = 170

  cores  = 2
  memory = 4096
  disk_gb = 40

  template       = var.base_template
  ssh_public_key = var.ssh_public_key
}

output "vm_ips" {
  description = "IP addresses of key VMs"
  value = {
    k3s_master = module.k3s_master.ip_address
    k3s_worker = module.k3s_worker_01.ip_address
    gitlab     = module.gitlab.ip_address
    harbor     = module.harbor.ip_address
    jenkins    = module.jenkins.ip_address
    monitoring = module.monitoring.ip_address
    ingress    = module.ingress.ip_address
  }
}


variable "proxmox_api_url" {
  description = "Proxmox API URL, for example https://pve.local:8006/api2/json"
  type        = string
}

variable "proxmox_user" {
  description = "Proxmox user, for example root@pam or terraform@pve"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox user password"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Allow self-signed certificate for Proxmox API"
  type        = bool
  default     = true
}

variable "proxmox_node" {
  description = "Name of the Proxmox node where VMs are created"
  type        = string
}

variable "base_template" {
  description = "Name/ID of cloud-init template in Proxmox"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}


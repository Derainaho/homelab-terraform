variable "name" {
  description = "VM name"
  type        = string
}

variable "target_node" {
  description = "Proxmox node where the VM is created"
  type        = string
}

variable "vmid" {
  description = "Unique VM ID in Proxmox"
  type        = number
}

variable "template" {
  description = "Name/ID of the VM template (cloud-init)"
  type        = string
}

variable "cores" {
  description = "Number of vCPUs"
  type        = number
}

variable "memory" {
  description = "RAM amount in MB"
  type        = number
}

variable "disk_gb" {
  description = "Disk size in GB"
  type        = number
}

variable "storage" {
  description = "Storage name in Proxmox"
  type        = string
  default     = "local-lvm"
}

variable "bridge" {
  description = "Network bridge name, for example vmbr0"
  type        = string
  default     = "vmbr0"
}

variable "ip_cidr" {
  description = "Static VM IP address in CIDR format"
  type        = string
  default     = "dhcp"
}

variable "gateway" {
  description = "Default gateway"
  type        = string
  default     = ""
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}


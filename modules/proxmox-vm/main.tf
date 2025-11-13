resource "proxmox_vm_qemu" "vm" {
  name        = var.name
  target_node = var.target_node
  vmid        = var.vmid

  clone = var.template

  cores   = var.cores
  sockets = 1
  memory  = var.memory

  scsihw = "virtio-scsi-pci"

  disk {
    slot    = 0
    size    = "${var.disk_gb}G"
    type    = "scsi"
    storage = var.storage
  }

  network {
    model  = "virtio"
    bridge = var.bridge
  }

  sshkeys = var.ssh_public_key

  os_type = "cloud-init"

  ipconfig0 = "ip=${var.ip_cidr},gw=${var.gateway}"

  # Let Terraform wait until the VM is up.
  provisioner "local-exec" {
    command = "echo VM ${self.name} created with IP ${self.default_ipv4_address}"
  }
}

output "ip_address" {
  value       = proxmox_vm_qemu.vm.default_ipv4_address
  description = "IP address of the created VM"
}


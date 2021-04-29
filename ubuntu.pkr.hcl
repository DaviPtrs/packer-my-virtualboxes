
variable "cpus" {
  type    = string
  default = "1"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "vb_file_path" {
  type    = string
  default = "./ubuntu-18.04.ova"
}

variable "ssh_keypair_name" {
  type    = string
  default = "ed_25519"
}

source "virtualbox-ovf" "virtualbox" {
  source_path             = "${var.vb_file_path}"
  headless                = "${var.headless}"
  ssh_username            = "${var.ssh_username}"
  ssh_agent_auth          = true
  ssh_keypair_name        = "${var.ssh_keypair_name}"
  shutdown_command        = "sudo -S shutdown -P now"
  guest_additions_mode    = "disable"
  format                  = "ova"
}


build {
  sources = ["source.virtualbox-ovf.virtualbox"]

  # Enonic
  provisioner "ansible" {
    playbook_file = "/home/davi/repos/leanon-devops/enonic-project-remote/enonic.yml"
    inventory_file = "/home/davi/repos/leanon-devops/enonic-project-remote/inventory.ini"
    user = "ubuntu"
    local_port = 2222
  }
  
}

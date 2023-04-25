# vars.tf
variable "users" {
  type = list(object({
    username = string
    password = string
  }))
  default = []
  description = "Username to be created on the instance"
}

locals {
  users = var.users != [] ? var.users : [
    {
      username = "ubuntu"
      password = "test123"
    },
    {
      username = "ulak"
      password = "test123"
    }
  ]
}

variable "k8s" {
  version = "1.23.17"
  pod-network="10.244.0.0/16"
}

# main.tf
locals {
  common_packages = ["vim", "htop", "tree"]
}

resource "null_resource" "common_instance_config" {
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ${join(" ", local.common_packages)}",
      "sudo useradd -m -s /bin/bash ${var.users.ubuntu}"
    ]
  }
}
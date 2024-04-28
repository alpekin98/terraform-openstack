# vars.tf
variable "users" {
  type = list(object({
    username = string
    password = string
  }))
  default     = []
  description = "Username to be created on the instance"
}

variable "jemail" {
  default = "jenkins@ulakhaberlesme.com.tr"
}
variable "jname" {
  default = "jenkins.deneme"
}
variable "jpass" {
  default = "test123"
}
variable "vm_name" {
  default = "1"
}
variable "image_name" {
  default = "Ubuntu22_04"
}
variable "project_name" {
  default = "Development"
}
variable "flavor_name" {
  default = "12C_24R_75D"
}
variable "availability_zone" {
  default = "TempVMZone"
}

variable "NFS_IP_ADDRESS" {
  default = "192.168.57.27"
}
variable "NFS_USERNAME" {
  default = "ulak"
}

variable "NFS_PASSWORD" {
  default = "test123"
}

variable "GITLAB_TOKEN_NAME" {
  default = "Terraform_Token"
}

variable "GITLAB_TOKEN" {
  default = "rmyjjygxdpvb3MKzJ6S6"
}

variable "exp_date" {
  default = "24h"
}

variable "components" {
  default = ""
}

variable "openstackName" {
  default = ""
}

variable "openstackPassword" {
  default = ""
}

variable "openstackAuthUrl" {
  default = "openstack-sto.ulakhaberlesme.com.tr"
}

variable "openstackProjectName" {
  default = ""
}

variable "network_mgmt" {
  default = ""
}

variable "network_control" {
  default = ""
}

variable "network_public" {
  default = ""
}

variable "network_data" {
  default = ""
}

variable "network_floating" {
  default = ""
}

locals {
  users = var.users != [] ? var.users : [
    {
      username = "ubuntu"
      password = "test123"
    }
  ]
  timestamp         = timestamp()
  current_time      = formatdate("DD-MM-YYYY hh:mm ZZZ", timestamp())
  expire_date       = formatdate("DD-MM-YYYY hh:mm ZZZ", timeadd(timestamp(), var.exp_date))
  vm_name           = var.vm_name
  vm_image          = var.image_name
  vm_uname          = var.jname
  vm_pass           = var.jpass
  nfs_password      = var.NFS_PASSWORD
  nfs_username      = var.NFS_USERNAME
  nfs_ip            = var.NFS_IP_ADDRESS
  gitlab_token_name = var.GITLAB_TOKEN_NAME
  gitlab_token      = var.GITLAB_TOKEN
  components        = var.components

  # email = "${var.jemail}" 
  # ssh = "${var.ssh_key}" 
}

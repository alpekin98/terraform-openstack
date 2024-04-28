locals {
  metadata_default = { "managed-by-terraform" = true }
  tags_default     = ["managed-by-terraform=true"]
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.51.0"
    }
  }
}

output "auth_url" {
  value = var.openstackAuthUrl
}

# Provider tanımlaması
provider "openstack" {
  # OpenStack credential ayrıntıları

  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-api-erisimi.md
  # auth_url = "http://" + var.openstackAuthUrl + "/v3/"
  # auth_url = format("http://%s/v3/", var.openstackAuthUrl)
  # auth_url = "http://${var.openstackAuthUrl}/v3/"
  auth_url   = "http://${var.openstackAuthUrl}/v3/"


  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-api-erisimi.md#kullan%C4%B1c%C4%B1-bilgileri
  user_name = var.openstackName
  password  = var.openstackPassword
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-tennant.md
  tenant_name = "Development"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-region.md
  region = "RegionOne"
}

#Değişken IP havuzundan bir IP adresi belirleyelim
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "public"
}

# resource "openstack_networking_v2" "mgmtip_1" {
#   pool = "cinar-mgmt"
# }

# data "openstack_compute_keypair_v2" "kp_1" {
# # Kayıtlı hypervisor'ları listelemek için kullanılır
#   name = var.ssh_key
# }

# output "keypair_info" { 
#   value = { 
#     name = data.openstack_compute_keypair_v2.kp_1.name 
#     public_key = data.openstack_compute_keypair_v2.kp_1.public_key 
#   } 
# }

data "template_file" "user_data" {
  template = file("jammy-yeni.yaml")
  vars = {
    vm_uname = local.vm_uname
    vm_pass  = local.vm_pass
    fipp     = "${openstack_networking_floatingip_v2.fip_1.address}"
    #    mgmtipp           = "${openstack_networking_v2.mgmtip_1.address}"
    nfs_ip            = local.nfs_ip
    nfs_password      = local.nfs_password
    nfs_username      = local.nfs_username
    gitlab_token_name = local.gitlab_token_name
    gitlab_token      = local.gitlab_token
    components        = local.components
  }
}

data "template_file" "user_data2" {
  template = file("xenial-yeni.yaml")
  vars = {
    vm_uname = local.vm_uname
    vm_pass  = local.vm_pass
    fipp     = "${openstack_networking_floatingip_v2.fip_1.address}"
    #    mgmtipp           = "${openstack_networking_floatingip_v2.mgmtip_1.address}"
    nfs_ip            = local.nfs_ip
    nfs_password      = local.nfs_password
    nfs_username      = local.nfs_username
    gitlab_token_name = local.gitlab_token_name
    gitlab_token      = local.gitlab_token
    components        = local.components
  }
}

resource "openstack_compute_instance_v2" "vm_2" {
  # VM'in adı
  name = var.vm_name
  # VM'in kurulacağı yansının adı
  image_name = var.image_name
  # VM'in ayarlarını içeren config
  flavor_name = var.flavor_name
  # key_pair = var.ssh_key
  security_groups   = ["default"]
  availability_zone = "com111"

  # network {
  #   name = "cinar-control"
  #   # name = "STO-control"
  # }

  network {
    # name = "STO-mgmt"
    name = "cinar-mgmt"
  }

  network {
    name = "cinar-control"
    # name = "STO-control"
  }

  network {
    # name = "STO-public"
    name = "cinar-public"
  }

  network {
    # name = "STO-data"
    name = "cinar-data"
  }

  network {
    # name = "STO-data"
    name = "cinar-control"
  }

  metadata = {
    creation_date   = local.current_time
    expiration_date = local.expire_date
    email           = var.jemail
    flavor          = var.flavor_name
    project_name    = var.project_name
    created_by      = var.jname
    assigned_to     = var.jname
    description     = "${var.jname} dev makinesi"
    delete_after    = var.exp_date
  }

  user_data = var.image_name == "xenial-ubuntu-16.04" ? data.template_file.user_data2.rendered : data.template_file.user_data.rendered
}
resource "openstack_networking_port_v2" "port_1" {
  network_id = "42486caa-22bf-4b34-9eac-09556ebc9054"
}
# Belirlediğimiz Değişken IP ile kurduğumuz instance ı ilişkilendirelim
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.fip_1.address
  instance_id = openstack_compute_instance_v2.vm_2.id
  #port_id     = "${openstack_networking_port_v2.port_1.id}"
  fixed_ip = openstack_compute_instance_v2.vm_2.network.0.fixed_ip_v4
}


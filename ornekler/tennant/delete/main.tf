terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.51.0"
    }
  }
}

locals {
  proje_adi = "cem-proje"
}

# Provider tanımlaması
provider "openstack" {
  # OpenStack credential ayrıntıları

  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-api-erisimi.md
  auth_url = "http://controller:5000/v3/"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-api-erisimi.md#kullan%C4%B1c%C4%B1-bilgileri
  user_name = "cemtopkaya"
  password = "q1w2e3r4"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-tennant.md
  tenant_name = "osmtest"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-region.md
  region = "RegionOne"
}

# Sadece adını bildiğim tennant'ı aşağıdaki gibi kaynak olarak tanımlayabiliriz
resource "openstack_identity_project_v3" "proje-sil" {
  name        = local.proje_adi
  lifecycle {
    ignore_changes = [
      name,
    ]
  }
}

# İçinde tanımlı bir kaynak var mı diye kontrol etmeden silmek için (geri dönülemez!!!)
# aşağıdaki kodu çalıştırabiliriz ama tüm kaynaklarla birlikte silmek en doğru olanıdır.

# Find all resources associated with the project
data "openstack_compute_instance_v2" "instances" {
  project_id = openstack_identity_project_v3.proje-sil.id
}

data "openstack_networking_port_ids_v2" "ports" {
  # for_each = data.openstack_identity_project_v3.proje-sil
  # project_id = each.value.id
  project_id = openstack_identity_project_v3.proje-sil.id
}

output "port_ids" {
  value = data.openstack_networking_port_ids_v2.ports[*]
}
data "openstack_networking_floatingip_v2" "floating_ips" {
  port_id = openstack_identity_project_v3.proje-sil.id
}

data "openstack_networking_port_v2" "ports" {
  project_id = openstack_identity_project_v3.proje-sil.id
}

# Delete all resources associated with the project
resource "openstack_compute_instance_v2" "instance_delete" {
  for_each = data.openstack_compute_instance_v2.instances
  instance_id = each.value.id
  delete_on_termination = true
}

# resource "openstack_networking_floatingip_associate_v2" "floating_ips_delete" {
#   for_each = data.openstack_networking_floatingip_v2.floating_ips
#   floating_ip = each.value.id
#   port_id = null
# }

# output "instance_ips" {
#   value = { for instance in data.openstack_networking_port_v2.example : instance.id => instance.network.0.fixed_ip_v4 }
# }

# resource "openstack_networking_port_v2" "ports_delete" {
#   # port_id = [for p in data.openstack_networking_port_v2.ip_address: p.id]
#   security_group_ids = null
#   device_id = null
# }
# output "port_names" {
#   value = [
#     for port in openstack_networking_port_v2.ports_delete :
#     port.name
#   ]
# }
resource "openstack_networking_port_v2" "example" {
  count = 3
network_id = 1
  name = "example-port-${count.index}"
}

output "port_names" {
  value = [
    for port in openstack_networking_port_v2.example :
    port.name
  ]
}
# resource "openstack_networking_port_v2" "ports_delete_final" {
#   for_each = data.openstack_networking_port_v2.ports
#  # port_id = each.value.id
#   ips = each.all_fixed_ips[0]
# }

# Finally, delete the project
resource "openstack_identity_project_v3" "project_delete" {
  name = var.project_name
  id   = openstack_identity_project_v3.proje-sil.id
  lifecycle {
    ignore_changes = [
      name,
    ]
  }
  depends_on = [
    openstack_compute_instance_v2.instance_delete,
    openstack_networking_floatingip_associate_v2.floating_ips_delete,
    openstack_networking_port_v2.ports_delete,
    openstack_networking_port_v2.ports_delete_final,
  ]
}
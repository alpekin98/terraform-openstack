terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.51.0"
    }
  }
}

provider "openstack" {
  auth_url     = var.openstack_auth_url
  user_name    = var.openstack_username
  password     = var.openstack_password
  tenant_name  = var.openstack_tenant_name
  region       = var.openstack_region
}

# OpenStack'te tanımlı ağları çeken kaynak
# data "openstack_networking_network_v2" "all_networks" {}

# OpenStack'te tanımlı alt ağları çeken kaynak
# data "openstack_networking_subnets_v2" "all_subnets" {}
# data "openstack_networking_subnet_ids_v2" "all_subnets" {}
# data "openstack_networking_subnet_v2" "all_subnets" {}

# OpenStack'te tanımlı ağı çeken kaynak
data "openstack_networking_network_v2" "aranan_ag" {
  mtu=1450
  name="cnr-data2"
}

# İlk ağı ekrana yazan çıktı
output "aranan_cnr-data2_ağı" {
  value = {
    network = data.openstack_networking_network_v2.aranan_ag
  }
}

# OpenStack'te tanımlı ağları çeken kaynak
data "openstack_networking_network_v2" "all_networks" {
  region = "RegionOne"
}

# İlk ağı almak için sıralama ve indeksleme
# locals {
#   first_network = data.openstack_networking_network_v2.all_networks[0]
# }

# İlk ağı ekrana yazan çıktı
# output "ilk_ağ" {
#   # value = openstack_networking_network_v2.all_networks
#   value = {
#     network = local.first_network
#   }
# }

# Tüm ağları tek tek yazdırmak için for_each kullanımı
# output "all_networks" {
#   value = {
#     for network_id in data.openstack_networking_network_v2.all_networks.*.id : network_id => data.openstack_networking_network_v2.all_networks[network_id]
#   }
# }


# Print first two networks in all_networks with for_each
output "first_two_networks" {
  value = {
      # cem = data.openstack_networking_network_v2.all_networks.*.id[0]
      # instance_id = each.value
    for network_id in slice(keys(data.openstack_networking_network_v2.all_networks), 0, 2) : 
    network_id => data.openstack_networking_network_v2.all_networks[network_id]
  }
}


# Çekilen ağları ve alt ağları ekrana yazan çıktı
# output "networks_and_subnets" {
#   value = {
#     network = data.openstack_networking_network_v2.single_network
#     # networks = data.openstack_networking_network_v2.all_networks

#     # networks = data.openstack_networking_networks_v2.all_networks.names
#     # subnets  = data.openstack_networking_subnets_v2.all_subnets.cidrs
#     # subnets  = data.openstack_networking_subnet_ids_v2.all_subnets.cidrs
#   }
# }

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.51.0"
    }
  }
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

resource "openstack_networking_network_v2" "cinar_public_network" {
  name          = "cinar-public"
  admin_state_up = true
  shared        = true
  external      = false
  provider_network_type = "vxlan"
  availability_zone_hints = []
  availability_zones = [
    "nova"
  ]
  provider_segmentation_id = 65591
}

resource "openstack_networking_subnet_v2" "cinar_public_subnet" {
  name            = "cinar-public-subnet"
  network_id      = openstack_networking_network_v2.cinar_public_network.id
  cidr            = "10.10.20.0/24"
  ip_version      = 4
  enable_dhcp     = true
  gateway_ip      = "10.10.20.1"
  dns_nameservers = [
    "8.8.8.8"
  ]
  allocation_pools {
    start = "10.10.20.2"
    end   = "10.10.20.200"
  }
}

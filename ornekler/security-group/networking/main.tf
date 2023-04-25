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

# Define security group for HTTP traffic
resource "openstack_networking_secgroup_v2" "cem_http_secgroup" {
  name = "cem_http_secgroup"
  description = "Allow HTTP traffic"
}

# Define security group for SSH traffic
resource "openstack_networking_secgroup_v2" "cem_ssh_secgroup" {
  name = "cem_ssh_secgroup"
  description = "Allow SSH traffic"
}

# Define security group rule to allow incoming HTTP traffic
resource "openstack_networking_secgroup_rule_v2" "cem_http_rule" {
  direction = "ingress"
  ethertype = "IPv4"
  port_range_min = 80
  port_range_max = 80
  protocol = "tcp"
  security_group_id = openstack_networking_secgroup_v2.cem_http_secgroup.id
}

# Define security group rule to allow incoming SSH traffic
resource "openstack_networking_secgroup_rule_v2" "cem_ssh_rule" {
  direction = "ingress"
  ethertype = "IPv4"
  port_range_min = 22
  port_range_max = 22
  protocol = "tcp"
  security_group_id = openstack_networking_secgroup_v2.cem_ssh_secgroup.id
}

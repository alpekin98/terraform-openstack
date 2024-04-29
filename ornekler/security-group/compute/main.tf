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
  password = "******"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-tennant.md
  tenant_name = "osmtest"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-region.md
  region = "RegionOne"
}

module "example_security_group" {
  source = "terraform-openstack-modules/security_group/openstack"

  security_group_name = "example-security-group"
  security_group_description = "An example security group"
  security_group_rules = [
    {
      name       = "example-rule-1"
      description= "Example rule 1"
      direction  = "ingress"
      protocol   = "tcp"
      port_range_min = "22"
      port_range_max = "22"
      remote_ip_prefix = "0.0.0.0/0"
    },
    {
      name       = "example-rule-2"
      description= "Example rule 2"
      direction  = "egress"
      protocol   = "icmp"
      remote_ip_prefix = "0.0.0.0/0"
    }
  ]
}
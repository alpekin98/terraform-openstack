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

# Bir proje tanımı yapıyoruz ve bu tanıma uygun kaynakları peşi sıra ekleyeceğiz
resource "openstack_identity_project_v3" "proje-cem" {
  name        = "cem-proje"
  description = "Bu proje sunun icin bunun icin vs. tanimlar"
}

# Bu projeye bir kullanıcı ekliyoruz
resource "openstack_identity_user_v3" "user_proje-cem" {
  name               = "cem-user"
  default_project_id = openstack_identity_project_v3.proje-cem.id
  password = "sifre123"
}
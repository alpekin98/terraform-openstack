# Terraform dosyası için gerekli versiyon belirtilir
terraform {
  required_version = ">= 1.0.0"

  # Kullanılan sağlayıcılar ve versiyonları belirtilir
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.51.0"
    }
  }
}

# Çıktılar tanımlanır
output "auth_url" {
  value = var.openstack_auth_url
}

# OpenStack sağlayıcısı tanımlanır
provider "openstack" {
  # OpenStack kimlik bilgileri
  auth_url    = var.openstack_auth_url
  user_name   = var.openstack_username
  password    = var.openstack_password
  tenant_name = "Development"
  region      = "RegionOne"
}

# Değişken IP havuzundan bir IP adresi belirlemek için kaynak tanımlanır
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = var.network_floating
}

#openstack_networking_floatingip_v2.fip_1 will be created
# resource "openstack_networking_floatingip_v2" "fip_1" {
#   + address    = (known after apply)
#   + all_tags   = (known after apply)
#   + dns_domain = (known after apply)
#   + dns_name   = (known after apply)
#   + fixed_ip   = (known after apply)
#   + id         = (known after apply)
#   + pool       = "public"
#   + port_id    = (known after apply)
#   + region     = (known after apply)
#   + subnet_id  = (known after apply)
#   + tenant_id  = (known after apply)
# }
# Bu komutun işlenmesi halinde Floating IP üretilir ve IP adresi aşağıdaki gibi çekilir:
output "floating_ip" {
  value = openstack_networking_floatingip_v2.fip_1
}

# Belirlediğimiz Değişken IP ile kurduğumuz instance ı ilişkilendirelim
# resource "openstack_compute_floatingip_associate_v2" "fip_1" {
#   floating_ip = openstack_networking_floatingip_v2.fip_1.address
#   instance_id = openstack_compute_instance_v2.vm_2.id
#   fixed_ip    = openstack_compute_instance_v2.vm_2.network.0.fixed_ip_v4
# }

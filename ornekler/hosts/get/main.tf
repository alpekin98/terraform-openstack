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

# OpenStack sağlayıcısı tanımlanır
provider "openstack" {
  # OpenStack kimlik bilgileri
  auth_url    = var.openstack_auth_url
  user_name   = var.openstack_username
  password    = var.openstack_password
  tenant_name = "Development"
  region      = "RegionOne"
}

# OpenStack üzerindeki tüm hypervisor'ları getirir
# Gerekli filtreleri buraya ekleyebilirsiniz, örneğin availability_zone, state vb.
data "openstack_compute_hypervisor_v2" "found_one" {
  hostname = var.hostname
}

output "Bulunan_hypervisor" {
  value = data.openstack_compute_hypervisor_v2.found_one
}

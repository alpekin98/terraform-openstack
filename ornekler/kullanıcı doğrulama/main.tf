# main.tf
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
  value = var.openstack_auth_url
}

# OpenStack sağlayıcısının tanımlanması
provider "openstack" {
  # OpenStack bulutunuza özgü credential bilgileri
  auth_url    = var.openstack_auth_url
  user_name   = var.openstack_username
  password    = var.openstack_password
  tenant_name = var.openstack_project_name
}

# Kullanıcı doğrulama verisi için data kaynağının tanımlanması
data "openstack_identity_user_v3" "current_user" {
  # Doğrulanacak kullanıcının adı (cemtopkaya değeri olabilir)
  name = var.user_name
}

# Kullanıcı bilgilerinin çıktı olarak gösterilmesi
output "user_info" {
  value = {
    id             = data.openstack_identity_user_v3.current_user.id
    name           = data.openstack_identity_user_v3.current_user.name
    description    = data.openstack_identity_user_v3.current_user.description
    enabled        = data.openstack_identity_user_v3.current_user.enabled
    domain         = data.openstack_identity_user_v3.current_user.domain_id
    project        = data.openstack_identity_user_v3.current_user.default_project_id
  }
}

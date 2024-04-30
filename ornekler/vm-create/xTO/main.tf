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


# Değişken IP havuzundan bir IP adresi belirlemek için kaynak tanımlanır
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = var.network_floating
}

# Bu komutun işlenmesi halinde Floating IP üretilir ve IP adresi aşağıdaki gibi çekilir:
output "floating_ip" {
  value = openstack_networking_floatingip_v2.fip_1.address
}

# Kullanıcı verileri için şablon dosyası tanımlanır
data "template_file" "user_data_jammy" {
  template = file("jammy.yaml")
  vars = {
    vm_name           = var.vm_name
    vm_user_name      = var.vm_user_name
    vm_user_pass      = var.vm_user_pass
    fipp              = openstack_networking_floatingip_v2.fip_1.address
    nfs_ip            = var.nfs_ip_address
    nfs_password      = var.nfs_password
    nfs_username      = var.nfs_username
    gitlab_token_name = var.gitlab_token_name
    gitlab_token      = var.gitlab_token
    components        = var.components
    common_packages   = var.common_packages
  }
}

data "template_file" "user_data_xenial" {
  template = file("xenial.yaml")
  vars = {
    vm_name           = var.vm_name
    vm_user_name      = var.vm_user_name
    vm_user_pass      = var.vm_user_pass
    fipp              = openstack_networking_floatingip_v2.fip_1.address
    nfs_ip            = var.nfs_ip_address
    nfs_password      = var.nfs_password
    nfs_username      = var.nfs_username
    gitlab_token_name = var.gitlab_token_name
    gitlab_token      = var.gitlab_token
    components        = var.components
    common_packages   = var.common_packages
  }
}

# Sanal makine örneği tanımlanır
resource "openstack_compute_instance_v2" "vm_2" {
  name              = var.vm_name
  image_name        = var.image_name
  flavor_name       = var.flavor_name
  security_groups   = ["default"]
  # availability_zone = var.availability_zone
  availability_zone_hints = "com115"
  # scheduler_hints {
  #   target_cell = "com115"
  # }

  # Sanal makine için ağ bağlantıları tanımlanır
  network {
    name = var.network_mgmt
  }

  network {
    name = var.network_control
  }

  network {
    name = var.network_public
  }

  network {
    name = var.network_data
  }

  metadata = {
    # creation_date   = local.current_time
    # expiration_date = local.expire_date
    email        = var.vm_user_email
    flavor       = var.flavor_name
    project_name = var.project_name
    created_by   = var.vm_user_name
    assigned_to  = var.vm_user_name
    description  = "${var.vm_user_name} dev makinesi"
    delete_after = var.expiration_date
  }

  user_data = var.image_name == "xenial-ubuntu-16.04" ? data.template_file.user_data_xenial.rendered : data.template_file.user_data_jammy.rendered
}

# Belirlediğimiz Değişken IP ile kurduğumuz instance ı ilişkilendirelim
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.fip_1.address
  instance_id = openstack_compute_instance_v2.vm_2.id
  fixed_ip    = openstack_compute_instance_v2.vm_2.network.0.fixed_ip_v4
}

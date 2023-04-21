# Terraform İle Openstack Üstünde VM Oluşturmak

variables.tf Dosyasında genel değişkenleri tanımlıyor, diğer dosyalarda bu değişkenleri kullanıyoruz.
```
variable  "user_name"{
    default = "cemtopkaya"
}   
variable  "password"{
    default  = "sifre123"
}   
variable  "auth_url"{
    default  = "http://vipcontroller:5000/v3/"
}   
variable  "tenant_name"{
    default = "osm"
}
variable "ssh_key_pair" {
  default = "cemtopkaya_ssh_keys"
}
```

main.tf
```
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}
provider "openstack" {
  user_name   = var.user_name
  password    = var.password
  auth_url    = var.auth_url
  tenant_name = var.tenant_name
}

resource "openstack_compute_keypair_v2" "keypair" {
  name = var.ssh_key_pair
}

resource "openstack_compute_instance_v2" "instance" {
  name            = "cem_instance_deneme"
  image_name      = "Ubuntu-22-04-LTS"
  flavor_name     = "2C-2R-50D"
  key_pair        = openstack_compute_keypair_v2.keypair.name
  security_groups = ["default"]
  user_data = "#!/bin/bash\napt update\napt-get install -y nginx"

  network {
    name = "cinar-mgmt"
  }

  metadata = {
    delete_after = "20 minutes"
    time_to_destroy = "2023-04-21T16:31:00Z"
  }

  availability_zone = "cnr203"
}
```

Şimdi `terraform init` ve `terraform apply` komutlarıyla sunucuyu yaratıyoruz.

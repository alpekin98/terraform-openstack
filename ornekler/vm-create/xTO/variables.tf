# Kullanıcı Bilgileri
variable "users" {
  type        = list(object({
    username = string
    password = string
  }))
  default     = []
  description = "Yaratılacak kullanıcı adları ve şifreleri. Örneğin: [{ username = 'user1', password = 'password1' }, { username = 'user2', password = 'password2' }]"
}

variable "vm_user_email" {
  default     = "cem.topkaya@ulakhaberlesme.com.tr"
  description = "VM kullanıcısının e-posta adresi"
}

variable "vm_user_name" {
  default     = "cem.topkaya"
  description = "VM kullanıcısının adı"
}

variable "vm_user_pass" {
  default     = "test123"
  description = "VM kullanıcısının şifresi"
}

# Sanal Makine Bilgileri
variable "vm_name" {
  default     = "cem-topkaya-vm"
  description = "Sanal makinenin adı"
}

variable "image_name" {
  default     = "Ubuntu22_04"
  description = "Sanal makine görüntüsünün adı"
}

variable "project_name" {
  default     = "Development"
  description = "Proje adı"
}

variable "flavor_name" {
  default     = "12C_24R_75D"
  description = "Sanal makine boyutu"
}

variable "availability_zone" {
  default     = "TempVMZone"
  description = "Kullanılabilirlik bölgesi"
}

# NFS ve GitLab Bilgileri
variable "nfs_ip_address" {
  default     = "192.168.57.27"
  description = "NFS sunucunun IP adresi"
}

variable "nfs_username" {
  default     = "ulak"
  description = "NFS sunucusuna bağlanmak için kullanıcı adı"
}

variable "nfs_password" {
  default     = "test123"
  description = "NFS sunucusuna bağlanmak için şifre"
}

variable "gitlab_token_name" {
  default     = "Terraform_Token"
  description = "GitLab token'ın adı"
}

variable "gitlab_token" {
  default     = "rmyjjygxdpvb3MKzJ6S6"
  description = "GitLab token'ı"
}

# VM'e Ait Diğer Bilgiler
variable "expiration_date" {
  default     = "24h"
  description = "Sanal makinenin son kullanma tarihi"
}

variable "components" {
  default     = ""
  description = "Kurulacak bileşenler"
}

variable "common_packages" {
  default     = ""
  description = "Kurulacak temel bileşenler"
}

# OpenStack ve Ağ Bilgileri
variable "openstack_username" {
  default     = ""
  description = "OpenStack kullanıcı adı"
}

variable "openstack_password" {
  default     = ""
  description = "OpenStack şifresi"
}

variable "openstack_auth_url" {
  default     = "openstack-sto.ulakhaberlesme.com.tr"
  description = "OpenStack yetkilendirme URL'si"
}

variable "openstack_project_name" {
  default     = ""
  description = "OpenStack proje adı"
}

variable "network_mgmt" {
  default     = ""
  description = "Yönetim ağı"
}

variable "network_control" {
  default     = ""
  description = "Kontrol ağı"
}

variable "network_public" {
  default     = ""
  description = "Genel ağ"
}

variable "network_data" {
  default     = ""
  description = "Veri ağı"
}

variable "network_floating" {
  default     = ""
  description = "Floating ağ"
}

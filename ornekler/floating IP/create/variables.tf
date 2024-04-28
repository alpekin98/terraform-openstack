
variable "project_name" {
  default     = "Development"
  description = "Proje adı"
}

variable "availability_zone" {
  default     = "TempVMZone"
  description = "Kullanılabilirlik bölgesi"
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


variable "network_floating" {
  default     = ""
  description = "Floating ağ"
}

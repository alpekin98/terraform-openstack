# Güvenlik Grupları

Tanımlı güvenlik gruplarını çekmek için:

![image](https://user-images.githubusercontent.com/261946/233794563-0f8b830b-ecfd-48d6-b3bb-aeb4ae4933a0.png)

![image](https://user-images.githubusercontent.com/261946/233797779-1a38eb2f-449b-42ad-80f4-e0f5ee8cb3c0.png)

```shell
curl --request GET \
  --url http://controller:9696/v2.0/security-groups \
  --header 'X-Auth-Token: gAAAAABkRBSgiWSKR2DY6mJ-UOyMO-....'
```

"openstack_networking_secgroup_v2" ile "openstack_compute_security_group_v2"  arasında ne fark var?
"openstack_networking_secgroup_v2" kaynak türü, OpenStack Networking servisi tarafından sağlanan güvenlik gruplarını yönetmek için kullanılır. Bu güvenlik grupları, sanal makinelerin ağ trafiğini kontrol etmek ve yönetmek için kullanılabilir. "openstack_networking_secgroup_v2" kaynak türü, portlar, protokoller, IP aralıkları ve güvenlik kuralları gibi ayrıntılı ağ trafiği kontrolleri sağlayarak güvenlik grubunu tanımlayabilir.

Diğer yandan, "openstack_compute_security_group_v2" kaynak türü, OpenStack Compute servisi tarafından sağlanan güvenlik gruplarını yönetmek için kullanılır. Bu güvenlik grupları, sanal makinelerin ağ trafiğini kontrol etmek ve yönetmek için kullanılabilir. "openstack_compute_security_group_v2" kaynak türü, aynı şekilde portlar, protokoller, IP aralıkları ve güvenlik kuralları gibi ayrıntılı ağ trafiği kontrolleri sağlayarak güvenlik grubunu tanımlayabilir.

Fark, bu kaynak türlerinin yönettiği güvenlik gruplarının kullanım amaçlarında değil, hangi OpenStack servisi tarafından sağlandıklarındadır. "openstack_networking_secgroup_v2" güvenlik grupları, ağ trafiği kontrolü için OpenStack Networking servisi tarafından sağlanırken, "openstack_compute_security_group_v2" güvenlik grupları, OpenStack Compute servisi tarafından sağlanır.

### openstack_networking_secgroup_v2

```terraform
resource "openstack_networking_secgroup_v2" "web_security_group" {
  name = "cemtopkaya_security_group"
  description = "Asagidaki guvenlik kurallariyla trafik yonlendirilecek"

  rule {
    direction = "ingress"
    ethertype = "IPv4"
    protocol = "tcp"
    port_range_min = 80
    port_range_max = 80
  }

  rule {
    direction = "ingress"
    ethertype = "IPv4"
    protocol = "tcp"
    port_range_min = 22
    port_range_max = 22
  }
}
```

### openstack_compute_security_group_v2

```terraform
resource "openstack_compute_security_group_v2" "default" {
  name        = "default"
  description = "Default security group"
  tenant_id   = "cd6c5b55cee546c6811fb6c622b81aed"
}

resource "openstack_compute_security_group_rule_v2" "ingress_rule" {
  direction      = "ingress"
  security_group_id = openstack_compute_security_group_v2.default.id
  remote_group_id   = "01a3541a-51a0-4bd7-b2d4-a9a9eb19677c"
  ethertype        = "IPv6"
}

resource "openstack_compute_security_group_rule_v2" "egress_tcp_rule" {
  direction       = "egress"
  security_group_id  = openstack_compute_security_group_v2.default.id
  protocol        = "tcp"
  port_range_min  = 1
  port_range_max  = 65535
  remote_ip_prefix = "0.0.0.0/0"
  ethertype       = "IPv4"
}
```

---

# Örnekler

## Güvenlik Grupları Oluşturmak

```terraform
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
```

Yukarıdaki kodun çıktısı:

![image](https://user-images.githubusercontent.com/261946/233836141-12b97067-4d8d-4e57-bfe6-ff4d25a11ca2.png)

![image](https://user-images.githubusercontent.com/261946/233836155-3493c40d-287a-4b3a-a0a7-93fdf11dfabc.png)

![image](https://user-images.githubusercontent.com/261946/233836162-7a447c4d-13d2-4ed9-8933-fedbc32f2ffe.png)




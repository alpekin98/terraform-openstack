# Tennant (Projeler) Listesini Çekmek

Tennat bilgisi OpenStack'de proje'ye denk gelir.

```shell
curl --request GET \
  --url http://controller:35357/v2.0/tenants \
  --header 'X-Auth-Token: gAAAAABkRNpw0ewH9FnL72w6LkoEa1JW....'
```

![image](https://user-images.githubusercontent.com/261946/233825978-b88c1f8b-53fa-4ff9-847b-9566dda2a84b.png)

![image](https://user-images.githubusercontent.com/261946/233826177-9462c8bc-a1bb-4bca-957e-7464995fde24.png)

## Tennant Oluşturmak 

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
  password = "****"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-tennant.md
  tenant_name = "osmtest"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-region.md
  region = "RegionOne"
}

resource "openstack_identity_project_v3" "cem-tennant" {
  name        = "cem-proje"
  description = "Bu proje sunun icin bunun icin vs. tanimlar"
}
```

![image](https://user-images.githubusercontent.com/261946/234690164-db638170-ccfb-4e2d-a854-7562419aeded.png)

![image](https://user-images.githubusercontent.com/261946/234690053-d7270f3f-5bec-404e-a29b-7a7c936165ad.png)



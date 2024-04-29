## Çalıştır


### terraform.tfvars Dosyası Kullanarak
Tüm değerleri `terraform.tfvars` varsayılan değişkenlerden çeken terminal komutu:

```shell
clear
terraform apply -auto-approve
```

### -var-file İle Değişken Dosyası Kullanarak
Hem varsa içindeki değerleri `terraform.tfvars` varsayılan dosyasından hem de başka değişkenleri `sto.tfvars` dosyasından çeken terminal komutu:

```shell
clear
terraform apply -var-file=sto.tfvars -auto-approve
```

### -var İle Değişkenleri Konsoldan Vermek
Tüm değişkenleri konsoldan da verebiliriz. Ancak yine de `terraform.tfvars` dosyasını okur ve konsoldan gelen değişkenlerle ezerek çalıştırır. İşte konsol komutu:

```shell
clear
# Değişkenlerin tanımlanması
openstack_auth_url="http://openstack-sto.ulakhaberlesme.com.tr"
openstack_username="tempvm_creator"
openstack_password="yok_olmuyor789"
openstack_project_name="development"
user_name_to_check="cemtopkaya"
terraform apply \
    -var "openstack_auth_url=${openstack_auth_url}" \
    -var "openstack_username=${openstack_username}" \
    -var "openstack_password=${openstack_password}" \
    -var "openstack_project_name=${openstack_project_name}" \
    -var "user_name=${user_name_to_check}" \
    -auto-approve
```

### Ortam Değişkenlerini Kullanarak
Dilerseniz bazı değişkenleri `TF_` önekiyle ortam değişkeni olarak da verebilirsiniz. Yine de `terraform.tfvars` dosyasını okuyacak ve konsoldan gelen değişkenlerle ezerek çalıştırır. İşte konsol komutu:

```shell
clear
# Ortam değişkenlerinden çeksin diye user_name değişkenini veriyoruz
export TF_VAR_user_name="cemtopkaya"
export TF_VAR_openstack_username="tempvm_creator"
export TF_VAR_openstack_password="yok_olmuyor789"

# Değişkenlerin tanımlanması
openstack_auth_url="http://openstack-sto.ulakhaberlesme.com.tr"
openstack_project_name="development"

terraform apply \
    -var "openstack_auth_url=${openstack_auth_url}" \
    -var "openstack_project_name=${openstack_project_name}" \
    -auto-approve
```


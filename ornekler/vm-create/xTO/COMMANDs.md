## Çalıştır



```shell
clear
TF_LOG=DEBUG
terraform plan -var-file=vto.tfvars
```


```shell
clear
export TF_LOG="INFO"
terraform apply -var-file=vto.tfvars -auto-approve
```

```shell
clear
export TF_LOG="INFO"
# Değişkenlerin tanımlanması
user_email="cem.topkaya@ulakhaberlesme.com.tr"
user_id="cem.topkaya"
vm_user_pass="sifre123"
BUILD_NUMBER="$((RANDOM % 1001))"
openstack_project_name="development"
openstack_availability_zone="TempVmZone"
selectedComponents=""
openstackUserName="tempvm_creator"
openstackUserPassword="yok_olmaz789"
openstack_auth_url="openstack-sto.ulakhaberlesme.com.tr"
# STO
openstack_networks_mgmt="STO-Mgmt"
openstack_networks_public="STO-Public"
openstack_networks_data="STO-Data"
openstack_networks_control="STO-Control"
openstack_networks_floating="flat"
# VTO
# openstack_networks_mgmt="cinar-mgmt"
# openstack_networks_public="cinar-public"
# openstack_networks_data="cinar-data"
# openstack_networks_control="cinar-control"
# openstack_networks_floating="public"

terraform apply \
    -var "jenkins_email=${user_email}" \
    -var "vm_user_name=${user_id}" \
    -var "jenkins_password=${vm_user_pass}" \
    -var "vm_name=${user_id}.${BUILD_NUMBER}.dev" \
    -var "image_name=${image}" \
    -var "project_name=${openstack_project_name}" \
    -var "flavor_name=${flavor}" \
    -var "availability_zone=${openstack_availability_zone}" \
    -var "expiration_date=${openstack_defaultVmExpire}" \
    -var "components=${selectedComponents}" \
    -var "openstack_username=${openstackUserName}" \
    -var "openstack_password=${openstackUserPassword}" \
    -var "openstack_auth_url=${openstack_auth_url}" \
    -var "openstack_project_name=${openstack_project_name}" \
    -var "network_mgmt=${openstack_networks_mgmt}" \
    -var "network_control=${openstack_networks_control}" \
    -var "network_public=${openstack_networks_public}" \
    -var "network_data=${openstack_networks_data}" \
    -var "network_floating=${openstack_networks_floating}" \
    -auto-approve

```




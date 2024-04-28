## Çalıştır

```shell
# Değişkenlerin tanımlanması
user_email="cem.topkaya@ulakhaberlesme.com.tr"
user_id="cem.topkaya"
vm_user_pass="q1w2e3r4"
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
    -var "jemail=${user_email}" \
    -var "jname=${user_id}" \
    -var "jpass=${vm_user_pass}" \
    -var "vm_name=${user_id}.${BUILD_NUMBER}.dev" \
    -var "image_name=${image}" \
    -var "project_name=${openstack_project_name}" \
    -var "flavor_name=${flavor}" \
    -var "availability_zone=${openstack_availability_zone}" \
    -var "exp_date=${openstack_defaultVmExpire}" \
    -var "components=${selectedComponents}" \
    -var "openstackName=${openstackUserName}" \
    -var "openstackPassword=${openstackUserPassword}" \
    -var "openstackAuthUrl=${openstack_auth_url}" \
    -var "openstackProjectName=${openstack_project_name}" \
    -var "network_mgmt=${openstack_networks_mgmt}" \
    -var "network_control=${openstack_networks_control}" \
    -var "network_public=${openstack_networks_public}" \
    -var "network_data=${openstack_networks_data}" \
    -var "network_floating=${openstack_networks_floating}" \
    -auto-approve
```
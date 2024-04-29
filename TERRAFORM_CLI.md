## Openstack Komut Satırı Arayüzünü Kullanmak
`openstack` CLI uygulama paketini yüklemek için [openstack resmi sayfasında](https://docs.openstack.org/mitaka/user-guide/common/cli_install_openstack_command_line_clients.html) yönergeleri takip edebilirsiniz.

Hızlıca yüklemek için:

```shell
pip install python-openstackclient
```

```shell
$ openstack hypervisor list
```

Kullanıcı doğrulama yöntemleri için [bu sayfayı](https://docs.openstack.org/python-openstackclient/latest/cli/man/openstack.html#authentication-methods) ziyaret edebilirsiniz.

```shell
export OS_AUTH_URL=<url-to-openstack-identity>
export OS_PROJECT_NAME=<project-name>
export OS_USERNAME=<user-name>
export OS_PASSWORD=<password>  # (optional)
```

```shell
$ OS_PASSWORD=sifre123 openstack \
    --os-auth-url http://openstack-vto.ulakhaberlesme.com.tr \
    --os-username cemtopkaya  \
    hypervisor list
```

```shell
$ export OS_USERNAME=cemtopkaya
$ export OS_PASSWORD=q1w2e3r4
$ export OS_AUTH_URL=http://openstack-vto.ulakhaberlesme.com.tr
$ openstack hypervisor list
```

```shell
$ openstack --os-auth-url http://openstack-vto.ulakhaberlesme.com.tr \
    --os-username cemtopkaya \
    --os-password sifre123 \
    hypervisor list
```

Aşağıdaki CLI uygulamaları ve hangi alanda çalışacağını görebilirsiniz:
- `barbican` - Key Manager Service API
- `ceilometer` - Telemetry API
- `cinder` - Block Storage API and extensions
- `cloudkitty` - Rating service API
- `designate` - DNS service API
- `fuel` - Deployment service API
- `glance` - Image service API
- `gnocchi` - Telemetry API v3
- `heat` - Orchestration API
- `keystone` - Identity service API and extensions
- `magnum` - Containers service API
- `manila` - Shared file systems API
- `mistral` - Workflow service API
- `monasca` - Monitoring API
- `murano` - Application catalog API
- `neutron` - Networking API
- `nova` - Compute API and extensions
- `sahara` - Data Processing API
- `senlin` - Clustering service API
- `swift` - Object Storage API
- `trove` - Database service API

#### Identity (keystone)
```shell
# List all users
$ keystone user-list

# List Identity service catalog
$ keystone catalog
```


#### Images (glance)[*](https://docs.openstack.org/mitaka/user-guide/cli_cheat_sheet.html#images-glance)
```shell
# List images you can access
$ glance image-list

# Delete specified image
$ glance image-delete IMAGE

# Describe a specific image
$ glance image-show IMAGE

# Update image
$ glance image-update IMAGE
```


#### Compute (nova)[*](https://docs.openstack.org/mitaka/user-guide/cli_cheat_sheet.html#compute-nova)
```shell
# List instances, check status of instance
$ nova list

# List images
$ nova image-list

# List flavors
$ nova flavor-list
```


#### Networking (neutron)[*](https://docs.openstack.org/mitaka/user-guide/cli_cheat_sheet.html#networking-neutron)
```shell
# Create network
$ neutron net-create NAME

# Create a subnet
$ neutron subnet-create NETWORK_NAME CIDR
$ neutron subnet-create my-network 10.0.0.0/29
```


#### Block Storage (cinder)[*](https://docs.openstack.org/mitaka/user-guide/cli_cheat_sheet.html#block-storage-cinder)
```shell
# Create a new volume
$ cinder create SIZE_IN_GB --display-name NAME
$ cinder create 1 --display-name MyFirstVolume

# Boot an instance and attach to volume
$ nova boot --image cirros-qcow2 --flavor m1.tiny MyVolumeInstance

# List volumes, notice status of volume
$ cinder list

# Attach volume to instance after instance is active, and volume is available
$ nova volume-attach INSTANCE_ID VOLUME_ID auto
$ nova volume-attach MyVolumeInstance 573e024d-5235-49ce-8332-be1576d323f8 auto
```


#### Object Storage (swift)[*](https://docs.openstack.org/mitaka/user-guide/cli_cheat_sheet.html#object-storage-swift)
```shell
# Display information for the account, container, or object
$ swift stat
$ swift stat ACCOUNT
$ swift stat CONTAINER
$ swift stat OBJECT

# List containers
$ swift list
```
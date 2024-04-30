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
OS_PASSWORD=sifre123 openstack \
    --os-auth-url http://openstack-vto.ulakhaberlesme.com.tr \
    --os-username cemtopkaya  \
    hypervisor list
```

```shell
clear
export OS_USERNAME=cemtopkaya
export OS_PASSWORD=sifre123
export OS_AUTH_URL=http://openstack-vto.ulakhaberlesme.com.tr
#export OS_AUTH_URL=http://openstack-sto.ulakhaberlesme.com.tr
export OS_PROJECT_NAME=Development
```


#### Nova'nın Versiyonunu Çekme
```shell
nova version-list
```

```shell
root@187e8c30b8a3:/workspace/ornekler/vm-create/xTO# nova version-list
nova CLI is deprecated and will be removed in a future release
Client supported API versions:
Minimum version 2.1
Maximum version 2.96

Server supported API versions:
+------+-----------+----------------------+-------------+---------+
| Id   | Status    | Updated              | Min Version | Version |
+------+-----------+----------------------+-------------+---------+
| v2.0 | SUPPORTED | 2011-01-21T11:33:21Z |             |         |
| v2.1 | CURRENT   | 2013-07-23T11:33:21Z | 2.1         | 2.42    |
+------+-----------+----------------------+-------------+---------+
```

#### VM Oluşturma
```shell
# --flavor 2C_4R_20D \
openstack server create \
    --image Ubuntu22_04 \
    --flavor 1C_1R_1D \
    --network cinar-mgmt \
    --availability-zone=compute1 \
    --debug \
    arinc
```

```shell
# --flavor 2C_4R_20D \
openstack server create \
    --image Ubuntu-22-04-LTS \
    --flavor 2C-4R-50D \
    --network STO-Mgmt \
    --availability-zone=cnr207 \
    --debug \
    arinc
```

#### openstack hypervisor list

```shell
openstack hypervisor list
```

```shell
root@187e8c30b8a3:/workspace# openstack hypervisor list
+----+---------------------+-----------------+----------------+-------+
| ID | Hypervisor Hostname | Hypervisor Type | Host IP        | State |
+----+---------------------+-----------------+----------------+-------+
|  1 | compute2            | QEMU            | 192.168.11.104 | up    |
|  2 | compute3            | QEMU            | 192.168.11.103 | up    |
|  3 | compute1            | QEMU            | 192.168.11.100 | up    |
|  6 | compute109          | QEMU            | 192.168.11.109 | up    |
|  7 | compute111          | QEMU            | 192.168.11.111 | up    |
|  9 | compute108          | QEMU            | 192.168.11.108 | up    |
| 10 | compute106          | QEMU            | 192.168.11.106 | up    |
| 11 | compute105          | QEMU            | 192.168.11.105 | up    |
| 12 | compute107          | QEMU            | 192.168.11.107 | up    |
| 13 | compute110          | QEMU            | 192.168.11.110 | up    |
| 15 | com114              | QEMU            | 192.168.11.114 | up    |
| 16 | com115              | QEMU            | 192.168.11.115 | up    |
+----+---------------------+-----------------+----------------+-------+
```

#### Flavor Listesini Çek

```shell
openstack flavor list
```

```shell
root@187e8c30b8a3:/workspace# openstack flavor list
+--------------------------------------+------------------------------+--------+------+-----------+-------+-----------+
| ID                                   | Name                         |    RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+------------------------------+--------+------+-----------+-------+-----------+
| 003348c5-47d2-4573-96a9-1a898f75eb12 | MC                           |   4096 |   50 |         0 |     2 | True      |
| 01b3f3eb-d3c6-4f4e-87ec-08494882d14f | pcf-vm-flv                   |   4096 |   20 |         0 |     2 | True      |
| 049ad119-1bdd-479e-b131-590d4c248724 | cicd_flavor                  |  16384 |  100 |         0 |     4 | True      |
| 0bbc192c-176c-4f21-a0d0-db130f33932b | 4vCPU_4RAM_7GB               |   4096 |    7 |         0 |     4 | True      |
| 0d760bb8-e698-4db6-8ccb-3362f9a79a00 | MC_small                     |   2048 |   50 |         0 |     1 | True      |
| 0e66e8a1-b370-4e14-9d04-1f67ee3d056f | 8vCPU100GbRAM50Disk          | 102400 |   50 |         0 |     8 | True      |
| 0f57ce8a-dca2-49ec-8c2f-25c8be8cfe50 | 24C-24R-1024D                |  24576 | 1024 |         0 |    24 | True      |
| 11b81af8-3b55-4497-ac00-79867ffd15d5 | m1.medium                    |   4096 |   40 |         0 |     2 | True      |
| 121bc44a-63f7-481e-a94c-3ec50b17f36b | 2C_4R_50D                    |   4096 |   50 |         0 |     2 | True      |
| 1575cd77-ec64-472a-bef9-f2de2ec04361 | mslice1_upf_vnfd-VM-flv-1    |  24576 |   10 |         0 |    16 | True      |
```
#### Projedeki Tüm VM'lerin Listesini Çek
```shell
nova list --all-tenants
```

#### hypervisor-stats
```shell
nova hypervisor-stats
```

Çıktısı:
```shell
root@187e8c30b8a3:/workspace# nova hypervisor-stats
nova CLI is deprecated and will be removed in a future release
+----------------------+---------+
| Property             | Value   |
+----------------------+---------+
| count                | 12      |
| current_workload     | 0       |
| disk_available_least | 160941  |
| free_disk_gb         | 377460  |
| free_ram_mb          | 1239782 |
| local_gb             | 388859  |
| local_gb_used        | 227697  |
| memory_mb            | 3046118 |
| memory_mb_used       | 857904  |
| running_vms          | 68      |
| vcpus                | 368     |
| vcpus_used           | 617     |
+----------------------+---------+
```

#### "nova usage-list" ile Compute Node'ların Kullanımlarını Göster

```shell
root@187e8c30b8a3:/workspace# nova usage-list
nova CLI is deprecated and will be removed in a future release
Usage from 2024-04-01 to 2024-04-30:
+----------------------------------+---------+---------------+-----------+----------------+
| Tenant ID                        | Servers | RAM MiB-Hours | CPU Hours | Disk GiB-Hours |
+----------------------------------+---------+---------------+-----------+----------------+
| caf3d7f388d14f44962071af1e3c8703 | 48      | 528500299.33  | 266121.06 | 3225709.83     |
| 1d0cd3a792ba46ea9adc9777d3b0f882 | 4       | 33031259.54   | 20160.68  | 221767.49      |
| 21289e0a537443aaacd1ccc523c33daa | 1       | 5505209.92    | 5376.18   | 134404.54      |
| ca8a699d778d4eafba71e5b541482c80 | 3       | 33031268.71   | 16128.55  | 100803.43      |
| 124c68f12e974d5481849e15fbddaff3 | 17      | 182178489.05  | 115835.25 | 540777.96      |
| 8da761895bee4e8e882a235497eb9f3e | 4       | 38536476.67   | 34945.19  | 4196110.50     |
| 503583b14faf4f62bdd2daec239763d0 | 1       | 2752604.96    | 2688.09   | 33601.13       |
| c8731d692d914678af987ce4cb9eef27 | 2       | 22020843.81   | 5376.18   | 134404.56      |
| 15a6a542069c410184ba8d471d0a1fb3 | 22      | 714300987.48  | 198246.70 | 3306351.66     |
| ff877c97a3f947a8996b8891d38f3fe1 | 15      | 163963269.34  | 58204.11  | 1237568.80     |
| 5404f2392cee45e7a684348c371cf6db | 122     | 61425765.96   | 29993.05  | 158139.99      |
+----------------------------------+---------+---------------+-----------+----------------+
```


```shell
openstack --os-auth-url http://openstack-vto.ulakhaberlesme.com.tr \
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
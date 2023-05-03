# Ağ Listesini Çekmek (`http://vipcontroller:9696/v2.0/networks`)

1. Keystone kullanıcı hizmetinden TOKEN bilgisini çek.
2. Ağ listesi için neutron'a istek yap

Önce token çekelim:
```shell
curl --request POST \
  --url http://vipcontroller:35357/v3/auth/tokens \
  --header 'Content-Type: application/json' \
  --data '{
    "auth": {
        "identity": {
            "methods": [
                "password"
            ],
            "password": {
                "user": {
                    "name": "cemtopkaya",
                    "domain": {
                        "name": "Default"
                    },
                    "password": "sifre123"
                }
            }
        }
    }
}
'
```
Dönen mesajın HEADER bilgsindeki `X-Subject-Token` anahtarının değerini kopyalayıp (`gAAAAABkQvzG7gaMo5-...` gibi bir şey), ağ listesini çekmek için NEUTRON hizmetine istek yapalım:

```shell
curl --request GET \
  --url http://vipcontroller:9696/v2.0/networks \
  --header 'X-Auth-Token: gAAAAABkQvzG7gaMo5-....'
```

![image](https://user-images.githubusercontent.com/261946/233736957-e5b48b94-7b53-4289-bf04-61289452d4e7.png)

#### Kaynak
- https://wiki.openstack.org/wiki/Neutron/APIv2-specification#List_Networks
- https://docs.openstack.org/ocata/user-guide/sdk-neutron-apis.html
- https://docs.openstack.org/api-ref/network/v2/index.html
- https://www.ibm.com/docs/el/powervc/1.4.4?topic=apis-supported-openstack-networks-neutron

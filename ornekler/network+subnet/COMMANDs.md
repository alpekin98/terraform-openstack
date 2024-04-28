### Ağ + Alt Ağları Çek ve Yaz

```shell
clear
#!/bin/bash

# curl komutunu çalıştır ve sadece başlıkları al
headers=$(curl --silent -v --request POST \
  --url http://controller:35357/v3/auth/tokens \
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
                    "password": "*****"
                }
            }
        }
    }
}' 2>&1 | grep 'X-Subject-Token')

# Token değerini al
token=$(echo "$headers" | awk '{print $3}')

curl -L -s -H "X-Auth-Token: $token" http://192.168.11.102:9696/v2.0/networks?status=ACTIVE | jq
```

```shell
clear
export TF_LOG=DEBUG
terraform apply -auto-approve
```
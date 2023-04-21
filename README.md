### Keystone Servisi için TOKEN Almak
Önce keystone adresini bulalım (`http://vipcontroller:35357/v3/auth/tokens`) ve kullanıcı için token isteği gönderelim:
![image](https://user-images.githubusercontent.com/261946/233709607-c699d9ed-56e8-48bf-9034-a0a2c6b42dba.png)


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
                    "name": "kullanici-adi",
                    "domain": {
                        "name": "Default"
                    },
                    "password": "kullanici-sifresi"
                }
            }
        }
    }
}
'
```

Özetle yukarıdaki isteğin JSON ile POST metodu içerdiği ve aşağıdaki JSON nesnesini gövdesinde barındırdığını söyleyebiliriz:
```json
{
    "auth": {
        "identity": {
            "methods": [
                "password"
            ],
            "password": {
                "user": {
                    "name": "your-username",
                    "domain": {
                        "name": "Default"
                    },
                    "password": "your-password"
                }
            }
        }
    }
}
```

Cevabın HEADERS kısmında `X-Subject-Token`anahtarında TOKEN bilgisini göreceğiz:

![image](https://user-images.githubusercontent.com/261946/233710914-3a879216-2f32-45ca-94b3-72117bcd749d.png)


---

### Nova Hizmeti için TOKEN Almak
Önce NOVA hizmetinin adresini bulalım (`http://vipcontroller:5000/v3/auth/tokens`) ve curl ile http isteği atarak TOKEN bilgimizi alalım:

![image](https://user-images.githubusercontent.com/261946/233720396-e279aeca-a764-4941-9f46-2ec4f6027944.png)

![image](https://user-images.githubusercontent.com/261946/233718109-2c7fe7b6-27ad-4f93-a6e8-684d11f63f51.png)

---

### COMPUTE Hizmetinden Sunucu Listesini Çekmek

TOKEN bilgisini NOVA'dan aldıktan sonra `http://vipcontroller:8774/v2.1/servers` adresinden aşağıdaki istekle sunucu listesini çekebiliriz:

```shell
curl --request GET \
  --url http://vipcontroller:8774/v2.1/servers \
  --header 'X-Auth-Token: gAAAAABkQueeOLDPn2.....'
```

![image](https://user-images.githubusercontent.com/261946/233722622-8da87f60-e19b-46fe-b609-53c64c517548.png)

#### Sunucu Listesini Ayrıntılı Çekmek

Sunucu listelerini çektiğimiz adres (`http://vipcontroller:8774/v2.1/servers`) küçük bir farkla (`/detail`) şu şekilde gelecektir:

![image](https://user-images.githubusercontent.com/261946/233725139-bd13f109-75c1-439d-837b-34c71a0e10b5.png)


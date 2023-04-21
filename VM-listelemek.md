# COMPUTE Hizmetinden Sunucu Listesini Çekmek

TOKEN bilgisini NOVA'dan aldıktan sonra `http://vipcontroller:8774/v2.1/servers` adresinden aşağıdaki istekle sunucu listesini çekebiliriz:

```shell
curl --request GET \
  --url http://vipcontroller:8774/v2.1/servers \
  --header 'X-Auth-Token: gAAAAABkQueeOLDPn2.....'
```

![image](https://user-images.githubusercontent.com/261946/233722622-8da87f60-e19b-46fe-b609-53c64c517548.png)

## Sunucu Listesini Ayrıntılı Çekmek

Sunucu listelerini çektiğimiz adres (`http://vipcontroller:8774/v2.1/servers`) küçük bir farkla (`/detail`) şu şekilde gelecektir:

![image](https://user-images.githubusercontent.com/261946/233725139-bd13f109-75c1-439d-837b-34c71a0e10b5.png)



### COMPUTE Hizmeti Üstünden Sunucu Silmek ([*](https://docs.openstack.org/api-ref/compute/?expanded=list-servers-detail,list-servers-detailed-detail,delete-server-detail#delete-server))

Çalışan sunucuyu web arayüzünde görüntüleyebiliyoruz:

![image](https://user-images.githubusercontent.com/261946/233725830-f0a64b64-66a7-443b-9c6f-eab79193ef72.png)

Silme komutunu gönderiyoruz:

```shell
curl --request DELETE \
  --url http://vipcontroller:8774/v2.1/servers/9ffb3c7a-8965-40ee-9ef6-7fad062692c3 \
  --header 'X-Auth-Token: gAAAAABkQueeOLDPn2-lrsFUr_TPfFeSFvK1K6K2JGtnc8hKelGIJEjsSBXq3ABGAdfH9M2lB9ywP__FgpXv4d06SNK8oW1wkm-NE9vRd6Klz29B3ph-PhS1V5VkVsZ2i6v7Sof8YyzdrqwpdJ1dtzcf-wl6cjz55DFE8OeDu5XxnG8BaUwiTuA'
```

![image](https://user-images.githubusercontent.com/261946/233726213-8e40f218-17d5-4b70-a31b-0bc9481ff95f.png)

Silme işleminin başladığını web arayüzünde görebiliyoruz:

![image](https://user-images.githubusercontent.com/261946/233726191-7a495cea-3424-497e-81ad-b99755ed177d.png)

Ve artık VM silindi:

![image](https://user-images.githubusercontent.com/261946/233726307-916d8f40-886f-4a5b-ad92-2e0a884d859b.png)

#### Kaynak
- https://docs.openstack.org/ocata/user-guide/cli-delete-an-instance.html

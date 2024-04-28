### Terraform Nedir?
Terraform, altyapı yönetimi için bir yazılım aracıdır. HashiCorp tarafından geliştirilen açık kaynaklı bir araç olan Terraform, "altyapıyı kodla" yaklaşımını benimser. Bu yaklaşım, altyapı kaynaklarını kod olarak tanımlamanıza ve bu kodu kullanarak altyapıyı oluşturmanıza, değiştirmenize ve yönetmenize olanak tanır.

Terraform, bulut sağlayıcıları (AWS, Azure, Google Cloud Platform gibi) ve diğer altyapı sağlayıcıları için kaynakları yönetmek için kullanılabilir. Kullanıcılar, Terraform'un açık ve basit tanım dilini kullanarak altyapı kaynaklarını tanımlarlar. Bu tanımlar, modüller, değişkenler, kaynaklar ve sağlayıcılar gibi yapıları içerebilir.

Terraform, bir "planlama" adımını içerir, bu adımda Terraform, belirtilen altyapıyı oluşturmak veya değiştirmek için gereken adımları belirler. Daha sonra, bu plan onaylandığında, Terraform altyapıyı gerçek dünyada uygular veya günceller. Bu, altyapı değişikliklerini tutarlı, tekrarlanabilir ve denetlenebilir bir şekilde yönetmeyi sağlar.

Sonuç olarak, Terraform, altyapıyı kodla tanımlama, yönetme ve otomatikleştirme süreçlerini kolaylaştıran güçlü bir araçtır.


Terraform ile bir işi sırayla gerçekleştirmek için genellikle aşağıdaki komutlar kullanılır:

1.  **terraform init**: Terraform projesini başlatmak için kullanılır. Bu komut, proje için kullanılan sağlayıcıları (providers) ve modülleri indirir ve yapılandırır.
    
2.  **terraform plan**: Altyapıda yapılacak değişiklikleri görüntüler. Terraform, belirtilen konfigürasyon dosyalarını analiz eder ve planlanan işlemleri belirler, ancak henüz değişiklik yapmaz.
    
3.  **terraform apply**: Terraform planında belirlenen değişiklikleri uygular. Bu komut, belirtilen konfigürasyon dosyalarında tanımlanan kaynakları oluşturur, günceller veya siler.
    
4.  **terraform destroy**: Altyapıdaki tüm kaynakları siler. Bu komut, belirtilen konfigürasyon dosyalarındaki tüm kaynakları kaldırır.
    

Bunlar genel olarak Terraform ile yapılan işlerin temel adımlarıdır. Ancak proje gereksinimlerinize göre, daha karmaşık senaryolarda farklı komutlar ve iş akışları da kullanılabilir.

### Terraform (CLI) Komut Satırı Arayüzünü Otomatik Tamamlama (auto complete) İle Kullanmak

`terraform -install-autocomplete` veya `~/.bashrc` dosyasının sonuna `complete -C /usr/local/bin/terraform terraform` satırını ekleyip ardından aktif terminalinizde `source ~/.bashrc` komutunu çalıştırabilirsiniz. 

### workspace
Terraform'da workspace komutu, proje içindeki farklı ortamları (örneğin, development, staging, production) izole etmek için kullanılır. Bu komut, aynı altyapı kaynaklarını farklı çalışma ortamlarında yönetmek için farklı çalışma alanları oluşturmanıza olanak tanır. Böylece, farklı ortamlar için ayrı ayarlar ve değişiklikler yapabilirsiniz, ancak kaynaklar aynı altyapıda kalır. Bu, geliştirme, test ve üretim gibi farklı ortamlarda güvenli bir şekilde çalışma ve değişiklik yapma süreçlerini kolaylaştırır.

### Terraform Sürüm Kontrolü 
Aşağıdaki Terraform version komutunu çalıştırarak Terraform kurulumunuzu doğrulayabilirsiniz :

```shell
$ terraform -version
Terraform v1.1.0
on linux_amd64
+ provider registry.terraform.io/hashicorp/aws v3.69.0
```

### Terraform Hata Ayıklama

### Terraform GÜNLÜKLERİ
Hata ayıklama ve sorun giderme için Terraform tarafından sağlanan belirli [günlük seviyeleri](https://www.terraform.io/internals/debugging "günlük seviyeleri") vardır . Geliştiriciler olarak Terraform projemiz için log seviyesini seçip ayarlamamız gerekiyor.

### Günlük Seviyesi Türleri

Toplamda hata ayıklama amacıyla kullanılabilecek 5 günlük düzeyi vardır:

*  _TRACE_ — en açıklayıcı günlük düzeylerinden biridir; günlük düzeyini TRACE_ olarak ayarlarsanız Terraform her eylemi ve adımı günlük dosyasına yazacaktır.

*  _DEBUG_ — geliştiriciler tarafından hata ayıklama süresini azaltmak için kritik veya daha karmaşık kod parçalarında kullanılan, biraz daha karmaşık bir günlük kaydıdır.

*  _INFO_ — bilgi günlüğü düzeyi, bazı bilgilendirici talimatların veya benioku tipi talimatların günlüğe kaydedilmesi gerektiğinde kullanışlıdır.**
* _WARNING_ — bir şeyin kritik olmadığı ancak geliştiricinin daha sonra ayarlamalar yapabilmesi için bir günlük biçiminde eklenmesinin iyi olacağı durumlarda kullanılır.

*  _ERROR_ — adından da anlaşılacağı gibi, bir şeyler çok yanlışsa ve engelleyici ise bu kullanılır.

### Hata ayıklamayı etkinleştirmek için günlük düzeyi nasıl ayarlanır?

Günlük düzeyi, TF\_LOG ortam değişkeni ile ayarlanabilir _._ Değişkeni doğru günlük düzeyiyle dışa aktarmanız gerekir. _TF\_LOG'un_ _DEBUG_ düzeyiyle ayarlandığı yere bir örnek :

```shell
$ export TF_LOG=”DEBUG”
```

#### TF_LOG_PATH kullanarak günlük dosyasını ayarlayın
Log seviyesini ayarladıktan sonra ayarlamamız gereken bir sonraki şey _Log Dosya Yoludur ve bunun için_ _TF\_LOG\_PATH_ ortam değişkenini kullanacağız .

_Bu blog yazısı için terraform-debug.log_ adında bir günlük dosyası oluşturacağız .

_Bu dosyayı /home/vagrant/terraform-ec2-aws_ dizini altına yerleştireceğiz .

_\*Not – Günlük dosyası yolunu ihtiyacınıza göre adlandırabilir ve seçebilirsiniz._

_TF\_LOG\_PATH_ dosyasını dışarı aktaralım

```shell
export TF_LOG_PATH="/home/vagrant/terraform-ec2-aws/terraform-debug.log"
```


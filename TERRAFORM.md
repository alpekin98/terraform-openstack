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
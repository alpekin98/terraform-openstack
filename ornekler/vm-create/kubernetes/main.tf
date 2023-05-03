locals {
  metadata_default = { "managed-by-terraform" = true }
  tags_default = [ "managed-by-terraform=true" ]
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.51.0"
    }
  }
}

# Provider tanımlaması
provider "openstack" {
  # OpenStack credential ayrıntıları

  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-api-erisimi.md
  auth_url = "http://controller:5000/v3/"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-api-erisimi.md#kullan%C4%B1c%C4%B1-bilgileri
  user_name = "cemtopkaya"
  password = "q1w2e3r4"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-tennant.md
  tenant_name = "osmtest"
  # https://github.com/cemtopkaya/terraform-openstack/blob/main/OpenStack-region.md
  region = "RegionOne"
}

variable "packages" {
  description = "List of packages to install"
  type        = list(string)
  default     = ["apt-transport-https","curl","ca-certificates","software-properties-common","docker.io", "kubelet=1.23.17", "kubeadm=1.23.17", "kubectl"]
}

# https://training.galaxyproject.org/training-material/topics/admin/tutorials/terraform/tutorial.html#adding-an-instance
# http://man.hubwiz.com/docset/Terraform.docset/Contents/Resources/Documents/docs/providers/openstack/r/compute_instance_v2.html
resource "openstack_compute_instance_v2" "master_instance" {
  name = "k8s_master"
  image_name = "xenial"
  # image_name = "ubuntu"
  flavor_name = "2CPU4RAM10GB"
  # flavor_name = "12cpu8ram100gb_Huge"
  key_pair = "cemtopkaya_ssh_keys"
  security_groups = ["default"]
  availability_zone = "com110"
  metadata          = merge(local.metadata_default, var.metadata)
  tags              = concat(local.tags_default, var.tags)
  
  network {
    name = "cinar-control"
    # name = "STO-control"
  }

  network {
    # name = "STO-public"
    name = "cinar-public"
  }

  network {
    # name = "STO-mgmt"
    name = "cinar-mgmt"
  }

  network {
    # name = "STO-data"
    name = "cinar-data"
  }

  # Kullanıcı yaratma ve apt update / ortak paketlerin kurulumu için modülü çağırın.
  # module "common_instance_config" {
  #   source = "./modules/ortak"
  # }
/*
Ana Düğüm (Master) Paketleri:
  kubelet: Ana düğüm (master) üzerinde çalışan tüm pod'ların oluşturulması ve yönetimi için gereklidir.
  kubeadm: Kubernetes cluster'ının oluşturulması için gereklidir. Ana düğümü (master) oluşturmak için kullanılır.
  kubectl: Kubernetes cluster'ını yönetmek için gereklidir. Komut satırından pod'lar oluşturmak, pod'ları silmek, güncellemek, vb. işlemleri gerçekleştirmek için kullanılır.

Worker Düğüm (Node) Paketleri:
  kubelet: Worker düğümleri (node) üzerinde çalışan tüm pod'ların oluşturulması ve yönetimi için gereklidir.
  kubectl: Worker düğümlerinde (node) çalıştırılan pod'lar üzerinde işlem yapmak için gereklidir. Ancak, bu paket genellikle worker düğümlerinde yüklü değildir. Yalnızca, kubectl komutunu çalıştırmak için kullanılacak bir araç olarak düşünülebilir.
*/

  # user_data = templatefile("./templates/user_data.sh.tpl", {
  #   username        = "ubuntu"
  #   password        = "test123"
  #   packages        = var.packages
  #   master          = true
  # })

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              apt-get install -y apt-transport-https curl ca-certificates software-properties-common

              # docker kur
              apt-get install -y docker.io
              systemctl enable docker
              systemctl start docker

              # K8s reposunu ekle
              curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
              echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
              apt-get update

              # Kubernetes ana düğümün kurulumu için kubeadm, kubelet ve kubectl bileşenleri gereklidir. 
              apt-get install -y kubelet=1.23.17 kubeadm=1.23.17 kubectl
              apt-mark hold kubelet kubeadm kubectl
              systemctl enable kubelet.service
              systemctl start kubelet.service

              # Swap kapatma: Kubernetes cluster'i çaliştirmak için swap'in devre dişi birakilmasi gerekmektedir. Swap RAM yetmediğinde hafızayı kullanır. Yavaştır ve önerilmez.
              swapoff -a
              sed -i '/ swap / s/^/#/' /etc/fstab

              # Hostname ayarlamak: Her bir düğümün benzersiz bir hostname'a sahip olmasi gerekmektedir. 
              hostnamectl set-hostname k8s_master

              # Firewall ayarlamak: Kubernetes cluster'i için gerekli olan portlar açik olmalidir. 
              # SSH portu (22), Kubernetes API portu (6443), etcd portlari (2379-2380)
              ufw allow ssh
              ufw allow 6443/tcp
              ufw allow 2379:2380/tcp
              ufw allow 10250/tcp
              ufw allow 10251/tcp
              ufw allow 10252/tcp
              ufw allow 10255/tcp
              ufw enable

              # Kubernetes cluster'ini kurmak için öncelikle bir ana düğüm (master) oluşturmaniz gereklidir. Ana düğümü oluşturmak için 
              kubeadm init --pod-network-cidr=10.244.0.0/16

              mkdir -p $HOME/.kube
              cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
              chown $(id -u):$(id -g) $HOME/.kube/config

              # Pod network kurulumu: 
              # Kubernetes cluster'inizi oluşturduktan sonra, pod network'ünü kurmaniz gereklidir. 
              # Pod network, cluster içerisindeki container'larin birbirleriyle iletişim kurmasini sağlar. 
              # Flannel pod network'ünü kuran yaml dosyasını indirmek için :
              wget https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
              
              # CNI kurmak için 
              kubectl apply -f kube-flannel.yml

              useradd -m -s /bin/bash ubuntu
              echo "ubuntu:test123" | chpasswd
              echo "root:test123" | chpasswd
              EOF
}

resource "openstack_compute_instance_v2" "slave1_instance" {
  name = "k8s_slave1"
  image_name = "xenial"
  # image_name = "ubuntu"
  flavor_name = "4vcpu10gbram80GBdisk"
  # flavor_name = "12cpu8ram100gb_Huge"
  key_pair = "cemtopkaya_ssh_keys"
  security_groups = ["default"]
  availability_zone = "com110"

  # network {
  #   name = "public"
  # }

  network {
    name = "cinar-control"
    # name = "STO-control"
  }

  network {
    # name = "STO-public"
    name = "cinar-public"
  }

  network {
    # name = "STO-mgmt"
    name = "cinar-mgmt"
  }

  network {
    # name = "STO-data"
    name = "cinar-data"
  }


  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              apt-get install -y apt-transport-https curl ca-certificates software-properties-common

              # docker kur
              apt-get install -y docker.io
              systemctl enable docker
              systemctl start docker

              # K8s reposunu ekle
              curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
              echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
              apt-get update

              # Kubernetes'in workder düğüm için kubelet ve kubectl bileşenleri gereklidir. 
              apt-get install -y kubelet=1.23.17 kubectl
              apt-mark hold kubelet kubectl
              systemctl enable kubelet.service
              systemctl start kubelet.service

              # Swap kapatma: Kubernetes cluster'i çaliştirmak için swap'in devre dişi birakilmasi gerekmektedir.
              swapoff -a
              sed -i '/ swap / s/^/#/' /etc/fstab

              # Hostname ayarlamak: Her bir düğümün benzersiz bir hostname'a sahip olmasi gerekmektedir. 
              hostnamectl set-hostname k8s_slave1

              # Firewall ayarlamak: Kubernetes cluster'i için gerekli olan portlar açik olmalidir. 
              # SSH portu (22), Kubernetes API portu (6443), etcd portlari (2379-2380)
              ufw allow ssh
              ufw allow 6443/tcp
              ufw allow 2379:2380/tcp
              ufw allow 10250/tcp
              ufw allow 10251/tcp
              ufw allow 10252/tcp
              ufw allow 10255/tcp
              ufw enable

              # Kubernetes cluster'ini kurmak için öncelikle bir ana düğüm (master) oluşturmaniz gereklidir. Ana düğümü oluşturmak için 
              kubeadm init --pod-network-cidr=10.244.0.0/16

              mkdir -p $HOME/.kube
              cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
              chown $(id -u):$(id -g) $HOME/.kube/config



              # Pod network kurulumu: 
              # Kubernetes cluster'inizi oluşturduktan sonra, pod network'ünü kurmaniz gereklidir. 
              # Pod network, cluster içerisindeki container'larin birbirleriyle iletişim kurmasini sağlar. 
              # Flannel pod network'ünün yaml dosyası  :
              wget  https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

              flannel yaml dosyasının aplly etmek için 
              kubectl apply -f kube-flannel.yml

              useradd -m -s /bin/bash ubuntu
              echo "ubuntu:test123" | chpasswd
              echo "root:test123" | chpasswd
              EOF
}
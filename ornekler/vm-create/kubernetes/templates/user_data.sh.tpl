#!/bin/bash
set -e

# Create user
useradd -m -p "$(openssl passwd -1 ${password})" ${username}

# ----------------------------

# Apply security updates
apt-get update && apt-get upgrade -y

apt-get install -y curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update

# Kurulum yapılacak paketler
PACKAGES="${packages}"

# Paketlerin kurulumunu yap
apt-get install -y $PACKAGES


# docker kur
apt-get install -y docker.io
systemctl enable docker
systemctl start docker

# Set hostname
hostnamectl set-hostname "${name}"

# Swap kapatma: Kubernetes cluster'i çaliştirmak için swap'in devre dişi birakilmasi gerekmektedir.
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
kubeadm init --pod-network-cidr=${var.k8s.pod-network}

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Pod network kurulumu: 
# Kubernetes cluster'inizi oluşturduktan sonra, pod network'ünü kurmaniz gereklidir. 
# Pod network, cluster içerisindeki container'larin birbirleriyle iletişim kurmasini sağlar. 
# Flannel pod network'ünü kurmak için :
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

useradd -m -s /bin/bash ubuntu
echo "ubuntu:test123" | chpasswd
echo "root:test123" | chpasswd
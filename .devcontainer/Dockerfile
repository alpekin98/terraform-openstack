# Docker image for terraform-openstack project
# Pull base image.
FROM ubuntu:jammy

RUN apt-get update

# bash-completion Paketi CLI araçları otomatik tamamlasın diye gerekli
RUN apt install -y unzip wget vim tree curl jq bash-completion

################################
# Install Terraform
################################

# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip

RUN unzip terraform_1.6.6_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform --version

################################
# Install python
################################

RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN python3 -V
RUN pip --version
RUN python3 -m pip install requests
RUN apt-get install -y git inetutils-ping

CMD tail -f /dev/null
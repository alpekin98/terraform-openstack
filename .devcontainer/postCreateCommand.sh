#!/bin/bash

pip install -r .devcontainer/requirements.txt 
echo complete -C /usr/local/bin/terraform terraform >> ~/.bashrc 

# -------------- Opensctack CLI Auto Complete ----------------
# https://docs.openstack.org/python-openstackclient/pike/cli/command-objects/complete.html
# Opensctack CLI aracının bash completion özelliğini aktif etmek için aşağıdaki komutu çalıştırın.
openstack complete | tee /etc/bash_completion.d/osc.bash_completion > /dev/null
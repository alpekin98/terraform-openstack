#!/bin/bash

pip install -r .devcontainer/requirements.txt 
echo complete -C /usr/local/bin/terraform terraform >> ~/.bashrc 
openstack complete | tee /etc/bash_completion.d/osc.bash_completion > /dev/null
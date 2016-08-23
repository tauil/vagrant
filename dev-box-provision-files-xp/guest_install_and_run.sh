#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

if [[ ! -x /usr/bin/ansible ]]; then
    echo 'Installing ansible...'
    apt-get install -y ansible
    echo '[local]' > /etc/ansible/hosts
    echo 'localhost' >> /etc/ansible/hosts
    echo 'Ansible installed.'
else
    echo 'Ansible already installed.'
fi

ansible-galaxy install AerisCloud.rvm

if [[ ! -d /projects ]]; then
    mkdir /projects
fi

cd /projects

echo  'Running playbook...'
ansible-playbook dev-box-provision-files-xp/playbook.yml
echo 'Playbook finished.'

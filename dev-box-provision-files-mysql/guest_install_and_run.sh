#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

if [[ ! -x /usr/bin/ansible ]]; then
  echo 'Installing ansible...'
  apt-add-repository -y ppa:rquillo/ansible
  apt-get update
  apt-get install -y ansible
  echo '[local]' > /etc/ansible/hosts
  echo 'localhost' >> /etc/ansible/hosts
  echo 'Ansible installed.'
else
  echo 'Ansible already installed.'
fi

echo 'Running playbook...'
cd /projects
ansible-playbook dev-box-provision-files-mysql/playbook.yml
echo 'Playbook finished.'

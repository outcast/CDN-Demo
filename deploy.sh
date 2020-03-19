#!/usr/bin/env bash

#Deploy Origin Server
pushd ./terraform
make plan
make apply
popd
ansible-playbook -e "ansible_user=root" -i ./configs/ansible/mirror-origin.conf ./playbooks/mirror-origin.playbook

#!/usr/bin/env bash

#Deploy Origin Server
pushd ./terraform
make plan
make apply
popd
ansible-playbook -e "ansible_user=root" -i ./configs/ansible/nodes.conf ./playbooks/mirror-origin.playbook
ansible-playbook -e "ansible_user=root" -i ./configs/ansible/nodes.conf ./playbooks/cache-node.playbook

#!/usr/bin/env bash

#Deploy Origin Server
pushd ./terraform
make plan
make apply
popd
sleep 10
ansible-playbook -e "ansible_user=root" -i ./configs/ansible/nodes.conf ./playbooks/deploy.playbook

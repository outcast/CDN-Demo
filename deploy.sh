#!/usr/bin/env bash

#Deploy Origin Server
pushd ./mirror-origin
make plan
make apply
popd
ansible-playbook -e "ansible_user=root" -i ./configs/mirror-origin.conf ./playbooks/mirror-origin.playbook
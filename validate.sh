#!/usr/bin/env bash

#validate

ansible origin -e "ansible_user=root" -i ./configs/ansible/nodes.conf -m uri -a "url=http://localhost/ubuntu/" || echo Origin failed validation: $?
ansible cache -e "ansible_user=root" -i ./configs/ansible/nodes.conf -m uri -a "url=http://localhost/ubuntu/" || echo One or more caches failed validation: $?
ansible lb -e "ansible_user=root" -i ./configs/ansible/nodes.conf -m uri -a "url=http://localhost/ubuntu/" || echo One or more load balancers failed validation: $?

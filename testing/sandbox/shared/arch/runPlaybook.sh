#!/usr/bin/env bash
cd /vagrant/ansible || return
if [[ "$(pwd)" =~ "/vagrant/ansible" ]]; then
  ansible-playbook -i hosts.yml playbook.yml
fi
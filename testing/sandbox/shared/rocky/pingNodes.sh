#!/usr/bin/env bash
cd /vagrant/ansible || return;
if [[ "$(pwd)" =~ "/vagrant/ansible" ]]; then
  ANSIBLE_HOST_KEY_CHECKING=False ansible nodes -m ping
fi
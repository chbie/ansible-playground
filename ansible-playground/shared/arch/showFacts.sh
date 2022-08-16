#!/usr/bin/env bash
cd /vagrant/ansible || return
if [[ "$(pwd)" =~ "/vagrant/ansible" ]]; then
  touch nodes.info
  echo "$(ANSIBLE_HOST_KEY_CHECKING=False ansible nodes -m setup)" > nodes.info
  mv -f nodes.info /vagrant/nodes.info
fi
#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y build-essential libssl-dev libffi-dev apt-transport-https curl python3 python3-pip ansible

if [ ! -e "/usr/bin/ansible" ]; then
  ln -s /usr/local/bin/ansible /usr/bin/ansible;
fi

exit 0;
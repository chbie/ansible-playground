#!/usr/bin/env bash

sudo dnf -y update
sudo dnf -y install epel-release
sudo dnf -y install python3 python3-pip
sudo pip3 install --upgrade pip

python3 -m pip install --user ansible

if [ ! -e "/usr/bin/ansible" ]; then
  ln -s /usr/local/bin/ansible /usr/bin/ansible;
fi

exit 0;
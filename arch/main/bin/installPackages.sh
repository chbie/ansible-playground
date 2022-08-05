#!/usr/bin/env bash

sudo pacman -Syu
sudo pacman -S -y base-devel go python python-pip ansible curl

if [ ! -e "/usr/bin/ansible" ]; then
  ln -s /usr/local/bin/ansible /usr/bin/ansible;
fi

exit 0;
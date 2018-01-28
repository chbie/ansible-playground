#!/usr/bin/env bash

if [ ! -f "/usr/bin/ansible" ];
then
    sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev python-pip
    sudo pip install ansible --upgrade
    if [ ! -e "/usr/bin/ansible" ];
    then
        ln -s /usr/local/bin/ansible /usr/bin/ansible;
    fi
fi
exit 0

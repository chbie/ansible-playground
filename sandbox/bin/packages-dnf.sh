#!/usr/bin/env bash

sudo dnf -y update
sudo dnf -y install epel-release
sudo dnf -y install python3 python3-pip
sudo pip3 install --upgrade pip

exit 0;
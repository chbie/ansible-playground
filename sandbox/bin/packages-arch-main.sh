#!/usr/bin/env bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel
sudo pacman -S --noconfirm go python python-pip ansible
exit 0;
#!/usr/bin/env bash

CERTPATH=$(readlink -f "/home/vagrant/main.pub")

RED="\033[0;31m\033[1m!! FAILED =>\033[m"
YELLOW="\033[1;33m\033[1m:: INFO =>\033[m"
GREEN="\033[0;32m\033[1m✓✓ SUCCESS =>\033[m"

if [ -z "$CERTPATH" ]; then
  printf "$RED Could not read path to main node public key!\n"
  printf "$RED Either the key wasn't copied or has been renamed ...\n"
  exit 1;
else
  printf "$GREEN Main node public key found, continuing ...\n"
fi
# CREATING .SSH FOLDER, IF REQUIRED
if [ ! -d "/home/vagrant/.ssh" ]; then
  printf "$YELLOW Creating directory ~/.ssh ...\n"
  mkdir -p /home/vagrant/.ssh;
  chmod -r 0700 /home/vagrant/.ssh
fi
# SAME FOR ROOT
if sudo [ ! -d "/root/.ssh" ]; then
  printf "$YELLOW Creating directory /root/.ssh ...\n"
  sudo mkdir -p /root/.ssh;
  sudo chmod 0700 /root/.ssh
fi
# CREATING AUTHORIZED KEYS FILE, IF REQUIRED
if sudo [ ! -f "/root/.ssh/authorized_keys" ]; then
  printf "$YELLOW Creating authorized_keys file ...\n"
  sudo touch /root/.ssh/authorized_keys
  sudo chmod 0777 /root/.ssh/authorized_keys
fi
# ONLY COPYING HOST PUBKEY WHEN NOT ALREADY DONE - ELSE, ON EACH VAGRANT PROVISION
# THE SAME LINE WOULD BE APPENDED TO THE AUTHORIZED_KEYS FILES MANY TIMES OVER!
if ! grep -Fxq "$(<"$CERTPATH")" "/root/.ssh/authorized_keys"
then
  printf "$YELLOW Importing public key for root ...\n"
  sudo cat "$CERTPATH" | sudo tee -a /root/.ssh/authorized_keys
  sudo chmod 0644 /root/.ssh/authorized_keys
fi
if ! grep -Fxq "$(<"$CERTPATH")" "/home/vagrant/.ssh/authorized_keys"
then
  printf "$YELLOW Importing public key for vagrant user ...\n"
  sudo cat "$CERTPATH" | sudo tee -a /home/vagrant/.ssh/authorized_keys
fi

rm "$CERTPATH"

exit 0;
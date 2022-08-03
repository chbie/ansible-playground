#!/usr/bin/env bash

SCRPATH=$(readlink -f $0)   # .../node/bin/installCertificates.sh
CURDIR=$(dirname $SCRPATH)  # .../node/bin
BASDIR=$(dirname $CURDIR)   # .../node
CERTPATH=$(readlink -f $BASDIR"/certificates/id_rsa.pub")

RED="\033[0;31m\033[1m!! FAILED =>\033[m"
YELLOW="\033[1;33m\033[1m:: INFO =>\033[m"
GREEN="\033[0;32m\033[1m✓✓ SUCCESS =>\033[m"

# VALIDATING CERTPATH
if [ -z "$CERTPATH" ]; then
  printf "$RED Certificates folder moved or missing!\n"
  printf "$YELLOW Trying via synced folder ...\n"
  CERTPATH="/vagrant/certificates/id_rsa.pub"
else
  printf "$GREEN Certificates folder found, continuing ...\n"
fi

printf "$YELLOW Installing certificates in node ...\n"
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

# COPYING SSH PUBKEY TO AUTHORIZED KEYS
printf "$YELLOW Importing public key ...\n"
sudo cat "$CERTPATH" | sudo tee /root/.ssh/authorized_keys
sudo cat "$CERTPATH" | sudo tee /home/vagrant/.ssh/authorized_keys
sudo chmod 0644 /root/.ssh/authorized_keys

exit 0;
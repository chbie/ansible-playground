#!/usr/bin/env bash

SCRPATH=$(readlink -f $0)   # .../main/bin/installCertificates.sh
CURDIR=$(dirname $SCRPATH)  # .../main/bin
BASDIR=$(dirname $CURDIR)   # .../main
CERTPATH=$(readlink -f $BASDIR"/certificates/id_rsa")

RED="\033[0;31m\033[1m!! FAILED =>\033[m"
YELLOW="\033[1;33m\033[1m:: TASK =>\033[m"
GREEN="\033[0;32m\033[1m✓✓ SUCCESS =>\033[m"

# VALIDATING CERTPATH
if [ -z "$CERTPATH" ]; then
  printf "$RED Certificates folder moved or missing!\n"
  printf "$YELLOW Trying via synced folder ...\n"
  CERTPATH="/vagrant/certificates/id_rsa"
else
  printf "$GREEN Certificates folder found, continuing ...\n"
fi

printf "$YELLOW Installing certificates in main ...\n"
# CREATING .SSH FOLDER, IF REQUIRED
if [ ! -d "/home/vagrant/.ssh" ]; then
  printf "$YELLOW Creating directory ~/.ssh ...\n"
  mkdir -p /home/vagrant/.ssh;
  chmod -r 0700 /home/vagrant/.ssh
fi

# IMPORTING KEYFILE, IF REQUIRED
if [ ! -f "/home/vagrant/.ssh/id_rsa" ]; then
  printf "$YELLOW Importing key file ...\n"
  cp -f "$CERTPATH" /home/vagrant/.ssh/id_rsa;
  chown vagrant:vagrant /home/vagrant/.ssh/id_rsa;
  chmod 0600 /home/vagrant/.ssh/id_rsa;
fi
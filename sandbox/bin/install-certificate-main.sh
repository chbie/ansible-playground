#!/usr/bin/env bash

SCRPATH=$(readlink -f $0)   # .../sandbox/bin/installCertificates.sh
CURDIR=$(dirname $SCRPATH)  # .../sandbox/bin
BASDIR=$(dirname $CURDIR)   # .../sandbox
CERTPATH=$(readlink -f $BASDIR"/certificates/id_rsa")
YELLOW="\033[1;33m\033[1m:: INFO =>\033[m"

if [ -z "$CERTPATH" ]; then
  CERTPATH="/home/vagrant/keyfile"
fi

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

rm "$CERTPATH"

exit 0;
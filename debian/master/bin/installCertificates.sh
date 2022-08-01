#!/usr/bin/env bash

CURDIR=`/bin/pwd`
BASEDIR=$(dirname $0)
ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
CERTPATH=$(readlink -f $ABSDIR"/../certificates/id_rsa")

if [ -z "$CERTPATH" ]; then
    CERTPATH="/vagrant/certificates/id_rsa"
fi

# TODO: ssh_config file

echo "check the certificates in master"

if [ ! -d "/home/vagrant/.ssh" ]; then
    echo "creates .ssh to master"
    mkdir -p /home/vagrant/.ssh;
    chmod -r 0700 /home/vagrant/.ssh
fi

if [ ! -f "/home/vagrant/.ssh/id_rsa" ]; then
    echo "copy id_rsa to master"
    cp "$CERTPATH" /home/vagrant/.ssh/id_rsa;
    chown vagrant:vagrant /home/vagrant/.ssh/id_rsa;
    chmod 0600 /home/vagrant/.ssh/id_rsa;
fi
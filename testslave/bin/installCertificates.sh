#!/usr/bin/env bash

CURDIR=`/bin/pwd`
BASEDIR=$(dirname $0)
ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
CERTPATH=$(readlink -f $ABSDIR"/../certificates/id_rsa.pub")

if [ -z "$CERTPATH" ]; then
    CERTPATH="/vagrant/certificates/id_rsa.pub"
fi

echo "checks the certificates in testslave"

if [ ! -d "/home/vagrant/.ssh" ]; then
    echo "creates /home/vagrant/.ssh to testslave"
    mkdir -p "/home/vagrant/.ssh";
    chmod -r 0700 "/home/vagrant/.ssh"
fi

if sudo [ ! -d "/root/.ssh" ]; then
    echo "creates /root/.ssh to testslave"
    sudo mkdir -p "/root/.ssh";
    sudo chmod 0700 "/root/.ssh"
fi

if sudo [ ! -f "/root/.ssh/authorized_keys" ]; then
    echo "creates authorized_keys for root"
    sudo touch /root/.ssh/authorized_keys
    sudo chmod 0777 /root/.ssh/authorized_keys
    sudo cat "$CERTPATH" | sudo tee /root/.ssh/authorized_keys
    sudo chmod 0644 /root/.ssh/authorized_keys
fi

exit 0;

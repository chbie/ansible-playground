#!/usr/bin/bash
ARCH="generic/arch"
DEBIAN="debian/bullseye64"
ROCKY="generic/rocky8"
UBUNTU="ubuntu/jammy64"

[[ ! -e Vagrantfile ]] && touch Vagrantfile
cat > Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV["LC_ALL"] = "en_US.UTF-8"

# DELETE OR ADD FURTHER ENTRIES DOWN BELOW
# AND CHANGE IPs & HOSTNAMES, IF NEEDED
boxes = [
    {
        :name => "proxy01-local",
        :cpus => "2",
        :memory => "2048",
        :address => "192.168.56.10",
        :distribution => "$UBUNTU"
    },
    {
        :name => "web01-local",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.11",
        :distribution => "$DEBIAN"
    },
    {
        :name => "db01-local",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.12",
        :distribution => "$UBUNTU"
    },
    {
        :name => "cache01-local",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.13",
        :distribution => "$DEBIAN"
    },
    {
        :name => "queue01-local",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.14",
        :distribution => "$UBUNTU"
    }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.box = vars[:distribution]
      machine.ssh.forward_agent = true
      machine.vm.hostname = vars[:name]
      machine.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", vars[:memory]]
        vb.customize ["modifyvm", :id, "--cpus", vars[:cpus]]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      machine.vm.network :private_network, ip: vars[:address]
      if machine.vm.hostname == 'main'
        machine.vm.synced_folder "./main", "/vagrant", type: "nfs", nfs_version: 4, nfs_udp: false, create: true
        machine.vm.provision "shell", path: "./main/bin/installCertificates.sh"
        machine.vm.provision "shell", path: "./main/bin/installPackages.sh"
      else
        machine.vm.synced_folder "./node", "/vagrant", type: "nfs", nfs_version: 4, nfs_udp: false, create: true
        machine.vm.provision "shell", path: "./node/bin/installCertificates.sh"
      end
    end
  end
end
EOF

exit 0;
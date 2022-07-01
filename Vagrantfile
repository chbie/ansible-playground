
# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

# customize ip and hostname for your personal setup


Vagrant.configure("2") do |config|

  # testslave
  config.vm.define "testslave" do |testslave|
    testslave.vm.box = "ansible-playground-testslave"
    testslave.vm.box = "debian/bullseye64"
    testslave.ssh.forward_agent = true
    testslave.vm.hostname = "testslave.yourdomain"
    testslave.vm.network "private_network", ip: "192.168.56.142"
    testslave.vm.network "forwarded_port", guest: 3306, host: 3326
    testslave.vm.synced_folder "./testslave", "/vagrant", type: "nfs", nfs_version: 4, nfs_udp: false, create: true
    testslave.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--memory", 2048]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    testslave.vm.provision "shell", path: "./testslave/bin/installCertificates.sh"
  end

  # master
  config.vm.define "master" do |master|
    master.vm.box = "ansible-playground-master"
    master.vm.box = "debian/bullseye64"
    master.ssh.forward_agent = true
    master.vm.hostname = "master.yourdomain"
    master.vm.network "private_network", ip: "192.168.56.143"
    master.vm.synced_folder "./master", "/vagrant", type: "nfs", nfs_version: 4, nfs_udp: false, create: true
    master.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--memory", 2048]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    master.vm.provision "shell", path: "./master/bin/installAnsible2.sh"
    master.vm.provision "shell", path: "./master/bin/installCertificates.sh"
  end

end


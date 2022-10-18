#!/usr/bin/bash

##########################################
#
# GLOBAL VARIABLES
#
##########################################
ALPINE_FLAG="--alpine"
ARCH_FLAG="--arch"
DEBIAN_FLAG="--debian"
ROCKY_FLAG="--rocky"
UBUNTU_FLAG="--jammy"

##########################################
#
# FUNCTIONS TO CREATE VAGRANTFILES
#
##########################################
function vf-create-Alpine() {
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
        :name => "federer",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.11"
    },
    {
        :name => "nadal",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.12"
    },
    {
        :name => "djokovic",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.13"
    },
    {
        :name => "murray",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.14"
    }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/alpine316"
  config.vbguest.auto_update = false
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider :virtualbox do |vb|
        vb.name = vars[:name]
        vb.customize ["modifyvm", :id, "--memory", vars[:memory]]
        vb.customize ["modifyvm", :id, "--cpus", vars[:cpus]]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-apk.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Arch() {
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
        :name => "calvin",
        :cpus => "4",
        :memory => "4096",
        :address => "192.168.56.21"
    },
    {
        :name => "hobbes",
        :cpus => "4",
        :memory => "4096",
        :address => "192.168.56.22"
    }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/arch"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider :virtualbox do |vb|
        vb.name = vars[:name]
        vb.customize ["modifyvm", :id, "--memory", vars[:memory]]
        vb.customize ["modifyvm", :id, "--cpus", vars[:cpus]]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "file", source: "./certificates/mirrorlist", destination: "/tmp/mirrorlist"
      machine.vm.provision "shell", inline: "/bin/cp -rf /tmp/mirrorlist /etc/pacman.d/mirrorlist"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-pac.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Debian() {
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
        :name => "blinky",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.31"
    },
    {
        :name => "pinky",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.32"
    },
    {
        :name => "inky",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.33"
    },
    {
        :name => "clyde",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.34"
    }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/bullseye64"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider :virtualbox do |vb|
        vb.name = vars[:name]
        vb.customize ["modifyvm", :id, "--memory", vars[:memory]]
        vb.customize ["modifyvm", :id, "--cpus", vars[:cpus]]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-apt.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Rocky() {
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
        :name => "balboa",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.51"
    },
    {
        :name => "creed",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.52"
    },
    {
        :name => "clang",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.53"
    },
    {
        :name => "drago",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.54"
    }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/rocky8"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider :virtualbox do |vb|
        vb.name = vars[:name]
        vb.customize ["modifyvm", :id, "--memory", vars[:memory]]
        vb.customize ["modifyvm", :id, "--cpus", vars[:cpus]]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-dnf.sh"
    end
  end
end
EOF
  exit 0;
}

function vf-create-Ubuntu() {
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
        :name => "leonardo",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.41"
    },
    {
        :name => "raphael",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.42"
    },
    {
        :name => "donatello",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.43"
    },
    {
        :name => "michelangelo",
        :cpus => "1",
        :memory => "2048",
        :address => "192.168.56.44"
    }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/jammy64"
  config.ssh.forward_agent = true
  boxes.each do |vars|
    config.vm.define vars[:name] do |machine|
      machine.vm.hostname = vars[:name]
      machine.vm.provider :virtualbox do |vb|
        vb.name = vars[:name]
        vb.customize ["modifyvm", :id, "--memory", vars[:memory]]
        vb.customize ["modifyvm", :id, "--cpus", vars[:cpus]]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      machine.vm.network :private_network, ip: vars[:address]
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provision "file", source: "./certificates/ansible_ssh.pub", destination: "~/ansible_ssh.pub"
      machine.vm.provision "shell", path: "./bin/install-certificate.sh"
      machine.vm.provision "shell", path: "./bin/packages-apt.sh"
    end
  end
end
EOF
  exit 0;
}
##########################################
#
# CALLING FUNCTION BY FLAG
#
##########################################
case $1 in
  "$ALPINE_FLAG")
    vf-create-Alpine
  ;;
  "$ARCH_FLAG")
    vf-create-Arch
  ;;
  "$DEBIAN_FLAG")
    vf-create-Debian
  ;;
  "$ROCKY_FLAG")
    vf-create-Rocky
  ;;
  "$UBUNTU_FLAG")
    vf-create-Ubuntu
  ;;
  *)
    echo "You think you're so damn clever don't you?"
    exit 1;
  ;;
esac
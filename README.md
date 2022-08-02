# bauhaus
Vagrant environments with VMs to debug ansible playbooks.
This project aims to be a basic setup to develop ansible roles for stage and production servers as well as personal setups.


### Prerequisites
The project needs a valid VirtualBox and Vagrant environment, with the [vbguest plugin for Vagrant](https://github.com/dotless-de/vagrant-vbguest) installed.
Since [synced folders](https://www.vagrantup.com/docs/synced-folders/nfs.html) are handled via NFS on your local machine, NFS server and client functionality need to be active and running as well.

Ansible will be installed on the "master" VM, so having it installed locally on your host machine is optional.


### Getting started
  
1. Customize IPs and hostnames in the Vagrantfile
2. ```vagrant up``` in the project folder
3. ```vagrant ssh master``` or ```vagrant ssh main``` to connect to the Ansible worker VM
4. ```/home/vagrant/runAnsible.sh``` to install Ansible
5. Extend it with your roles
6. Check the success in a different terminal window via ```vagrant ssh $NODE```

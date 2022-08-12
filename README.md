# bauhaus
Vagrant environments with VMs to debug ansible playbooks.
This project aims to be a basic setup to develop ansible roles for stage and production servers as well as personal setups.


### Prerequisites
The project needs a valid VirtualBox and Vagrant environment, with the [vbguest plugin for Vagrant](https://github.com/dotless-de/vagrant-vbguest) installed.
Since [synced folders](https://www.vagrantup.com/docs/synced-folders/nfs.html) are handled via NFS on your local machine, NFS server and client functionality need to be active and running as well.

### ansible-playground
Currently, 4 "wheels included" environments are provided, each containing a main and one or several test nodes.
Each environment has their own Vagrantfile with scripts and tasks for provisioning as well as directories to sync with each node according to their type.

Synced folders are mounted as ```/vagrant``` on each node.

Ansible will be installed on the "main" VM, so having it installed locally on your host machine is optional.
To test Ansible connectivity, basic playbooks and scripts are provided for the main node:
- ```/vagrant/bin/pingNodes.sh``` » sends an ICMP Echo Request (ping) to all test nodes and tests ssh connectivity
- ```/vagrant/bin/runPlaybook.sh``` » runs a simple Ansible playbook located on the main node (```/vagrant/ansible/playbook.yml```)



### Getting started
1. Customize IPs and hostnames in the Vagrantfile (optional)
2. ```vagrant up``` in the project folder
3. SSH certificates and Ansible will be installed on the Ansible worker VM ( "main" ) during setup
4. ```vagrant ssh main``` to connect to "main"
5. Test Ansible by running ```/vagrant/bin/pingNodes.sh``` or ```/vagrant/bin/runPlaybook.sh```
6. Check the success in a different terminal window via ```vagrant ssh NODE``` or ssh via the main node ```ssh NODEIP```
7. Add your own Ansible playbooks to ```ansible-playground/ENVIRONMENT/main/ansible```

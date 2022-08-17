# bauhaus
Vagrant environments with VMs to debug ansible playbooks.
This project aims to be a basic setup to develop ansible roles for stage and production servers as well as personal setups.


### Prerequisites
The project needs at least a valid VirtualBox and Vagrant environment, with the [vbguest plugin for Vagrant](https://github.com/dotless-de/vagrant-vbguest) installed.
Since [synced folders](https://www.vagrantup.com/docs/synced-folders/nfs.html) are handled via NFS on your local machine, NFS server and client functionality need to be active and running as well.
To use the inbuilt commands provided by the Makefile, [make](https://www.gnu.org/software/make/) needs to be installed on your host machine as well.

### ansible-playground
Currently, 4 "batteries included" environments are provided, each containing one or several test nodes and a control node called "main".
Each environment has their own Vagrantfile with scripts and tasks for provisioning as well as directories to synchronize files between your host machine and Vagrant VMs, mounted as ```/vagrant``` on ech main node.
Test environments include:
* Arch Linux
* Debian 11 "Bullseye"
* Rocky Linux 8
* Ubuntu 22.04 "Jammy Jellyfish"


Ansible will be installed on the main nodes, so having it installed locally on your host machine is optional.
To test Ansible connectivity, basic playbooks and scripts are provided.
- ```/vagrant/bin/pingNodes.sh``` » sends an ICMP Echo Request (ping) to all test nodes and tests ssh connectivity
- ```/vagrant/bin/runPlaybook.sh``` » runs a simple Ansible playbook located on the main node (```/vagrant/ansible/playbook.yml```)

### Getting started
1. Customize IPs and hostnames in the Vagrantfile (optional)
2. Pick an environment and initialize it using ```make```:

   * Arch Linux: ```make init-arch```
   * Debian: ```make init-deb```
   * Rocky Linux: ```make init-rocky```
   * Ubuntu: ```make init-jammy```
   * This will load the respective Vagrantfile and start all Nodes (```vagrant up```)
   
3. SSH certificates and Ansible will be installed on main during setup
4. ```vagrant ssh main``` to connect to main
5. Test Ansible by running ```/vagrant/bin/pingNodes.sh``` or ```/vagrant/bin/runPlaybook.sh```
6. Check the success in a different terminal window via ```vagrant ssh NODE``` or ssh via the main node ```ssh NODEIP```
7. Add your own Ansible playbooks to ```ansible-playground/shared/ENVIRONMENT/ansible```

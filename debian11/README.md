# ansible-playground
a vagrant environment with a master and a slave vm for debugging ansible playbooks for debian

### about
This project is a basically setup for develop ansible roles for your production servers. When you go along with the conventions it should be easy to transfer the roles to your real live production server environment. For personal environments you can handle your test- or production environment directly out of this setup. It can be a rapid start to your ansible handling. For checking the compatibility to newer debian version you have to call "vagrant destroy", then "vagrant box upgrade" and after a "vagrant up" is all ready for checking on this version.

### what do you need
The project needs a valid virtualbox and vagrant environment. In vagrant it needs additional nfs plugin in vagrant. I recommend the usage of the vbguest plugin. So you can shure for valid guest additions in your vms. When you do not want this, change your Vagrantfile. Thats all. You do not have to install ansible directly in your normal system.
https://www.vagrantup.com/docs/synced-folders/nfs.html  
https://github.com/dotless-de/vagrant-vbguest  


### getting started
  
- customize ip and hostname in the Vagrantfile
- call "vagrant up" in the project folder
- call "vagrant ssh master"
- in console of vm call the command "/home/vagrant/runAnsible.sh"
- extend it with your roles
- check the success in a additional console per "vagrant ssh testslave"
- for transition to production servers you can use the environment.yml file

Have Fun ! Sorry for non correct english. It was late on day. I want to read it soon again for corrections.

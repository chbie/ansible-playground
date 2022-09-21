SHELL := /bin/bash

CURR_DIR = $(CURDIR)
USER_DIR = $(HOME)

##########################################
#
# UTILITY OPERATIONS
#
##########################################
.PHONY: vf-arch
vf-arch:
	@./bin/create-vagrantfile.sh --arch

.PHONY: vf-debian
vf-debian:
	@./bin/create-vagrantfile.sh --debian

.PHONY: vf-rocky
vf-rocky:
	@./bin/create-vagrantfile.sh --rocky

.PHONY: vf-ubuntu
vf-ubuntu:
	@./bin/create-vagrantfile.sh --jammy

##########################################
#
# GLOBAL VAGRANT OPERATIONS
#
##########################################
.PHONY: vg-box-add
vg-box-add:
	@vagrant box add generic/arch --provider=virtualbox --force
	@vagrant box add debian/bullseye64 --provider=virtualbox --force
	@vagrant box add generic/rocky8  --provider=virtualbox --force
	@vagrant box add ubuntu/jammy64 --provider=virtualbox --force

.PHONY: vm-box-check
vg-box-check:
	@vagrant box outdated --force

.PHONY: vm-box-list
vg-box-list:
	@vagrant box list

.PHONY: vm-box-nuke
vg-box-nuke:
	@vagrant box remove * --all --force

.PHONY: vm-box-health
vg-box-status:
	@vagrant global-status --prune

.PHONY: vm-box-update
vg-box-update:
	@vagrant box update
	@vagrant box prune --keep-active-boxes --force

##########################################
#
# CURRENT VAGRANT ENV OPERATIONS
#
##########################################
.PHONY: vm-destroy
vm-destroy:
	@vagrant destroy --force --graceful

.PHONY: vm-down
vm-down:
	@vagrant halt

.PHONY: vm-provision
vm-provision:
	@vagrant reload --provision

.PHONY: vm-status
vm-status:
	@vagrant status

.PHONY: vm-up
vm-up:
	@vagrant up

##########################################
#
# INITIALIZE AND TERMINATE ENVIRONMENTS
#
##########################################
.PHONY: init-arch
init-arch: vf-arch vm-up

.PHONY: init-deb
init-deb: vf-debian vm-up

.PHONY: init-rocky
init-rocky: vf-rocky vm-up

.PHONY: init-jammy
init-jammy: vf-ubuntu vm-up

.PHONY: term-arch
term-arch: vf-arch vm-down vm-destroy

.PHONY: term-deb
term-deb: vf-debian vm-down vm-destroy

.PHONY: term-rocky
term-rocky: vf-rocky vm-down vm-destroy

.PHONY: term-jammy
term-jammy: vf-ubuntu vm-down vm-destroy
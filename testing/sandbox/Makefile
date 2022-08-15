SHELL := /bin/bash

CURR_DIR = $(CURDIR)
USER_DIR = $(HOME)

# CREATING VAGRANTFILES
.PHONY: vf-arch
vf-arch:
	@bash -c bin/vf-create-arch.sh

.PHONY: vf-debian
vf-debian:
	@bash -c bin/vf-create-debian.sh

.PHONY: vf-rocky
vf-rocky:
	@bash -c bin/vf-create-rocky.sh

.PHONY: vf-ubuntu
vf-ubuntu:
	@bash -c bin/vf-create-ubuntu.sh

# META STATUS OPERATIONS
.PHONY: vm-box-add
vm-box-add:
	@vagrant box add generic/arch --provider=virtualbox --force
	@vagrant box add debian/bullseye64 --provider=virtualbox --force
	@vagrant box add generic/rocky8  --provider=virtualbox --force
	@vagrant box add ubuntu/jammy64 --provider=virtualbox --force

.PHONY: vm-box-nuke
vm-box-nuke:
	@vagrant box remove * --all --force

.PHONY: vm-box-list
vm-box-list:
	@vagrant box list

.PHONY: vm-box-check
vm-box-check:
	@vagrant box outdated

.PHONY: vm-box-update
vm-box-update:
	@vagrant box update
	@vagrant box prune --keep-active-boxes --force

.PHONY: vm-box-status
vm-box-status:
	@vagrant status
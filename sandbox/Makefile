SHELL := /bin/bash

CURR_DIR = $(CURDIR)
USER_DIR = $(HOME)

##########################################
#
# UTILITY OPERATIONS
#
##########################################
.PHONY: vf-alpine
vf-alpine:
	@./bin/create-vagrantfile.sh --alpine

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
.PHONY: vm-box-add
vm-box-add:
	@vagrant box add generic/alpine316 --provider=virtualbox --force
	@vagrant box add generic/arch --provider=virtualbox --force
	@vagrant box add debian/bullseye64 --provider=virtualbox --force
	@vagrant box add generic/rocky8  --provider=virtualbox --force
	@vagrant box add ubuntu/jammy64 --provider=virtualbox --force

.PHONY: vm-box-check
vm-box-check:
	@vagrant box outdated --force

.PHONY: vm-box-list
vm-box-list:
	@vagrant box list

.PHONY: vm-box-nuke
vm-box-nuke:
	@vagrant box remove * --all --force

.PHONY: vm-box-health
vm-box-status:
	@vagrant global-status --prune

.PHONY: vm-box-update
vm-box-update:
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

.PHONY: vm-resume
vm-resume:
	@vagrant resume

.PHONY: vm-status
vm-status:
	@vagrant status

.PHONY: vm-suspend
vm-suspend:
	@vagrant suspend

.PHONY: vm-up
vm-up:
	@vagrant up

.PHONY: vm-forget
vm-forget: alpine-forget arch-forget debian-forget rocky-forget jammy-forget

.PHONY: alpine-forget
alpine-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.11"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.12"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.13"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.14"

.PHONY: arch-forget
arch-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.21"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.22"

.PHONY: debian-forget
debian-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.31"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.32"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.33"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.34"

.PHONY: jammy-forget
jammy-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.41"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.42"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.43"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.44"

.PHONY: rocky-forget
rocky-forget:
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.51"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.52"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.53"
	@ssh-keygen -f "${USER_DIR}/.ssh/known_hosts" -R "192.168.56.54"

##########################################
#
# INITIALIZE AND TERMINATE ENVIRONMENTS
#
##########################################
.PHONY: alpine-init
alpine-init: vf-alpine vm-up

.PHONY: arch-init
arch-init: vf-arch vm-up

.PHONY: deb-init
deb-init: vf-debian vm-up

.PHONY: jammy-init
jammy-init: vf-ubuntu vm-up

.PHONY: rocky-init
rocky-init: vf-rocky vm-up

.PHONY: alpine-term
alpine-term: vf-alpine alpine-forget vm-destroy

.PHONY: arch-term
arch-term: vf-arch arch-forget vm-destroy

.PHONY: deb-term
deb-term: vf-debian debian-forget vm-destroy

.PHONY: jammy-term
jammy-term: vf-ubuntu jammy-forget vm-destroy

.PHONY: rocky-term
rocky-term: vf-rocky rocky-forget vm-destroy

##########################################
#
# ANSIBLE COMMANDS
#
##########################################
.PHONY: ans-show-nodes
ans-show-nodes:
	@ANSIBLE_DISPLAY_SKIPPED_HOSTS=false \
	ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook \
	-i ${CURR_DIR}/ansible/inventory/hosts.yml \
	${CURR_DIR}/ansible/playbook.yml
SHELL := /bin/bash

.PHONY: help
help:		## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep


.PHONY: python
python:		## Install python modules
	@apt install python3-pip python3-venv

.PHONY: venv
venv: 
	python -m venv .venv
	@echo "!!! Please run 'source .venv/bin/activate' to enable the environment !!!"

.PHONY: config
config:
	@export ANSIBLE_CONFIG=$(PWD)/ansible.cfg

.PHONY: install
install:	## upgrade pip and install requirements in ./requirements.txt
	@pip install --upgrade pip
	@pip install -r requirements.txt

.PHONY: run
run:		## run playbook
	@ansible-playbook playbook.yaml

.PHONY: ssl
ssl:		## Create SSL certificate in ./config_nc_web/files/ssl/
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(PWD)/config_nc_web/files/ssl/ollemg.br.key -out $(PWD)/config_nc_web/files/ssl/ollemg.br.crt

.PHONY: lint
lint:		## lint playbook
	@ansible-playbook --syntax-check playbook.yaml
	@ansible-lint playbook.yaml
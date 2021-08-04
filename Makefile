SHELL := /bin/bash
help:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

python:
	apt install python3-pip python3-venv

venv: 
	python -m venv .venv

config:
	export ANSIBLE_CONFIG=$(PWD)/ansible.cfg
	ansible --version

install:
	pip install --upgrade pip
	pip install -r requirements.txt

run:
	ansible-playbook playbook.yaml



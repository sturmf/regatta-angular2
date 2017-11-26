SHELL = /bin/bash

all: install run

install:
	npm install -g firebase-tools

login:
	firebase login

rules:
	firebase-bolt database.rules.bolt

deploy:
	firebase deploy

deploy-db:
	firebase deploy --only database

.PHONY: install login rules deploy deploy-db


SHELL = /bin/bash

all: install run

install:
	npm install -g firebase-tools

login:
	firebase login

deploy:
	firebase deploy

deploy-db:
	firebase deploy --only database

.PHONY: install login deploy deploy-db


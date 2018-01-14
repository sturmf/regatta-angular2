SHELL = /bin/bash

all: install login deploy

install:
	npm install -g firebase-tools

login:
	firebase login

deploy:
	firebase deploy

deploy-firestore:
	firebase deploy --only firestore:rules

.PHONY: install login deploy deploy-firestore


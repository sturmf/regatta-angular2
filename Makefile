SHELL = /bin/bash

all: install login deploy

install:
	npm install -g firebase-tools

login:
	firebase login

deploy:
	firebase deploy

deploy-testing:
	firebase deploy --project testing

deploy-firestore:
	firebase deploy --only firestore:rules

deploy-firestore-testig:
	firebase deploy --only firestore:rules --project testing

.PHONY: install login deploy deploy-testing deploy-firestore deploy-firestore-testing


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

deploy-hosting:
	firebase deploy --only hosting

deploy-hosting-testing:
	firebase deploy --only hosting --project testing

deploy-firestore:
	firebase deploy --only firestore:rules,firestore:indexes

deploy-firestore-testig:
	firebase deploy --only firestore:rules,firestore:indexes --project testing

deploy-functions:
	firebase deploy --only functions

deploy-functions-testig:
	firebase deploy --only functions --project testing

config-set:
	firebase functions:config:set algolia.app_id=$(ALGOLIA_APP_ID) algolia.api_key=$(ALGOLIA_API_KEY)
config-dump:
	firebase functions:config:get > functions/.runtimeconfig.json

.PHONY: install login deploy deploy-testing deploy-firestore deploy-firestore-testing


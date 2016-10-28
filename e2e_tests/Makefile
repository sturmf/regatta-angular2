SHELL = /bin/sh

all: install run

install:
	npm install protractor
	node_modules/protractor/bin/webdriver-manager update
	npm install jasmine-spec-reporter --save-dev

run:
	node_modules/protractor/bin/webdriver-manager start

test:
	node_modules/protractor/bin/protractor conf.js
	
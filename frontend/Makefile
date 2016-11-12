SHELL = /bin/bash

all: install run

install:
	pub get

lint:
	dartanalyzer --fatal-warnings web lib

style:
	dartfmt -l 120 -w --set-exit-if-changed web lib

tests:
	pub run test -j1

run:
	pub serve
	

SHELL = /bin/bash

all: install run

install:
	pub get --packages-dir

lint:
	dartanalyzer --fatal-warnings web lib

style:
	dartfmt -l 120 -w --set-exit-if-changed web lib test

tests:
	pub run test -j1 -p firefox

dtests:
	pub run test -j1 -p dartium

run:
	pub serve
	

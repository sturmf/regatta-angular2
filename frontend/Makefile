SHELL = /bin/sh

all: install run

lint:
	dartanalyzer --fatal-warnings web lib

install:
	pub get

test:
	pub run test -j1

run:
	pub serve
	

SHELL = /bin/sh

all: install run

lint:
	dartanalyzer --fatal-warnings web lib

install:
	pub get

run:
	pub serve
	

SHELL = /bin/bash

all: install run

install:
	pub get --packages-dir

lint:
	dartanalyzer --fatal-warnings web lib test

style:
	dartfmt -l 120 -w --set-exit-if-changed web lib test

tests:
	# You must also have `pub serve` running somewhere
	pub run test -p firefox --pub-serve=8081

dtests:
	# You must also have `pub serve` running somewhere
	pub run test -p dartium --pub-serve=8081

run:
	pub serve


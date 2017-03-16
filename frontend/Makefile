SHELL = /bin/bash

all: install run

install:
	pub get --packages-dir

build:
	pub build --define hostname= --define hash=`git rev-parse HEAD`

lint:
	dartanalyzer --fatal-warnings --fatal-lints --fatal-hints web lib test

style:
	dartfmt -l 120 -w --set-exit-if-changed web lib test

test:
	# These are the dart unit tests
	pub run test lib

tests:
	# These are the browser tests with firefox
	# You must also have `pub serve` running somewhere
	pub run test -p firefox --pub-serve=8081

dtests:
	# These are the browser tests with dartium
	# You must also have `pub serve` running somewhere
	pub run test -p dartium --pub-serve=8081

run:
	pub serve

.PHONY: install build lint style test tests dtests run

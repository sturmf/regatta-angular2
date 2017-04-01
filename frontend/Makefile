SHELL = /bin/bash

BRANCH := $(shell git for-each-ref --format='%(objectname) %(refname:short)' refs/heads | awk "/^$$(git rev-parse HEAD)/ {print \$$2}")
HASH := $(shell git rev-parse HEAD)

all: install run

install:
	pub get --packages-dir

build:
	pub build --define hostname= --define branch=$(BRANCH) --define hash=$(HASH)

lint:
	dartanalyzer --fatal-warnings --fatal-lints --fatal-hints web lib test

style:
	dartfmt -l 120 -w --set-exit-if-changed web lib test

test:
	# These are the dart unit tests
	pub run test lib

coveralls:
	if [ "$$REPO_TOKEN" ]; then \
		pub global activate dart_coveralls && \
		pub global run dart_coveralls report \
		--exclude-test-files \
		--token $$REPO_TOKEN \
		--retry 2 \
		test/all_unit_tests_for_coverage.dart; \
	fi

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

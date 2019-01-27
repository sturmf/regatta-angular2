SHELL = /bin/bash

BRANCH := $(shell git for-each-ref --format='%(objectname) %(refname:short)' refs/heads | awk "/^$$(git rev-parse HEAD)/ {print \$$2}")
HASH := $(shell git rev-parse HEAD)

all: install run

install:
	pub get

build:
	pub run build_runner build --release --output build # FIXME: --define branch=$(BRANCH) --define hash=$(HASH)

lint:
	dartanalyzer --fatal-warnings --fatal-lints --fatal-hints web lib test

style:
	dartfmt -l 120 -w --set-exit-if-changed web lib test

coveralls:
	if [ "$$REPO_TOKEN" ]; then \
		pub global activate dart_coveralls && \
		pub global run dart_coveralls report \
		--exclude-test-files \
		--token $$REPO_TOKEN \
		--retry 2 \
		test/all_unit_tests_for_coverage.dart; \
	fi

test:
	# These are the dart unit tests
	pub run test lib

test-firefox:
	# These are the browser tests with firefox
	pub run build_runner test --fail-on-severe -- -p firefox

test-chrome:
	# These are the browser tests with chrome
	pub run build_runner test --fail-on-severe -- -p chrome

test-firestore-rules:
	# These are browser tests with chrome that connect to firestore
	# You need a configured config.json file in lib/services
	pub run build_runner test --fail-on-severe -- -p chrome lib/services/firestore_rules_test.dart

run:
	webdev serve

.PHONY: install build lint style coveralls test test-firefox test-chrome test-firestore-rules run

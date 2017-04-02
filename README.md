regatta
===============

A simple sailing race scoring program.

[![Build Status](https://travis-ci.org/sturmf/regatta-angular2.svg?branch=master)](https://travis-ci.org/sturmf/regatta-angular2)
[![Coverage Status](https://coveralls.io/repos/github/sturmf/regatta-angular2/badge.svg?branch=master)](https://coveralls.io/github/sturmf/regatta-angular2?branch=master)

This program is just beginning its development, so don't expect a working version any time soon.
The latest checkin is always automatically deployed [here](https://regatta-17147.firebaseapp.com/) on [Firebase](https://firebase.google.com/).

The main goal of this project is to learn about the state of the art development tools and workflows while still producing something useful.

This means especially using the following:

* Distributed version control ([GitHub.com](https://github.com)) [https://github.com/sturmf/regatta-angular2](https://github.com/sturmf/regatta-angular2)
* Continous integration ([Travis-CI](https://travis-ci.org)) [https://travis-ci.org/sturmf/regatta-angular2](https://travis-ci.org/sturmf/regatta-angular2)
* Test coverage ([Coveralls.io](https://coveralls.io)) [https://coveralls.io/github/sturmf/regatta-angular2](https://coveralls.io/github/sturmf/regatta-angular2)
* Code smells ([Dart analyzer](https://pub.dartlang.org/packages/analyzer))
* Style guide checking ([Dart style](https://pub.dartlang.org/packages/dart_style))
* Planning and issue tracking ([JIRA Software](https://www.atlassian.com/software/jira)) [https://regatta.atlassian.net](https://regatta.atlassian.net)
* Documentation ([JIRA Confluence](https://www.atlassian.com/software/confluence)) [https://regatta.atlassian.net/wiki](https://regatta.atlassian.net/wiki)


A live version of the latest build can be seen at: https://regatta-17147.firebaseapp.com

# Running the Angular2 Dart frontend program

Initial setup of the environment

    cd frontend
    make install

Now run the Dart webserver with

    cd frontend
    make run
    # open a browser and point it to localhost:8080


# Make changes ready for delivery

To run the style guide checks and tests run

    cd frontend
    make lint
    make style
    make test
    make dtests
    make tests


# Contributions from non team members

We would love to get contributions from outside! Since one of the goals is to also get this project in a shape where it could serve as a blueprint for other projects,
don't hesitate to suggest style changes or technical changes etc.
For this purpose it's easiest to clone the repository on github and submit a pull request but any other form of communication is fine and highly appreciated!



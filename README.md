regatta
===============

A simple sailing race scoring program.

[![Build Status](https://travis-ci.org/sturmf/regatta-angular2.svg?branch=master)](https://travis-ci.org/sturmf/regatta-angular2)
[![Coverage Status](https://coveralls.io/repos/sturmf/regatta-angular2/badge.svg?branch=master&service=github)](https://coveralls.io/github/sturmf/regatta-angular2?branch=master)
[![Code Health](https://landscape.io/github/sturmf/regatta-angular2/master/landscape.svg?style=flat)](https://landscape.io/github/sturmf/regatta-angular2/master)

This program is just beginning its development, so don't expect a working version any time soon.

The main goal of this project is to learn about the state of the art development tools and workflows while still producing something useful.

This means especially using the following:

* Distributed version control ([GitHub.com](https://github.com)) [https://github.com/sturmf/regatta-angular2](https://github.com/sturmf/regatta-angular2)
* Continous integration ([Travis-CI](https://travis-ci.org)) [https://travis-ci.org/sturmf/regatta-angular2](https://travis-ci.org/sturmf/regatta-angular2)
* Test coverage ([Coveralls.io](https://coveralls.io)) [https://coveralls.io/github/sturmf/regatta-angular2](https://coveralls.io/github/sturmf/regatta-angular2)
* Code smells ([Landscape.io](https://landscape.io)) [https://landscape.io/github/sturmf/regatta-angular2/](https://landscape.io/github/sturmf/regatta-angular2/)
* Style guide checking ([flake8](https://pypi.python.org/pypi/flake8)) this combines [PEP 0008](https://www.python.org/dev/peps/pep-0008) and [pyflakes](https://pypi.python.org/pypi/pyflakes)
* Planning and issue tracking ([JIRA Software](https://www.atlassian.com/software/jira)) [https://regatta.atlassian.net](https://regatta.atlassian.net)
* Documentation ([JIRA Confluence](https://www.atlassian.com/software/confluence)) [https://regatta.atlassian.net/wiki](https://regatta.atlassian.net/wiki)


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


# Contributions from non team members

We would love to get contributions from outside! Since one of the goals is to also get this project in a shape where it could serve as a blueprint for other projects,
don't hesitate to suggest style changes or technical changes etc.
For this purpose it's easiest to clone the repository on github and submit a pull request but any other form of communication is fine and highly appreciated!



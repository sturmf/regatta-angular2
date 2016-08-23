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
* Planing and issue tracking ([JIRA Software](https://www.atlassian.com/software/jira)) [https://regatta.atlassian.net](https://regatta.atlassian.net)
* Documentation ([JIRA Confluence](https://www.atlassian.com/software/confluence)) [https://regatta.atlassian.net/wiki](https://regatta.atlassian.net/wiki)


# Running the program

Initial setup of the environment

    pyvenv env
    source env/bin/activate
    pip install -r regatta/requirements.txt
    cd regatta && python manage.py migrate

Now run the program with

    cd regatta && python3 main.py


# Make changes ready for delivery

To run the style guide checks and tests run

    cd regatta 
    python3 setup.py flake8
    python3 setup.py test

or

    cd regatta
    flake8 events
    python runtests.py


# Contributions from non team members

Feel free to clone the repository on github and submit a pull request.



SHELL = /bin/bash

all: env install run

env:
	pyvenv env

install_tools:
	source env/bin/activate; \
	pip install flake8; \
	pip install coveralls

install:
	source env/bin/activate; \
	pip install --upgrade wheel; \
	pip install -r requirements.txt; \
	python manage.py migrate

lint:
	source env/bin/activate; \
	python setup.py flake8

tests:
	source env/bin/activate; \
	coverage run setup.py test

run:
	source env/bin/activate; \
	python manage.py runserver

su:
	source env/bin/activate; \
	python manage.py createsuperuser


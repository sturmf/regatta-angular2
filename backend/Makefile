SHELL = /bin/sh

all: install run

install:
	pyvenv env; \
	source env/bin/activate; \
	pip install -r requirements.txt; \
	python manage.py migrate

run:
	source env/bin/activate; \
	python manage.py runserver

su:
	pyvenv env; \
	python manage.py createsuperuser
	
#!/bin/bash

python manage.py makemigrations &&
python manage.py migrate &&
python setup.py flake8 &&
python setup.py test

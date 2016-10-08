#!/bin/sh

# Change to backend location
cd backend

python manage.py migrate                  # Apply database migrations
python manage.py collectstatic --noinput  # Collect static files

echo Starting Gunicorn in background.
gunicorn regatta.wsgi:application \
    --bind 127.0.0.1:8000 \
    --workers 3 &

echo Starting nginx in foreground.
exec nginx -g "daemon off;"

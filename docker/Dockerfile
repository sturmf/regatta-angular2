FROM python:alpine

# We need the Django source for the REST backend
COPY /build/backend /regatta/backend
RUN mkdir /regatta/static
RUN pip install -r /regatta/backend/requirements.txt
RUN pip install gunicorn

# We need the generated html and js for the frontend
COPY /build/web /regatta/web

# Install nginx for serving the backend and frontend
RUN apk add --update nginx
RUN mkdir -p /run/nginx
COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf

# Port to expose to the host
EXPOSE 80

# Copy entrypoint script into the image
WORKDIR /regatta
COPY /docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

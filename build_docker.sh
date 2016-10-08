#!/bin/sh

(cd frontend && pub get)
(cd frontend && pub build --define hostname=)
docker build .

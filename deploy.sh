#!/bin/bash

(cd frontend && make build)
(cd docker && make deploy)


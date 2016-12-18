SHELL = /bin/bash


deploy:
	# Prepare everything for the image creation
	rm -rf build
	mkdir build
	cp -a ../backend build
	cp -a ../frontend/build/web/ build
	# Build image
	docker build -t regatta .
	# Flip old with new container
	docker stop regatta_container
	docker run -p 80:80 -d --name regatta_container_new regatta
	# FIXME: here we would check if the new container started...
	docker rm regatta_container
	docker rename regatta_container_new regatta_container
	# FIXME: with docker 1.13 we can use system prune
	# Cleanup leftover container and images
	docker ps --filter status=exited -q --no-trunc | xargs --no-run-if-empty docker rm 
	docker images --filter dangling=true -q --no-trunc | xargs --no-run-if-empty docker rmi

run:
	docker run -p 80:80 -d --name regatta_container regatta

.PHONY:	deploy run

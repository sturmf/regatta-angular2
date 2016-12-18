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
	exited_containers=$$(docker ps --filter status=exited -q 2>/dev/null); \
	if [ -n "$$exited_containers" ]; then \
	    docker rm $$exited_containers; \
	fi
	dangling_images=$$(docker images --filter dangling=true -q --no-trunc 2>/dev/null); \
	if [ -n "$$dangling_images" ]; then \
	    docker rmi $$dangling_images; \
	fi

run:
	docker run -p 80:80 -d --name regatta_container regatta

.PHONY:	deploy run

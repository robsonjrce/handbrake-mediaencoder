PROJECT ?= handbrake-mediaencoder
TAG     ?= 0.0.0
IMAGE=$(PROJECT):$(TAG)

all:
	@echo "Available targets:"
	@echo "  * build - build a Docker image for $(IMAGE)"

build: Dockerfile
	docker build -t $(IMAGE) .

run: 
	docker-compose build
	docker-compose run --rm $(PROJECT)

.PHONY: build run setup-devices
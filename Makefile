# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`
dpl ?= deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

TAGS := all 12 11 10 9 8 7 6

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


# DOCKER TASKS
build: ## Build specific docker image
	docker build -t $(APP_NAME) -f $(FILE) .

build-nc: ## Build specific docker image without caching
	docker build --no-cache -t $(APP_NAME) -f $(FILE) .

build-all-nc: ## Build all docker images without caching
	for VERSION in $(TAGS) ; do \
		docker build --no-cache -t $(APP_NAME):$$VERSION -f $$VERSION/Dockerfile .  ; \
	done

# release: build-nc publish ## Release and publish a docker image to registory

release-all: build-all-nc publish-all ## Release and publish all docker images to registory

publish-all: docker-login docker-push-all ## Publish all versions

# Publish all docker images to registory
docker-push-all: docker-tag-all 
	for TAG in $(TAGS) ; do \
		echo "docker push $(DOCKER_HUB)/$(APP_NAME):$$TAG ... " ; \
		docker push $(DOCKER_HUB)/$(APP_NAME):$$TAG  ; \
	done

# Generate docker image tags
docker-tag-all: 
	for TAG in $(TAGS) ; do \
		docker tag $(APP_NAME):$$TAG $(DOCKER_HUB)/$(APP_NAME):$$TAG  ; \
	done

# Login to docker hub
docker-login:
	docker login

test:
	for TAG in $(TAGS) ; do \
		echo "testing $$TAG"  ; \
	done

version: ## Output the all support versions
	@echo $(TAGS)

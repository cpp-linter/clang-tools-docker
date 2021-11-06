# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`
dpl ?= deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


# DOCKER TASKS
build: ## Build a docker image
	docker build -t $(APP_NAME) -f $(FILE) .

build-nc: ## Build a docker image without caching
	docker build --no-cache -t $(APP_NAME) -f $(FILE) .

build-all-nc: ## Build all docker images without caching
	for TAG in $(APP_TAGS) ; do \
		docker build --no-cache -t $(APP_NAME):$$TAG -f $$TAG/Dockerfile .  ; \
	done

release: build-nc publish ## Release and publish a docker image to registry

release-all: build-all-nc docker-login docker-tag-all docker-push-all ## Release and publish all images to registry

publish: docker-login docker-tag docker-push ## Publish a docker image to registry

publish-all: docker-login docker-tag-all docker-push-all ## Publish all docker images to registry

docker-push: ## Docker push a docker image to registry
	docker push $(DOCKER_HUB)/$(APP_NAME):$(TAG)

docker-push-all: ## Docker push all docker images to registry
	for TAG in $(APP_TAGS) ; do \
		echo "docker push $(DOCKER_HUB)/$(APP_NAME):$$TAG ... " ; \
		docker push $(DOCKER_HUB)/$(APP_NAME):$$TAG  ; \
	done

docker-tag: ## Docker image create a tag
	docker tag $(APP_NAME):$(TAG) $(DOCKER_HUB)/$(APP_NAME):$(TAG)

docker-tag-all: ## Docker image create all tags
	for TAG in $(APP_TAGS) ; do \
		docker tag $(APP_NAME):$$TAG $(DOCKER_HUB)/$(APP_NAME):$$TAG  ; \
	done

docker-login: ## Login to docker hub
	docker login

version: ## Output the all support versions
	@echo $(APP_TAGS)

# Test Makefile syntax.
test:
	for TAG in $(APP_TAGS) ; do \
		echo "testing $$TAG" ; \
	done
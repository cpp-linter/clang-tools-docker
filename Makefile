FILE ?= unknow
APP_NAME := clang-tools
DIR_NAME := $(shell dirname $(FILE))
TAG := $(shell basename `dirname $(FILE)`)
IMAGE_NAME ?= $(APP_NAME):$(TAG)
DOCKER_HUB=xianpengshen/$(IMAGE_NAME)
DOCKER_PKG=ghcr.io/shenxianpeng/$(IMAGE_NAME)
DOCKERFILE ?= $(DIR_NAME)/Dockerfile
CONTAINER_BIN ?= docker

## Image metadatas
GIT_COMMIT_REV ?= $(shell git log -n 1 --pretty=format:'%h')
GIT_SCM_URL ?= $(shell git config --get remote.origin.url)
BUILD_DATE ?= $(shell date --utc '+%Y-%m-%dT%H:%M:%S' 2>/dev/null || gdate --utc '+%Y-%m-%dT%H:%M:%S')

check-file:
ifeq ($(FILE), unknow)
	$(error FILE is not set. e.g  make build FILE=12/Dockerfile)
else
	echo $(FILE)
endif

check-name:
ifeq ($(IMAGE_NAME), .:.)
	$(error IMAGE_NAME is not set. e.g  make deploy IMAGE_NAME=clang-tools:12)
endif

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

# help: ## This help.
# 	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

help: ## Show this Makefile's help
	@echo ""
	@echo "Make Docker images for Clang Tools"
	@echo ""
	@echo 'Usage: make [EXTRA_ARGUMENTS]'
	@echo ""
	@echo "make build FILE=12/Dockerfile    	build image, see the example"
	@echo "make deploy NAME=clang-tools:12              deploy image to Artifactory registry"
	@echo "make publish FILE=12/Dockerfile  	build and deploy image to Artifactory registry"
	@echo "make publish-all                     build and deploy all clang-tools images to Docker Hub and PKG"
	@echo "make lint                            lint Dockerfile validate inline bash"
	@echo "make clean                           clean all generate files"
	@echo "make prune                           clean all images that are not actively used"
	@echo ""

.DEFAULT_GOAL := help


# DOCKER TASKS
build: check-file ## ## Build the Docker Image $(NAME) from $(DOCKERFILE)
	@echo "== Building $(IMAGE_NAME) from $(DOCKERFILE)..."
	@export DOCKER_BUILDKIT=1
	@$(CONTAINER_BIN) build \
		-t $(IMAGE_NAME) \
		--label "image.source=$(GIT_SCM_URL)" \
		--label "image.revision=$(GIT_COMMIT_REV)" \
		--label "image.created=$(BUILD_DATE)" \
		-f $(DOCKERFILE) \
		$(DIR_NAME)
	@echo "== Build ✅ image $(IMAGE_NAME) Succeeded."

## This steps expects that you are logged to the Docker registry to push image into
deploy: check-name ## Tag and push the built image as specified by $(IMAGE_DEPLOY).
	@echo "== Deploying $(IMAGE_NAME) to $(DOCKER_HUB)..."
	$(CONTAINER_BIN) tag $(IMAGE_NAME) $(DOCKER_HUB)
	$(CONTAINER_BIN) push $(DEPLOY_NAME)
	@echo "== Deploy DOCKER_HUB ✅ Succeeded"
	@echo "== Deploying $(IMAGE_NAME) to $(DOCKER_PKG)..."
	$(CONTAINER_BIN) tag $(IMAGE_NAME) $(DOCKER_PKG)
	$(CONTAINER_BIN) push $(DOCKER_PKG)
	@echo "== Deploy DOCKER_PKG ✅ Succeeded"
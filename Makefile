## For Docker <=20.04
export DOCKER_BUILDKIT=1
## For Docker <=20.04
export DOCKER_CLI_EXPERIMENTAL=enabled
## Required to have docker build output always printed on stdout
export BUILDKIT_PROGRESS=plain
## Required to have the commit SHA added as a Docker image label

FILE ?= unknow
APP_NAME := clang-tools
DIR_NAME := $(shell dirname $(FILE))
TAG := $(shell basename `dirname $(FILE)`)
IMAGE_NAME ?= $(APP_NAME):$(TAG)
DOCKER_HUB=xianpengshen/$(IMAGE_NAME)
DOCKERFILE ?= $(DIR_NAME)/Dockerfile
CONTAINER_BIN ?= docker

## Image metadatas
COMMIT_SHA ?= =$(shell git rev-parse HEAD)
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

help: ## Show this Makefile's help
	@echo ""
	@echo "Make clang tools Docker images"
	@echo ""
	@echo 'Usage: make [EXTRA_ARGUMENTS]'
	@echo ""
	@echo "make build FILE=12/Dockerfile        Build image, see the example"
	@echo "make publish FILE=12/Dockerfile      Build and deploy image to Docker Hub"
	@echo "make lint                            Lint Dockerfile validate inline bash"
	@echo "make prune                           Clean all images that are not actively used"
	@echo ""

.DEFAULT_GOAL := help

# DOCKER TASKS
build: check-file lint ## ## Build the Docker Image $(NAME) from $(DOCKERFILE)
	@echo "== Building $(IMAGE_NAME) from $(DOCKERFILE)..."
	@$(CONTAINER_BIN) build \
		-t $(IMAGE_NAME) \
		--label "image.source=$(GIT_SCM_URL)" \
		--label "image.revision=$(COMMIT_SHA)" \
		--label "image.created=$(BUILD_DATE)" \
		-f $(DOCKERFILE) \
		$(DIR_NAME)
	@echo "== Build ✅ image $(IMAGE_NAME) Succeeded."

## This steps expects that you are logged to the Docker registry to push image into
publish: check-name check-file build ## Tag and push the built image as specified by $(IMAGE_DEPLOY).
	@echo "== Deploying $(IMAGE_NAME) to $(DOCKER_HUB)..."
	$(CONTAINER_BIN) tag $(IMAGE_NAME) $(DOCKER_HUB)
	$(CONTAINER_BIN) push $(DOCKER_HUB)
	@echo "== Deploy ✅ $(DOCKER_HUB) Succeeded"

login: ## Docker login
	$(CONTAINER_BIN) login --username xianpengshen

prune:  ## clean all that is not actively used
	@docker system prune -af
	@echo "== Prune ✅ image(s) Succeeded"

lint: ## Lint code
	@echo "== Running pre-commit against all-files..."
	@pre-commit run --all-files
	@echo "== Lint ✅ Succeeded"

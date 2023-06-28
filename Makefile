## For Docker <=20.04
export DOCKER_BUILDKIT=1
## For Docker <=20.04
export DOCKER_CLI_EXPERIMENTAL=enabled
## Required to have docker build output always printed on stdout
export BUILDKIT_PROGRESS=plain
## Required to have the commit SHA added as a Docker image label
TARGET ?= unknow
## Image metadatas
COMMIT_SHA ?= =$(shell git rev-parse HEAD)

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Show this Makefile's help
	@echo ""
	@echo "Make clang-tools Docker images"
	@echo ""
	@echo 'Usage: make [EXTRA_ARGUMENTS]'
	@echo ""
	@echo "make build TARGET=clang_tools_16     Build image, see the example"
	@echo "make publish TARGET=clang_tools_16   Build and deploy image to Docker and GitHub registry"
	@echo "make lint                            Lint Dockerfile validate inline bash"
	@echo "make prune                           Clean all images that are not actively used"
	@echo ""

.DEFAULT_GOAL := help

# DOCKER TASKS
build: ## Build the Docker Image
	@echo "== Building Image ..."
	@docker buildx bake --file docker-bake.hcl $(TARGET)
	@echo "== Build target $(TARGET) succeeded."

publish: ## Push the built image to container registry.
	@echo "== Deploying $(TARGET) ..."
	@docker buildx bake --file docker-bake.hcl --push $(TARGET)
	@echo "== Deploy target $(TARGET) succeeded"

docker-login: ## Docker Hub login
	docker login --username xianpengshen

registry-login: ## GitHub container registry login
	docker login ghcr.io -u shenxianpeng

prune:  ## Clean all that is not actively used
	@docker system prune -af
	@echo "== Prune image(s) succeeded"

lint: ## Lint code
	@echo "== Running pre-commit against all-files..."
	@pre-commit run --all-files
	@echo "== Lint succeeded"

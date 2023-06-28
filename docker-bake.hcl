# ---- groups ----
group "linux" {
  targets = [
    "clang-tools-6",
    "clang-tools-7",
    "clang-tools-8",
    "clang-tools-9",
    "clang-tools-10",
    "clang-tools-11",
    "clang-tools-11-alpine",
    "clang-tools-12",
    "clang-tools-12-alpine",
    "clang-tools-13",
    "clang-tools-14",
    "clang-tools-15",
    "clang-tools-16",
    "clang-tools-all",
  ]
}

# ---- variables ----
variable "DOCKER_REPO" {
  default = "xianpengshen/clang-tools"
}

variable "GITHUB_REPO" {
    default = "ghcr.io/cpp-linter/clang-tools"
}

variable "ALPINE_VERSION" {
  default = "3.18"
}

# ---- targets ----
target "clang-tools-6" {
  dockerfile = "6/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:6",
    "${GITHUB_REPO}:6"
    ]
  platforms = ["linux/amd64"]
}

target "clang-tools-7" {
  dockerfile = "7/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:7",
    "${GITHUB_REPO}:7"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-8" {
  dockerfile = "8/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:8",
    "${GITHUB_REPO}:8"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-9" {
  dockerfile = "9/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:9",
    "${GITHUB_REPO}:9"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-10" {
  dockerfile = "10/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:10",
    "${GITHUB_REPO}:10"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-11" {
  dockerfile = "11/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:11",
    "${GITHUB_REPO}:11"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-11-alpine" {
  dockerfile = "11-alpine/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:11-alpine-${ALPINE_VERSION}",
    "${GITHUB_REPO}:11-alpine-${ALPINE_VERSION}"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-12" {
  dockerfile = "12/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:12",
    "${GITHUB_REPO}:12"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-12-alpine" {
  dockerfile = "12-alpine/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:12-alpine-${ALPINE_VERSION}",
    "${GITHUB_REPO}:12-alpine-${ALPINE_VERSION}"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-13" {
  dockerfile = "13/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:13",
    "${GITHUB_REPO}:13"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-14" {
  dockerfile = "14/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:14",
    "${GITHUB_REPO}:14"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-15" {
  dockerfile = "15/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:15",
    "${GITHUB_REPO}:15"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-16" {
  dockerfile = "16/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:16",
    "${GITHUB_REPO}:16"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools-all" {
  dockerfile = "all/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:all",
    "${GITHUB_REPO}:all"
  ]
  platforms = ["linux/amd64"]
}

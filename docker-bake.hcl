# ---- groups ----
group "linux" {
  targets = [
    "ubuntu_clang_6",
    "ubuntu_clang_7",
    "ubuntu_clang_8",
    "ubuntu_clang_9",
    "ubuntu_clang_10",
    "ubuntu_clang_11",
    "alpine_clang_11",
    "ubuntu_clang_12",
    "alpine_clang_12",
    "ubuntu_clang_13",
    "ubuntu_clang_14",
    "ubuntu_clang_15",
    "ubuntu_clang_16",
    "ubuntu_clang_all",
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
target "ubuntu_clang_6" {
  dockerfile = "6/Dockerfile"
  context = "."
  tags = ["${DOCKER_REPO}:6"]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_7" {
  dockerfile = "7/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:7",
    "${GITHUB_REPO}:7"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_8" {
  dockerfile = "8/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:8",
    "${GITHUB_REPO}:8"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_9" {
  dockerfile = "9/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:9",
    "${GITHUB_REPO}:9"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_10" {
  dockerfile = "10/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:10",
    "${GITHUB_REPO}:10"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_11" {
  dockerfile = "11/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:11",
    "${GITHUB_REPO}:11"
  ]
  platforms = ["linux/amd64"]
}

target "alpine_clang_11" {
  dockerfile = "11-alpine-${ALPINE_VERSION}/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:11-alpine-${ALPINE_VERSION}",
    "${GITHUB_REPO}:11-alpine-${ALPINE_VERSION}"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_12" {
  dockerfile = "12/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:12",
    "${GITHUB_REPO}:12"
  ]
  platforms = ["linux/amd64"]
}

target "alpine_clang_12" {
  dockerfile = "12-alpine-${ALPINE_VERSION}/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:12-alpine-${ALPINE_VERSION}",
    "${GITHUB_REPO}:12-alpine-${ALPINE_VERSION}"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_13" {
  dockerfile = "13/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:13",
    "${GITHUB_REPO}:13"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_14" {
  dockerfile = "14/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:14",
    "${GITHUB_REPO}:14"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_15" {
  dockerfile = "15/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:15",
    "${GITHUB_REPO}:15"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_16" {
  dockerfile = "16/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:16",
    "${GITHUB_REPO}:16"
  ]
  platforms = ["linux/amd64"]
}

target "ubuntu_clang_all" {
  dockerfile = "all/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:all",
    "${GITHUB_REPO}:all"
  ]
  platforms = ["linux/amd64"]
}

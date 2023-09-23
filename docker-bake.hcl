# ---- groups ----
group "default" {
  targets = [
    "all",
    "17",
    "16",
    "15",
    "14",
    "13",
    "12",
    "11",
    "10",
    "9",
    "8",
    "7",
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
target "clang-tools" {
  matrix = {
    tgt = ["all"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile.${tgt}"
  context = "."
  args = {
    BASE_IMAGE="ubuntu:20.04"
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["17", "16", "15", "14", "13"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
    BASE_IMAGE="ubuntu:23.10"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["12", "11"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
    BASE_IMAGE="ubuntu:22.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["10", "9", "8", "7"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
    BASE_IMAGE="ubuntu:20.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64"]
}

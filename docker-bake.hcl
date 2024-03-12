# ---- groups ----
group "default" {
  targets = [
    "all",
    "18",
    "17",
    "16",
    "16-alpine",
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

# ---- targets ----
target "all" {
  dockerfile = "Dockerfile.all"
  context = "."
  args = {
    BASE_IMAGE="ubuntu:20.04"
  }
  tags = [
    "${DOCKER_REPO}:all",
    "${GITHUB_REPO}:all"
  ]
  platforms = ["linux/amd64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["18", "17", "16", "15", "14", "13"]
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

target "clang-tools" {
  matrix = {
    tgt = ["16-alpine"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE="alpine:3.18",
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64"]
}

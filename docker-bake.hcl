# ---- groups ----
group "default" {
  targets = [
    "all",
    "20", "20-alpine",
    "19", "19-alpine",
    "18", "18-alpine",
    "17", "17-alpine",
    "16", "16-alpine",
    "15", "15-alpine",
    "14", "14-alpine",
    "13", "13-alpine",
    "12", "12-alpine",
    "11", "11-alpine",
    "10", "10-alpine",
    "9", "9-alpine",
    "8", "8-alpine",
    "7", "7-alpine",
  ]
# ---- Alpine targets ----
target "20-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "20"
  }
  tags = [
    "${DOCKER_REPO}:20-alpine",
    "${GITHUB_REPO}:20-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "19-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "19"
  }
  tags = [
    "${DOCKER_REPO}:19-alpine",
    "${GITHUB_REPO}:19-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "18-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "18"
  }
  tags = [
    "${DOCKER_REPO}:18-alpine",
    "${GITHUB_REPO}:18-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "17-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "17"
  }
  tags = [
    "${DOCKER_REPO}:17-alpine",
    "${GITHUB_REPO}:17-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "15-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "15"
  }
  tags = [
    "${DOCKER_REPO}:15-alpine",
    "${GITHUB_REPO}:15-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "14-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "14"
  }
  tags = [
    "${DOCKER_REPO}:14-alpine",
    "${GITHUB_REPO}:14-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "13-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "13"
  }
  tags = [
    "${DOCKER_REPO}:13-alpine",
    "${GITHUB_REPO}:13-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "12-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "12"
  }
  tags = [
    "${DOCKER_REPO}:12-alpine",
    "${GITHUB_REPO}:12-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "11-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "11"
  }
  tags = [
    "${DOCKER_REPO}:11-alpine",
    "${GITHUB_REPO}:11-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "10-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "10"
  }
  tags = [
    "${DOCKER_REPO}:10-alpine",
    "${GITHUB_REPO}:10-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "9-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "9"
  }
  tags = [
    "${DOCKER_REPO}:9-alpine",
    "${GITHUB_REPO}:9-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "8-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "8"
  }
  tags = [
    "${DOCKER_REPO}:8-alpine",
    "${GITHUB_REPO}:8-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "7-alpine" {
  dockerfile = "Dockerfile.alpine"
  context = "."
  args = {
    BASE_IMAGE = "alpine:3.18"
    CLANG_VERSION = "7"
  }
  tags = [
    "${DOCKER_REPO}:7-alpine",
    "${GITHUB_REPO}:7-alpine"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}
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
    BASE_IMAGE="ubuntu:24.04"
  }
  tags = [
    "${DOCKER_REPO}:all",
    "${GITHUB_REPO}:all"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["20"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
    # https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=clang-format-20&searchon=names
  BASE_IMAGE="ubuntu:24.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["19"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
    # https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=clang-format-19&searchon=names
  BASE_IMAGE="ubuntu:24.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["18"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
    # https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=clang-format-18&searchon=names
  BASE_IMAGE="ubuntu:24.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["17", "16", "15", "14"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
  BASE_IMAGE="ubuntu:24.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["13", "12", "11"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
  BASE_IMAGE="ubuntu:24.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}

target "clang-tools" {
  matrix = {
    tgt = ["10", "9", "8", "7"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile"
  context = "."
  args = {
  BASE_IMAGE="ubuntu:24.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
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

# ---- groups ----
group "default" {
  targets = [
    "all",
    "23",
    "22",
    "22-alpine",
    "21",
    "21-alpine",
    "20",
    "20-alpine",
    "19",
    "19-alpine",
    "18",
    "18-alpine",
    "17",
    "17-alpine",
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
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=image"]
}

# LLVM 12 and later: the cpp-linter static binaries, one pinned release each.
# https://cpp-linter.github.io/clang-tools-static-binaries/index.json lists the
# newest release of every major; CI warns when a pin below falls behind it.
target "clang-tools" {
  matrix = {
    item = [
      { major = "23", version = "23.1.3", release = "llvm-23.1.3-3", base = "ubuntu:resolute" },
      { major = "22", version = "22.1.8", release = "llvm-22.1.8-3", base = "ubuntu:resolute" },
      { major = "21", version = "21.1.8", release = "llvm-21.1.8", base = "ubuntu:resolute" },
      { major = "20", version = "20.1.8", release = "llvm-20.1.8", base = "ubuntu:resolute" },
      { major = "19", version = "19.1.7", release = "llvm-19.1.7", base = "ubuntu:resolute" },
      { major = "18", version = "18.1.8", release = "llvm-18.1.8", base = "ubuntu:noble" },
      { major = "17", version = "17.0.6", release = "llvm-17.0.6-2", base = "ubuntu:noble" },
      { major = "16", version = "16.0.6", release = "llvm-16.0.6", base = "ubuntu:noble" },
      { major = "15", version = "15.0.7", release = "llvm-15.0.7", base = "ubuntu:noble" },
      { major = "14", version = "14.0.6", release = "llvm-14.0.6", base = "ubuntu:noble" },
      { major = "13", version = "13.0.1", release = "llvm-13.0.1", base = "ubuntu:22.04" },
      { major = "12", version = "12.0.1", release = "llvm-12.0.1-2", base = "ubuntu:22.04" },
    ]
  }
  name = item.major
  dockerfile = "Dockerfile"
  context = "."
  args = {
    BASE_IMAGE = item.base
    LLVM_MAJOR = item.major
    LLVM_VERSION = item.version
    RELEASE_TAG = item.release
  }
  tags = [
    "${DOCKER_REPO}:${item.major}",
    "${DOCKER_REPO}:${item.version}",
    "${GITHUB_REPO}:${item.major}",
    "${GITHUB_REPO}:${item.version}",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=image"]
}

# LLVM 11 and older: Ubuntu's apt packages.
target "clang-tools" {
  matrix = {
    tgt = ["11"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile.apt"
  context = "."
  args = {
    BASE_IMAGE="ubuntu:22.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=image"]
}

target "clang-tools" {
  matrix = {
    tgt = ["10", "9", "8", "7"]
  }
  name = "${tgt}"
  dockerfile = "Dockerfile.apt"
  context = "."
  args = {
    BASE_IMAGE="ubuntu:20.04"
    CLANG_VERSION="${tgt}",
  }
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=image"]
}

target "clang-tools" {
  matrix = {
    tgt = ["16-alpine", "17-alpine", "18-alpine", "19-alpine", "20-alpine", "21-alpine", "22-alpine"]
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
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=image"]
}

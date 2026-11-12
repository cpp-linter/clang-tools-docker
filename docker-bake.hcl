# ---- groups ----
group "default" {
  targets = ["all", "clang-tools"]
}

# ---- variables ----
variable "DOCKER_REPO" {
  default = "xianpengshen/clang-tools"
}

variable "GITHUB_REPO" {
    default = "ghcr.io/cpp-linter/clang-tools"
}

# The newest LLVM major: its image also gets the `latest` tag.
variable "LATEST" {
  default = "23"
}

# LLVM 12 and later: the cpp-linter static binaries, one pinned release each.
# https://cpp-linter.github.io/clang-tools-static-binaries/index.json lists the
# newest release of every major. scripts/update-pins.py rewrites this list (and
# LATEST) from it, and the Update pins workflow opens a pull request with the
# result, so keep one release per line in this shape.
variable "RELEASES" {
  default = [
    { major = "23", version = "23.1.5", release = "llvm-23.1.5-2", base = "ubuntu:resolute" },
    { major = "22", version = "22.1.8", release = "llvm-22.1.8-4", base = "ubuntu:resolute" },
    { major = "21", version = "21.1.8", release = "llvm-21.1.8-2", base = "ubuntu:resolute" },
    { major = "20", version = "20.1.8", release = "llvm-20.1.8-2", base = "ubuntu:resolute" },
    { major = "19", version = "19.1.7", release = "llvm-19.1.7-2", base = "ubuntu:resolute" },
    { major = "18", version = "18.1.8", release = "llvm-18.1.8-2", base = "ubuntu:noble" },
    { major = "17", version = "17.0.6", release = "llvm-17.0.6-3", base = "ubuntu:noble" },
    { major = "16", version = "16.0.6", release = "llvm-16.0.6-2", base = "ubuntu:noble" },
    { major = "15", version = "15.0.7", release = "llvm-15.0.7-2", base = "ubuntu:noble" },
    { major = "14", version = "14.0.6", release = "llvm-14.0.6-2", base = "ubuntu:noble" },
    { major = "13", version = "13.0.1", release = "llvm-13.0.1-2", base = "ubuntu:22.04" },
    { major = "12", version = "12.0.1", release = "llvm-12.0.1-3", base = "ubuntu:22.04" },
  ]
}

# ---- targets ----
# Every release above in one image, as clang-format-<major> and
# clang-tidy-<major>. The base is the one of the oldest release: an old clang
# cannot parse the C++ standard library of a new distribution, while a new
# clang can parse an old one.
target "all" {
  dockerfile = "Dockerfile.all"
  context = "."
  args = {
    BASE_IMAGE = "ubuntu:22.04"
    RELEASES = join(" ", [for r in RELEASES : "${r.major}=${r.version}=${r.release}"])
  }
  tags = [
    "${DOCKER_REPO}:all",
    "${GITHUB_REPO}:all"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=image"]
}

target "clang-tools" {
  matrix = {
    item = RELEASES
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
  tags = concat(
    [
      "${DOCKER_REPO}:${item.major}",
      "${DOCKER_REPO}:${item.version}",
      "${GITHUB_REPO}:${item.major}",
      "${GITHUB_REPO}:${item.version}",
    ],
    item.major == LATEST ? ["${DOCKER_REPO}:latest", "${GITHUB_REPO}:latest"] : [],
  )
  platforms = ["linux/amd64", "linux/arm64"]
  output = ["type=image"]
}

# Tags 7 to 11 and 16-alpine to 22-alpine are no longer built; the images
# already published stay in the registries. See README.md.

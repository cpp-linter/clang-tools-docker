# ---- groups ----
group "clang-tools" {
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
target "clang-tools" {
  matrix = {
    tgt = ["all", "16", "15", "14", "13", "12", "12-alpine", "11", "11-alpine", "10", "9", "8", "7", "6"]
  }
  name = "clang-tools-${tgt}"
  dockerfile = "${tgt}/Dockerfile"
  context = "."
  tags = [
    "${DOCKER_REPO}:${tgt}",
    "${GITHUB_REPO}:${tgt}"
  ]
  platforms = ["linux/amd64"]
}

# clang-tools-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/xianpengshen/clang-tools)](https://hub.docker.com/r/xianpengshen/clang-tools)
[![Docker Image Size](https://img.shields.io/docker/image-size/xianpengshen/clang-tools/22)](https://hub.docker.com/r/xianpengshen/clang-tools/tags)
[![Docker Scout](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/docker-scout.yml/badge.svg)](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/docker-scout.yml)
[![ci](https://img.shields.io/github/actions/workflow/status/cpp-linter/clang-tools-docker/CI.yml?branch=main&label=ci&labelColor=454a63)](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/CI.yml)
[![part of cpp-linter](https://img.shields.io/badge/part%20of-cpp--linter-ffc20a?labelColor=454a63)](https://cpp-linter.github.io/)

Docker images with clang-format, clang-tidy and the other clang tools, tagged by LLVM version. LLVM 12 and later come from the [cpp-linter static binaries](https://github.com/cpp-linter/clang-tools-static-binaries), so every image of a version carries exactly the same release.

[Website](https://cpp-linter.github.io/) · [GitHub Packages](https://github.com/cpp-linter/clang-tools-docker/pkgs/container/clang-tools) · [Docker Hub](https://hub.docker.com/r/xianpengshen/clang-tools) · [Get started](https://cpp-linter.github.io/getting-started/#just-the-clang-tools) · [Discussions](https://github.com/orgs/cpp-linter/discussions)

## Quick start

```bash
docker pull ghcr.io/cpp-linter/clang-tools:21
docker run --rm -v "$PWD":/src ghcr.io/cpp-linter/clang-tools:21 clang-format --dry-run --Werror /src/main.cpp
```

## Registries

Every image is pushed to two registries, with the same digest, and both copies are signed:

* `ghcr.io/cpp-linter/clang-tools` on [GitHub Packages](https://github.com/cpp-linter/clang-tools-docker/pkgs/container/clang-tools) is the recommended address. It belongs to the cpp-linter organization and is not subject to Docker Hub's pull rate limits.
* `xianpengshen/clang-tools` on [Docker Hub](https://hub.docker.com/r/xianpengshen/clang-tools) keeps receiving every image, so pipelines that already use it do not need to change.

## Usage

### Docker run image

```bash
# Check clang-format version
$ docker run ghcr.io/cpp-linter/clang-tools:19 clang-format --version
clang-format version 19.1.7
# Format code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src ghcr.io/cpp-linter/clang-tools:19 clang-format -i helloworld.c

# Check clang-tidy version
$ docker run ghcr.io/cpp-linter/clang-tools:19 clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 19.1.7
  Optimized build.

# Diagnostic code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src ghcr.io/cpp-linter/clang-tools:19 clang-tidy helloworld.c \
'-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*'
```

### As base image in a Dockerfile

[`demo/Dockerfile`](https://github.com/cpp-linter/clang-tools-docker/blob/main/demo/Dockerfile):

```Dockerfile
FROM ghcr.io/cpp-linter/clang-tools:17

WORKDIR /src

COPY . .

CMD [ "" ]
```

Then build and run the Docker image:

```bash
$ docker build -t clang-tools .

# Check clang-format version
$ docker run clang-tools clang-format --version
clang-format version 17.0.6
# Format code
$ docker run clang-tools clang-format -i helloworld.c

# Check clang-tidy version
$ docker run clang-tools clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 17.0.6
  Optimized build.
# Diagnostic code
$ docker run clang-tools clang-tidy helloworld.c \
'-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*'
```

## Supported tags and Dockerfile links

All images listed here support `linux/amd64` and `linux/arm64` platforms.

Each tag below exists in both registries (see [Registries](https://github.com/cpp-linter/clang-tools-docker#registries)).

* [`all`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile.all) (versions `21`, `20`, `19`, `18`, `17`, `16`, `15`, `14`, `13`, `12`, `11`, `10`, `9` from Ubuntu's packages; run them as `clang-format-21`, `clang-tidy-21` and so on)
* [`23`, `23.1.4`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`22`, `22.1.8`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`21`, `21.1.8`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`20`, `20.1.8`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`19`, `19.1.7`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`18`, `18.1.8`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`17`, `17.0.6`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`16`, `16.0.6`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`15`, `15.0.7`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`14`, `14.0.6`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`13`, `13.0.1`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`12`, `12.0.1`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)

A major-version tag such as `22` moves to each new patch release; a full-version tag such as `22.1.8` always carries that LLVM release. Every tag is rebuilt each week to pick up the base image's security updates, so pin a digest if you need a byte-for-byte identical image.

### Tags no longer updated

These tags stay in both registries and can still be pulled, but they are no longer rebuilt and get no security updates:

* `11`, `10`, `9`, `8`, `7` (Ubuntu's `clang-format-N` and `clang-tidy-N` packages; 7 to 10 on Ubuntu 20.04, which has reached end of standard support).
* `16-alpine` to `22-alpine`: all seven carry clang-format and clang-tidy 16.0.6 from Alpine 3.18, whatever the number in the tag.

Use a tag from the list above instead, such as `22` in place of `22-alpine`.

### What is in the images

Tags `12` to `23` (Ubuntu 22.04 for 12 and 13, Ubuntu 24.04 for 14 to 18, Ubuntu 26.04 for 19 and later) contain:

* `clang-format`, `clang-tidy`, `clang-apply-replacements`, `clang-query`, `clang-scan-deps` and, from LLVM 18, `clang-include-cleaner`, each also as `<tool>-<major>` (for example `clang-tidy-22`);
* clang's builtin headers, plus the C and C++ standard library headers (`libc6-dev` and the distribution's default `libstdc++-dev`), so clang-tidy can parse code;
* `run-clang-tidy`, `clang-tidy-diff-<major>.py`, `clang-format-diff-<major>` and `git-clang-format` from the same LLVM release, with Python 3 to run them.

They do not contain the clang compiler or git. The `all` tag still installs Ubuntu's `clang-format-N` and `clang-tidy-N` packages.

## Supply chain security

All images are signed with [cosign](https://github.com/sigstore/cosign) (keyless, via GitHub Actions OIDC) and come with an [SBOM](https://www.cisa.gov/sbom) (Software Bill of Materials, SPDX format) generated by [Syft](https://github.com/anchore/syft). They also carry a [SLSA provenance](https://docs.docker.com/build/metadata/attestations/slsa-provenance/) attestation from the build.

### Verify image signature

```bash
cosign verify \
  --certificate-identity-regexp 'https://github.com/cpp-linter/clang-tools-docker/.github/workflows/CI.yml@refs/heads/main' \
  --certificate-oidc-issuer 'https://token.actions.githubusercontent.com' \
  ghcr.io/cpp-linter/clang-tools:22
```

### Download SBOM and provenance

```bash
docker buildx imagetools inspect ghcr.io/cpp-linter/clang-tools:22 --format '{{ json .SBOM }}'
docker buildx imagetools inspect ghcr.io/cpp-linter/clang-tools:22 --format '{{ json .Provenance }}'
```

## Contributing

See the [contributing guide](https://github.com/cpp-linter/clang-tools-docker/blob/main/CONTRIBUTING.md) and [open an issue](https://github.com/cpp-linter/clang-tools-docker/issues) for bugs and feature requests.

## License

This project is licensed under the [Apache License 2.0 with LLVM Exceptions](https://github.com/cpp-linter/clang-tools-docker/blob/main/LICENSE).

# clang-tools-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/xianpengshen/clang-tools)](https://hub.docker.com/r/xianpengshen/clang-tools)
[![Docker Image Size](https://img.shields.io/docker/image-size/xianpengshen/clang-tools/22)](https://hub.docker.com/r/xianpengshen/clang-tools/tags)
[![Docker Scout](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/docker-scout.yml/badge.svg)](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/docker-scout.yml)
[![ci](https://img.shields.io/github/actions/workflow/status/cpp-linter/clang-tools-docker/CI.yml?branch=main&label=ci&labelColor=454a63)](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/CI.yml)
[![part of cpp-linter](https://img.shields.io/badge/part%20of-cpp--linter-ffc20a?labelColor=454a63)](https://cpp-linter.github.io/)

Docker images with Ubuntu's clang-format and clang-tidy packages, tagged by LLVM major version.

[Website](https://cpp-linter.github.io/) · [Docker Hub](https://hub.docker.com/r/xianpengshen/clang-tools) · [Get started](https://cpp-linter.github.io/getting-started/#just-the-clang-tools) · [Discussions](https://github.com/orgs/cpp-linter/discussions)

## Quick start

```bash
docker pull xianpengshen/clang-tools:21
docker run --rm -v "$PWD":/src xianpengshen/clang-tools:21 clang-format --dry-run --Werror /src/main.cpp
```

## Usage

### Docker run image

```bash
# Check clang-format version
$ docker run xianpengshen/clang-tools:19 clang-format --version
Ubuntu clang-format version 19.1.7 (3ubuntu1)
# Format code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src xianpengshen/clang-tools:19 clang-format -i helloworld.c

# Check clang-tidy version
$ docker run xianpengshen/clang-tools:19 clang-tidy --version
Ubuntu LLVM version 19.1.7
  Optimized build.

# Diagnostic code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src xianpengshen/clang-tools:19 clang-tidy helloworld.c \
'-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*'
```

### As base image in a Dockerfile

[`demo/Dockerfile`](https://github.com/cpp-linter/clang-tools-docker/blob/main/demo/Dockerfile):

```Dockerfile
FROM xianpengshen/clang-tools:17

WORKDIR /src

COPY . .

CMD [ "" ]
```

Then build and run the Docker image:

```bash
$ docker build -t clang-tools .

# Check clang-format version
$ docker run clang-tools clang-format --version
Ubuntu clang-format version 17.0.6 (9ubuntu1)
# Format code
$ docker run clang-tools clang-format -i helloworld.c

# Check clang-tidy version
$ docker run clang-tools clang-tidy --version
Ubuntu LLVM version 17.0.6
  Optimized build.
# Diagnostic code
$ docker run clang-tools clang-tidy helloworld.c \
'-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*'
```

## Supported tags and Dockerfile links

All images listed here support `linux/amd64` and `linux/arm64` platforms.

You can access all available Clang Tools Docker images via [Docker Hub registry](https://hub.docker.com/r/xianpengshen/clang-tools) or [GitHub Packages registry](https://github.com/cpp-linter/clang-tools-docker/pkgs/container/clang-tools).

* [`all`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile.all) (versions `21`, `20`, `19`, `18`, `17`, `16`, `15`, `14`, `13`, `12`, `11`, `10`, `9`; run them as `clang-format-21`, `clang-tidy-21` and so on)
* [`22`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`21`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`20`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`19`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`18`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`17`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`16`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`15`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`14`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`13`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`12`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`11`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`10`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`9`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`8`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`7`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile)
* [`16-alpine` to `22-alpine`](https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile.alpine): all seven carry clang-format and clang-tidy 16.0.6 from Alpine 3.18, whatever the number in the tag. For any other version, use the tag without `-alpine`.

## Supply chain security

All images are signed with [cosign](https://github.com/sigstore/cosign) (keyless, via GitHub Actions OIDC) and come with an [SBOM](https://www.cisa.gov/sbom) (Software Bill of Materials, SPDX format) generated by [Syft](https://github.com/anchore/syft). They also carry a [SLSA provenance](https://docs.docker.com/build/metadata/attestations/slsa-provenance/) attestation from the build.

### Verify image signature

```bash
cosign verify \
  --certificate-identity-regexp 'https://github.com/cpp-linter/clang-tools-docker/.github/workflows/CI.yml@refs/heads/main' \
  --certificate-oidc-issuer 'https://token.actions.githubusercontent.com' \
  xianpengshen/clang-tools:22
```

### Download SBOM and provenance

```bash
docker buildx imagetools inspect xianpengshen/clang-tools:22 --format '{{ json .SBOM }}'
docker buildx imagetools inspect xianpengshen/clang-tools:22 --format '{{ json .Provenance }}'
```

## Contributing

See the [contributing guide](https://github.com/cpp-linter/clang-tools-docker/blob/main/CONTRIBUTING.md) and [open an issue](https://github.com/cpp-linter/clang-tools-docker/issues) for bugs and feature requests.

## License

This project is licensed under the [Apache License 2.0 with LLVM Exceptions](https://github.com/cpp-linter/clang-tools-docker/blob/main/LICENSE).

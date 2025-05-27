# Clang Tools Docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/xianpengshen/clang-tools)](https://hub.docker.com/r/xianpengshen/clang-tools)
[![GitHub Repo](https://img.shields.io/badge/GitHub%20Repo-URL-blue?logo=github)](https://github.com/cpp-linter/clang-tools-docker)
![Maintenance](https://img.shields.io/maintenance/yes/2025)
[![CI](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/CI.yml/badge.svg)](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/CI.yml)
[![Snyk Container](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/snyk-container-analysis.yml/badge.svg)](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/snyk-container-analysis.yml)

🐳 **Clang Tools Docker Image**: This Docker image comes pre-installed with essential clang tools, including `clang-format` and `clang-tidy`.

You can access all available  Clang Tools Docker images via [Docker Hub registry](https://hub.docker.com/r/xianpengshen/clang-tools) or [GitHub Packages registry](https://github.com/cpp-linter/clang-tools-docker/pkgs/container/clang-tools).

## Supported Tags and Dockerfile links

* [`all`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile.all) (Supports versions of clang-tools includes `20`, `19`, `18`, `17`, `16`, `15`, `14`, `13`, `12`, `11`, `10`, `9`)
* [`20`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`19`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`18`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`17`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`16`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`16-alpine`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile.alpine)
* [`15`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`14`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`13`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`12`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`11`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`10`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`9`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`8`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)
* [`7`](https://github.com/cpp-linter/clang-tools-docker/blob/master/Dockerfile)

## How to use clang-tools Docker images

### Docker run image

```bash
# Check clang-format version
$ docker run xianpengshen/clang-tools:19 clang-format --version
Ubuntu clang-format version 19.1.0 (1ubuntu1)
# Format code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src xianpengshen/clang-tools:19 clang-format --dry-run -i helloworld.c

# Check clang-tidy version
$ docker run xianpengshen/clang-tools:19 clang-tidy --version
Ubuntu LLVM version 19.1.0
  Optimized build.

# Diagnostic code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src xianpengshen/clang-tools:19 clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

### As base image in [`Dockerfile`](https://github.com/cpp-linter/clang-tools-docker/blob/master/demo/Dockerfile)

```Dockerfile
FROM xianpengshen/clang-tools:19

WORKDIR /src

COPY . .

CMD [ "" ]
```

Then build and run the Docker image:

```bash
$ docker build -t clang-tools .

# Check clang-format version
$ docker run clang-tools clang-format --version
Ubuntu clang-format version 17.0.2 (1~exp1ubuntu2.1)
# Format code
$ docker run clang-tools clang-format --dry-run -i helloworld.c

# Check clang-tidy version
$ docker run clang-tools clang-tidy --version
Ubuntu LLVM version 19.1.0
  Optimized build.
# Diagnostic code
$ docker run clang-tools clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

## Have question or feedback?

To provide feedback (requesting a feature or reporting a bug) please post to [issues](https://github.com/cpp-linter/clang-tools-docker/issues).

## License

[Apache License](https://github.com/cpp-linter/clang-tools-docker/blob/master/LICENSE)

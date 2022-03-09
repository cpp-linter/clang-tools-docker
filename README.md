# `xianpengshen/clang-tools`

![Docker Pulls](https://img.shields.io/docker/pulls/xianpengshen/clang-tools)
![Maintenance](https://img.shields.io/maintenance/yes/2022)
[![Snyk Container](https://github.com/shenxianpeng/clang-tools/actions/workflows/snyk-container-analysis.yml/badge.svg)](https://github.com/shenxianpeng/clang-tools/actions/workflows/snyk-container-analysis.yml)

🐳 [`xianpengshen/clang-tools`](https://hub.docker.com/repository/docker/xianpengshen/clang-tools) Docker image includes the clang-format and clang-tidy tools.

## Supported tags
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/all)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/13)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/12-alpine-edge)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/12)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/11-alpine-3.14)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/11)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/10)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/9)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/8)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/7)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/6)

* [clang-tools:all](https://github.com/shenxianpeng/clang-tools/blob/master/all/Dockerfile) (supports all versions of the below tags)
* [clang-tools:13](https://github.com/shenxianpeng/clang-tools/blob/master/13/Dockerfile)
* [clang-tools:12-alpine-edge](https://github.com/shenxianpeng/clang-tools/blob/master/12/alpine-edge/Dockerfile)
* [clang-tools:12](https://github.com/shenxianpeng/clang-tools/blob/master/12/Dockerfile)
* [clang-tools:11-alpine-3.14](https://github.com/shenxianpeng/clang-tools/blob/master/11/alpine-3.14/Dockerfile)
* [clang-tools:11](https://github.com/shenxianpeng/clang-tools/blob/master/11/Dockerfile)
* [clang-tools:10](https://github.com/shenxianpeng/clang-tools/blob/master/10/Dockerfile)
* [clang-tools:9](https://github.com/shenxianpeng/clang-tools/blob/master/9/Dockerfile)
* [clang-tools:8](https://github.com/shenxianpeng/clang-tools/blob/master/8/Dockerfile)
* [clang-tools:7](https://github.com/shenxianpeng/clang-tools/blob/master/7/Dockerfile)
* [clang-tools:6](https://github.com/shenxianpeng/clang-tools/blob/master/6/Dockerfile)

## How to use this image

### Run the following command directly

```bash
# Check clang-format version
$ docker run xianpengshen/clang-tools:12 clang-format --version
Ubuntu clang-format version 12.0.0-3ubuntu1~20.04.4
# Format code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src xianpengshen/clang-tools:12 clang-format --dry-run -i helloworld.c

# Check clang-tidy version
$ docker run xianpengshen/clang-tools:12 clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 12.0.0
  
  Optimized build.
  Default target: x86_64-pc-linux-gnu
  Host CPU: cascadelake
# Diagnostic code (helloworld.c in the demo directory)
$ docker run -v $PWD:/src xianpengshen/clang-tools:12 clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

### Or refer the image in [`Dockerfile`](https://github.com/shenxianpeng/clang-tools/blob/master/demo/Dockerfile)

You can also use this image [`xianpengshen/clang-tools`](https://hub.docker.com/repository/docker/xianpengshen/clang-tools) in `Dockerfile` as below.

```Dockerfile
FROM xianpengshen/clang-tools:12

WORKDIR /src

COPY . .

CMD [ "" ]
```

Then build and run the Docker image:

```bash
$ docker build -t clang-tools .

# Check clang-format version
$ docker run clang-tools clang-format --version
Ubuntu clang-format version 12.0.0-3ubuntu1~20.04.3
# Format code
$ docker run clang-tools clang-format --dry-run -i helloworld.c

# Check clang-tidy version
$ docker run clang-tools clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 12.0.0
# Diagnostic code
$ docker run clang-tools clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

### Specific version in `Dockerfile` 

If you want to use a specific version of clang-tools, you can build the Dockerfile by passing `--build-arg`

```Dockerfile
ARG TAG=12
FROM xianpengshen/clang-tools:$TAG

WORKDIR /src

COPY . .

CMD [ "" ]
```

```bash
$ docker build -t mylinter --build-arg TAG=11 .
Sending build context to Docker daemon    148kB
Step 1/13 : ARG TAG=latest
Step 2/13 : FROM xianpengshen/clang-tools:$TAG
11: Pulling from xianpengshen/clang-tools
Status: Downloaded newer image for xianpengshen/clang-tools:11
```

## Have question or feedback?

To provide feedback (requesting a feature or reporting a bug) please post to [issues](https://github.com/shenxianpeng/clang-tools/issues).

## License

[Apache License](https://github.com/shenxianpeng/clang-tools/blob/master/LICENSE)

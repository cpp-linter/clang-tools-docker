# `xianpengshen/clang-tools`

![GitHub](https://img.shields.io/github/license/shenxianpeng/clang-tools)
![Docker Pulls](https://img.shields.io/docker/pulls/xianpengshen/clang-tools)

🐳 Docker image [`xianpengshen/clang-tools`](https://hub.docker.com/repository/docker/xianpengshen/clang-tools) includes clang-format and clang-tidy.

## Supported tags
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/all)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/latest)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/11)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/10)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/9)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/8)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/7)
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xianpengshen/clang-tools/6)


* [clang-tools:all](https://github.com/shenxianpeng/clang-tools/blob/master/all/Dockerfile) (supports all versions of the below tags)
* [clang-tools:latest](https://github.com/shenxianpeng/clang-tools/blob/master/12/Dockerfile) (v12)
* [clang-tools:11](https://github.com/shenxianpeng/clang-tools/blob/master/11/Dockerfile)
* [clang-tools:10](https://github.com/shenxianpeng/clang-tools/blob/master/10/Dockerfile)
* [clang-tools:9](https://github.com/shenxianpeng/clang-tools/blob/master/9/Dockerfile)
* [clang-tools:8](https://github.com/shenxianpeng/clang-tools/blob/master/8/Dockerfile)
* [clang-tools:7](https://github.com/shenxianpeng/clang-tools/blob/master/7/Dockerfile)
* [clang-tools:6](https://github.com/shenxianpeng/clang-tools/blob/master/6/Dockerfile)

## How to use this image

### Create a `Dockerfile` in your project

```Dockerfile
FROM xianpengshen/clang-tools

WORKDIR /usr/src/app

COPY . .

CMD [ "" ]
```

You can then build and run the Docker image:

```bash
$ docker build -t clang-tools .

# check clang-format version
$ docker run clang-tools clang-format --version
Ubuntu clang-format version 12.0.0-3ubuntu1~20.04.3
# formatting code
$ docker run clang-tools clang-format -i helloworld.c

# check clang-tidy version
$ docker run clang-tools clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 12.0.0
# diagnosing code
$ docker run clang-tools clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

### Run with a single c/c++ code

If a simple source code, you may find it inconvenient to write a complete `Dockerfile`. In such cases, you can run by using the Docker image directly.

```bash
docker run -v $PWD:/src xianpengshen/clang-tools clang-format -i helloworld.c
docker run -v $PWD:/src xianpengshen/clang-tools clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

### Run `Dockerfile` with specific verion

If you want to provide dynamic versions of clang-tools

```Dockerfile
ARG TAG=latest
FROM xianpengshen/clang-tools:$TAG

WORKDIR /usr/src/app

COPY . .

CMD [ "" ]
```

Use the latest verion of clang-tools.

```bash
$ docker build -t mylinter .
Sending build context to Docker daemon  157.7kB
Step 1/13 : ARG TAG=latest
Step 2/13 : FROM xianpengshen/clang-tools:$TAG
latest: Pulling from xianpengshen/clang-tools
Status: Downloaded newer image for xianpengshen/clang-tools:latest
```

Use specific version of clang-tools by passing `--build-arg`

```bash
$ docker build -t mylinter --build-arg TAG=11 .
Sending build context to Docker daemon    148kB
Step 1/13 : ARG TAG=latest
Step 2/13 : FROM xianpengshen/clang-tools:$TAG
11: Pulling from xianpengshen/clang-tools
Status: Downloaded newer image for xianpengshen/clang-tools:11
```
## Have question or feedback?

To provide feedback (requesting a feature or reporting a bug) please post to [issues](https://github.com/shenxianpeng/clang-tools/issues)

# `xianpengshen/clang-tools`

`xianpengshen/clang-tools` Docker image includes clang-format and clang-tidy.

## Supported tags

* [clang-tools:11](https://github.com/shenxianpeng/clang-tools/blob/master/11/Dockerfile)
* [clang-tools:10](https://github.com/shenxianpeng/clang-tools/blob/master/10/Dockerfile)
* [clang-tools:9](https://github.com/shenxianpeng/clang-tools/blob/master/9/Dockerfile)
* [clang-tools:8](https://github.com/shenxianpeng/clang-tools/blob/master/8/Dockerfile)
* [clang-tools:7](https://github.com/shenxianpeng/clang-tools/blob/master/7/Dockerfile)
* [clang-tools:6](https://github.com/shenxianpeng/clang-tools/blob/master/6/Dockerfile)

## How to use this image

### Getting started

Git clone this repository then just run as bellow:

```bash
docker run -v $PWD:/src xianpengshen/clang-tools:11 clang-format -i helloworld.c
docker run -v $PWD:/src xianpengshen/clang-tools:11 clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

### Output version

```bash
$ docker run xianpengshen/clang-tools:11 clang-format --version
Ubuntu clang-format version 11.0.0-2~ubuntu20.04.1

$ docker run xianpengshen/clang-tools:11 clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 11.0.0
  
  Optimized build.
  Default target: x86_64-pc-linux-gnu
  Host CPU: cascadelake
```

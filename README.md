# xianpengshen/clang-tools

xianpengshen/clang-tools Docker image includes clang-format and clang-tidy. 

## Output tools version

```bash
sh-4.2$ docker run xianpengshen/clang-tools clang-format --version
clang-format version 10.0.0-4ubuntu1

sh-4.2$ docker run xianpengshen/clang-tools clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 10.0.0

  Optimized build.
  Default target: x86_64-pc-linux-gnu
  Host CPU: sandybridge
```

## Getting started

Git clone this repository then just run as bellow:

```bash
docker run -v $PWD:/src xianpengshen/clang-tools clang-format -i helloworld.c
docker run -v $PWD:/src xianpengshen/clang-tools clang-tidy helloworld.c \
-checks=boost-*,bugprone-*,performance-*,readability-*,portability-*,modernize-*,clang-analyzer-cplusplus-*,clang-analyzer-*,cppcoreguidelines-*
```

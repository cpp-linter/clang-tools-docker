# clang-tool

This Docker image can let you check your code format with clang-format. 

## Output tools version

```bash
sh-4.2$ docker run xianpengshen/clang-tool clang-format --version
clang-format version 10.0.0-4ubuntu1

sh-4.2$ docker run xianpengshen/clang-tool clang-tidy --version
LLVM (http://llvm.org/):
  LLVM version 10.0.0

  Optimized build.
  Default target: x86_64-pc-linux-gnu
  Host CPU: sandybridge
```

## Getting started

Go to your source code directory, then just run as bellow:

```bash
docker run -v $PWD:/src xianpengshen/clang-tool clang-format helloworld.c
docker run -v $PWD:/src xianpengshen/clang-tool clang-tidy helloworld.c
```

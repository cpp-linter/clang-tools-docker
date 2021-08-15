# clang-checker

This Docker image can let you check your code format with clang-format. 

## Getting started

`cd` to your source code directory, then just run 

```bash
docker run -v $PWD:/src xianpengshen/clang-checker clang-format helloworld.c
docker run -v $PWD:/src xianpengshen/clang-checker clang-tidy helloworld.c
```

FROM ubuntu:20.04

ENV PACKAGE="clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04"

ADD https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/$PACKAGE.tar.xz /tmp

WORKDIR /tmp

RUN apt-get update && apt-get install xz-utils   \
    && tar -xvf $PACKAGE.tar.xz \
    && cp $PACKAGE/bin/clang-format /usr/bin/clang-format \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && cp $PACKAGE/bin/clang-tidy /usr/bin/clang-tidy \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf $PACKAGE $PACKAGE.tar.xz

WORKDIR /src

CMD [""]

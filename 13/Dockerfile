FROM ubuntu:20.04

ENV PACKAGE="clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04"
ENV PACKAGE_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/${PACKAGE}.tar.xz"

WORKDIR /tmp

RUN apt-get update \
    && apt-get install --no-install-recommends -y xz-utils \
    && apt-get install -y wget  \
    && wget --no-verbose $PACKAGE_URL \
    && tar -xvf $PACKAGE.tar.xz \
    && cp $PACKAGE/lib/clang/13.0.0/include/stddef.h /usr/include/ \
    && cp $PACKAGE/lib/clang/13.0.0/include/stdarg.h /usr/include/ \
    && cp $PACKAGE/bin/clang-format /usr/bin/clang-format \
    && cp $PACKAGE/bin/clang-tidy /usr/bin/clang-tidy \
    && rm -rf $PACKAGE $PACKAGE.tar.xz \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD [""]

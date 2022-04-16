FROM ubuntu:18.04

ENV PACKAGE="clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04"
ENV PACKAGE_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/${PACKAGE}.tar.xz"

WORKDIR /tmp

RUN apt-get update \
    && apt-get install -y xz-utils wget  \
    && wget --no-verbose ${PACKAGE_URL} \
    && tar -xvf $PACKAGE.tar.xz --no-same-owner \
    && rm -rf $PACKAGE.tar.xz \
    && mv $PACKAGE /usr/lib/llvm-14
    && cp /usr/lib/llvm-14/bin/clang-format /usr/bin/clang-format \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && cp /usr/lib/llvm-14/bin/clang-tidy /usr/bin/clang-tidy \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD [""]

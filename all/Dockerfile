FROM ubuntu:20.04

ARG DEFAULT_VERSION=12
ENV VERSIONS="12 11 10 9 8"
ENV CLANG13="clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04"
ENV CLANG13_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/${CLANG13}.tar.xz"
ENV CLANG14="clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04"
ENV CLANG14_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/${CLANG14}.tar.xz"

RUN apt-get update \
    && for VERSION in ${VERSIONS}; do \
        apt-get --no-install-recommends -y install clang-format-$VERSION clang-tidy-$VERSION; done \
    && apt-get install --no-install-recommends -y xz-utils \
    && apt-get install -y wget \
    && wget --no-verbose $CLANG13_URL \
    && tar -xvf $CLANG13.tar.xz \
    && rm -rf $CLANG13.tar.xz \
    && cp $CLANG13/bin/clang-format /usr/bin/clang-format-13 \
    && cp $CLANG13/bin/clang-tidy /usr/bin/clang-tidy-13 \
    && cp $CLANG13/lib/clang/13.0.0/include/stddef.h /usr/include/ \
    && cp $CLANG13/lib/clang/13.0.0/include/stdarg.h /usr/include/ \
    && wget --no-verbose $CLANG14_URL \
    && tar -xvf $CLANG14.tar.xz --no-same-owner \
    && rm -rf $CLANG14.tar.xz \
    && cp $CLANG14/bin/clang-format /usr/bin/clang-format-14 \
    && cp $CLANG14/bin/clang-tidy /usr/bin/clang-tidy-14 \
    && rm -rf $CLANG13 $CLANG14 \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/clang-format-$DEFAULT_VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$DEFAULT_VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version

WORKDIR /src

CMD [""]

FROM ubuntu:20.04

ENV CLANG_VERSIONS="12 11 10 9 8"

LABEL org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools"

RUN apt-get update \
    && for CLANG_VERSION in "$CLANG_VERSIONS"; do \
        apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION; done \
    && rm -rf /var/lib/apt/lists/* 


ENV CLANG_VERSIONS="14 13"

# clang 13, 14 packages exist in jammy
COPY sources.list.jammy /etc/apt/sources.list

RUN apt-get update \
    && for CLANG_VERSION in "$CLANG_VERSIONS"; do \
        apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION; done \
    && mv /etc/apt/sources.list.focal /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/*

ENV CLANG_VERSIONS="16 15"

WORKDIR /tmp

RUN apt-get update \
    && apt-get --no-install-recommends -y install lsb-release wget software-properties-common gnupg \
    && wget --quiet https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && for CLANG_VERSION in "$CLANG_VERSIONS"; do \
        ./llvm.sh $CLANG_VERSION \
        apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION; done \
    && rm llvm.sh \
    && rm -rf /var/lib/apt/lists/* 

# Check versions

ENV CLANG_VERSIONS="16 15 14 13 12 11 10 9 8"
RUN for VERSION in "$CLANG_VERSIONS"; do \
    clang-format-$VERSION --version \
    clang-tidy-$VERSION --version; done

WORKDIR /src

CMD [""]

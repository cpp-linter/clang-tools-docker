FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools-docker"
LABEL org.opencontainers.image.description="The Clang Tools Docker image includes the clang-format and clang-tidy."
LABEL org.opencontainers.image.licenses="MIT"

ENV CLANG_VERSIONS="12 11 10 9 8"

RUN set -ex \
    && apt-get update \
    && for CLANG_VERSION in $CLANG_VERSIONS; do \
        apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION; done \
    && rm -rf /var/lib/apt/lists/*


ENV CLANG_VERSIONS="16 15 14 13"

WORKDIR /tmp

RUN set -ex \
    && apt-get update \
    && apt-get --no-install-recommends -y install lsb-release wget software-properties-common gnupg \
    && wget --quiet https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && for CLANG_VERSION in $CLANG_VERSIONS; do \
        ./llvm.sh $CLANG_VERSION \
        && apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION; done \
    && rm llvm.sh \
    && rm -rf /var/lib/apt/lists/*


# Integrity testing
ENV CLANG_VERSIONS="16 15 14 13 12 11 10 9 8"
RUN set -ex \
    && for VERSION in $CLANG_VERSIONS; do \
        clang-format-$VERSION --version \
        clang-tidy-$VERSION --version; done

WORKDIR /src

CMD [""]

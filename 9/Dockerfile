FROM ubuntu:20.04

ENV CLANG_VERSION 9

LABEL \
    org.opencontainers.image.vendor="cpp-linter team" \
    org.opencontainers.image.title="Unofficial Clang Tools Docker image" \
    org.opencontainers.image.description="The Clang Tools Docker image includes the clang-format and clang-tidy." \
    org.opencontainers.image.version="clang-tools:${CLANG_VERSION}" \
    org.opencontainers.image.url="https://hub.docker.com/r/xianpengshen/clang-tools" \
    org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools-docker" \
    org.opencontainers.image.licenses="MIT"

RUN apt-get update \
    && apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION \
    && ln -s /usr/bin/clang-format-$CLANG_VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$CLANG_VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD [""]

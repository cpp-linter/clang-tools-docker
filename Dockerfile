ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG CLANG_VERSION

LABEL \
    org.opencontainers.image.vendor="cpp-linter team" \
    org.opencontainers.image.title="Unofficial Clang Tools Docker image" \
    org.opencontainers.image.description="The Clang Tools Docker image includes the clang-format and clang-tidy." \
    org.opencontainers.image.version="clang-tools:${CLANG_VERSION}" \
    org.opencontainers.image.url="https://hub.docker.com/r/xianpengshen/clang-tools" \
    org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools-docker" \
    org.opencontainers.image.licenses="MIT"

WORKDIR /src

COPY install.sh install.sh

RUN apt-get update \
    && chmod +x install.sh \
    && ./install.sh "$CLANG_VERSION" \
    && rm -rf /var/lib/apt/lists/* \
    && rm install.sh

CMD [""]

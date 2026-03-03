ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG CLANG_VERSION
ARG USE_LLVM_REPO=false

LABEL \
    org.opencontainers.image.vendor="cpp-linter team" \
    org.opencontainers.image.title="Clang Tools Docker image" \
    org.opencontainers.image.description="The Clang Tools Docker image includes the clang-format and clang-tidy." \
    org.opencontainers.image.version="clang-tools:${CLANG_VERSION}" \
    org.opencontainers.image.url="https://hub.docker.com/r/xianpengshen/clang-tools" \
    org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools-docker" \
    org.opencontainers.image.licenses="MIT"

RUN set -e \
    && apt-get update \
    && if [ "$USE_LLVM_REPO" = "true" ]; then \
        apt-get --no-install-recommends -y install gnupg lsb-release software-properties-common wget \
        && wget --quiet https://apt.llvm.org/llvm.sh \
        && chmod +x llvm.sh \
        && ./llvm.sh $CLANG_VERSION \
        && rm llvm.sh; \
    fi \
    && apt-get --no-install-recommends -y install \
        clang-format-$CLANG_VERSION \
        clang-tidy-$CLANG_VERSION \
    && ln -s /usr/bin/clang-format-$CLANG_VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$CLANG_VERSION /usr/bin/clang-tidy \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Integrity testing
RUN set -e \
    && clang-format-$CLANG_VERSION --version | grep -E "clang-format version $CLANG_VERSION" \
    && clang-tidy-$CLANG_VERSION --version | grep "LLVM version $CLANG_VERSION"

WORKDIR /src

CMD [""]

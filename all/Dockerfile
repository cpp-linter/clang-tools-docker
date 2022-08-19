FROM ubuntu:20.04

ARG DEFAULT_VERSION=12

ENV CLANG_VERSIONS="12 11 10 9 8"

LABEL org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools"

RUN apt-get update \
    && for CLANG_VERSION in ${CLANG_VERSIONS}; do \
        apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION; done \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/clang-format-$DEFAULT_VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$DEFAULT_VERSION /usr/bin/clang-tidy \
    && mv /etc/apt/sources.list /etc/apt/sources.list.focal

ENV CLANG_VERSIONS="14 13"

# clang 13, 14 packages exist in jammy
COPY sources.list.jammy /etc/apt/sources.list

RUN apt-get update \
    && for CLANG_VERSION in ${CLANG_VERSIONS}; do \
        apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION; done \
    && mv /etc/apt/sources.list.focal /etc/apt/sources.list \
    && rm -rf /var/lib/apt/lists/* \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version

WORKDIR /src

CMD [""]

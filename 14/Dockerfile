FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools-docker"
LABEL org.opencontainers.image.description="The Clang Tools Docker image includes the clang-format and clang-tidy."
LABEL org.opencontainers.image.licenses="MIT"

ENV CLANG_VERSION 14

RUN mv /etc/apt/sources.list /etc/apt/sources.list.focal

COPY 14/sources.list.jammy /etc/apt/sources.list

RUN apt-get update \
    && apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION \
    && mv /etc/apt/sources.list.focal /etc/apt/sources.list \
    && ln -s /usr/bin/clang-format-$CLANG_VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$CLANG_VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD [""]

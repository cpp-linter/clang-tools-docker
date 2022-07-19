FROM ubuntu:20.04

ENV CLANG_VERSION 14

RUN mv /etc/apt/sources.list /etc/apt/sources.list.focal

COPY sources.list.jammy /etc/apt/sources.list

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

FROM ubuntu:20.04

ENV VERSION 14

RUN mv /etc/apt/sources.list /etc/apt/sources.list.focal

COPY sources.list.jammy /etc/apt/sources.list

RUN apt-get update \
    && apt-get --no-install-recommends -y install clang-format-$VERSION clang-tidy-$VERSION \
    && mv /etc/apt/sources.list.focal /etc/apt/sources.list \
    && ln -s /usr/bin/clang-format-$VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD [""]

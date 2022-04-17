FROM ubuntu:20.04

ENV VERSION 10

RUN apt-get update \
    && apt-get --no-install-recommends -y install clang-format-$VERSION clang-tidy-$VERSION \
    && ln -s /usr/bin/clang-format-$VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD [""]

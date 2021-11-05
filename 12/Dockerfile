FROM ubuntu:20.04

ENV VERSION 12

RUN tools="clang-format-$VERSION clang-tidy-$VERSION" \
    && apt-get update \
    && apt-get -y install $tools \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/clang-format-"$VERSION" /usr/bin/clang-format \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && ln -s /usr/bin/clang-tidy-"$VERSION" /usr/bin/clang-tidy \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version

WORKDIR /src

CMD [""]

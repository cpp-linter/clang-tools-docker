FROM ubuntu:jammy-20220404

ENV VERSION 13

RUN apt-get update \
    && apt-get --no-install-recommends -y install clang-format-$VERSION clang-tidy-$VERSION \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/clang-format-$VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version

WORKDIR /src

CMD [""]

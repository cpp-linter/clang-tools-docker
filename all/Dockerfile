FROM ubuntu:20.04

ARG DEFAULT_VERSION=12
ENV VERSION="12 11 10 9 8 7 6.0"

RUN apt-get update \
    && for i in ${VERSION}; do \
        tools="clang-format-$i clang-tidy-$i"; \
        apt-get -y install $tools; done \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/clang-format-$DEFAULT_VERSION /usr/bin/clang-format \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && ln -s /usr/bin/clang-tidy-$DEFAULT_VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \

WORKDIR /src

CMD [""]

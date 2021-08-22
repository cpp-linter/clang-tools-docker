FROM ubuntu:latest

ARG DEFAULT_VERSION=12
ENV VERSION="12 11 10 9 8 7 6.0"

RUN apt-get update \
    && for i in ${VERSION}; do \
        tools="clang-format-$i clang-tidy-$i"; \
        apt-get -y install $tools; done \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN ln -s /usr/bin/clang-format-$DEFAULT_VERSION /usr/bin/clang-format
RUN echo "--- Clang-format version ---"
RUN clang-format --version
RUN ln -s /usr/bin/clang-tidy-$DEFAULT_VERSION /usr/bin/clang-tidy
RUN echo "--- Clang-tidy version ---"
RUN clang-tidy --version

CMD [""]

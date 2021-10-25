FROM ubuntu:20.04

# version is 6
ENV VERSION 6.0

RUN tools="clang-format-$VERSION clang-tidy-$VERSION" \
    && apt-get update \
    && apt-get -y install $tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN ln -s /usr/bin/clang-format-"$VERSION" /usr/bin/clang-format
RUN echo "--- Clang-format version ---"
RUN clang-format --version
RUN ln -s /usr/bin/clang-tidy-"$VERSION" /usr/bin/clang-tidy
RUN echo "--- Clang-tidy version ---"
RUN clang-tidy --version

CMD [""]

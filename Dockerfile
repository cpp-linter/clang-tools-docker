FROM ubuntu:latest

RUN tools='clang-format clang-tidy' \
    && apt-get update \
    && apt-get -y install $tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN echo "--- Clang-format version ---"
RUN clang-format --version
RUN echo "--- Clang-tidy version ---"
RUN clang-tidy --version

CMD [""]


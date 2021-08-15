FROM ubuntu:latest

RUN apt-get update && apt-get -y install \
  clang-format \
  clang-tidy \
  clang

WORKDIR /build

RUN echo "--- Clang-format version ---"
RUN clang-format --version
RUN echo "--- Clang-tidy version ---"
RUN clang-tidy --version

ENTRYPOINT [""]

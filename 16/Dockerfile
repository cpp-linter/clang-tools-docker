FROM ubuntu:22.04

ENV CLANG_VERSION 16

WORKDIR /src

RUN apt-get update \
    && apt-get --no-install-recommends -y install lsb-release wget software-properties-common gnupg \
    && wget --quiet https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh $CLANG_VERSION && rm -rf llvm.sh \
    && apt-get --no-install-recommends -y install clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION \
    && ln -s /usr/bin/clang-format-$CLANG_VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$CLANG_VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

CMD [""]

FROM ubuntu:22.04

ENV CLANG_VERSION 16

RUN apt-get update \
    && apt-get --no-install-recommends -y wget curl \
    && wget --progress=dot:giga https://apt.llvm.org/llvm.sh -O llvm_install.sh \
    && chmod +x llvm_install.sh \
    && llvm_install.sh $CLANG_VERSION \
    && apt-get --no-install-recommends -y clang-format-$CLANG_VERSION clang-tidy-$CLANG_VERSION \
    && ln -s /usr/bin/clang-format-$CLANG_VERSION /usr/bin/clang-format \
    && ln -s /usr/bin/clang-tidy-$CLANG_VERSION /usr/bin/clang-tidy \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD [""]

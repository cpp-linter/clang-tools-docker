FROM alpine:3.15

LABEL org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools"
LABEL org.opencontainers.image.description="The Clang Tools Docker image includes the clang-format and clang-tidy."
LABEL org.opencontainers.image.licenses="MIT"

RUN apk update \
    && apk add --no-cache clang-extra-tools \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version

WORKDIR /src

CMD [""]

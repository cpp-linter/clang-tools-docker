FROM alpine:3.14

RUN apk update \
    && apk add --no-cache clang-extra-tools \
    && echo "--- Clang-format version ---" \
    && clang-format --version \
    && echo "--- Clang-tidy version ---" \
    && clang-tidy --version

WORKDIR /src

CMD [""]

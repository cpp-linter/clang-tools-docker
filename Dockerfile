# check=skip=InvalidDefaultArgInFrom
# Images for LLVM 12 and later, built from the cpp-linter static binaries:
# https://github.com/cpp-linter/clang-tools-static-binaries
# docker-bake.hcl sets every ARG below for each target, so they have no defaults.
ARG BASE_IMAGE

# ---- fetch: download and verify the binaries for the target platform ----
FROM --platform=$BUILDPLATFORM alpine:3.22 AS fetch
ARG LLVM_MAJOR
ARG LLVM_VERSION
ARG RELEASE_TAG
ARG TARGETARCH
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache curl
WORKDIR /dl
RUN base="https://github.com/cpp-linter/clang-tools-static-binaries/releases/download/${RELEASE_TAG}" \
    && curl --proto =https --tlsv1.2 -fsSL --retry 5 -O "$base/SHA512SUMS" \
    && tools="clang-format clang-tidy clang-apply-replacements clang-query clang-scan-deps" \
    && if [ "$LLVM_MAJOR" -ge 18 ]; then tools="$tools clang-include-cleaner"; fi \
    && files="clang-resource-headers-${LLVM_MAJOR}.tar.gz" \
    && for tool in $tools; do files="$files ${tool}-${LLVM_MAJOR}_linux-${TARGETARCH}"; done \
    && for f in $files; do curl --proto =https --tlsv1.2 -fsSL --retry 5 -O "$base/$f"; done \
    && for f in $files; do grep -E "  ${f}\$" SHA512SUMS; done > checksums \
    && [ "$(wc -l < checksums)" -eq "$(echo "$files" | wc -w)" ] \
    && sha512sum -c checksums \
    && prefix="/out/usr/lib/llvm-${LLVM_MAJOR}" \
    && mkdir -p "$prefix/bin" /out/usr/bin \
    && for tool in $tools; do \
        install -m 0755 "${tool}-${LLVM_MAJOR}_linux-${TARGETARCH}" "$prefix/bin/$tool"; \
        ln -s "../lib/llvm-${LLVM_MAJOR}/bin/$tool" "/out/usr/bin/${tool}-${LLVM_MAJOR}"; \
        ln -s "${tool}-${LLVM_MAJOR}" "/out/usr/bin/$tool"; \
    done \
    # The headers tarball unpacks to lib/clang/<version>/include, next to bin/.
    && tar -xzf "clang-resource-headers-${LLVM_MAJOR}.tar.gz" -C "$prefix"
# The Python helper scripts that Ubuntu's clang-tidy and clang-format packages ship,
# from the same LLVM release as the binaries.
RUN src="https://raw.githubusercontent.com/llvm/llvm-project/llvmorg-${LLVM_VERSION}" \
    && bin="/out/usr/lib/llvm-${LLVM_MAJOR}/bin" \
    && curl --proto =https --tlsv1.2 -fsSL --retry 5 -o "$bin/run-clang-tidy" "$src/clang-tools-extra/clang-tidy/tool/run-clang-tidy.py" \
    && curl --proto =https --tlsv1.2 -fsSL --retry 5 -o "$bin/clang-tidy-diff.py" "$src/clang-tools-extra/clang-tidy/tool/clang-tidy-diff.py" \
    && curl --proto =https --tlsv1.2 -fsSL --retry 5 -o "$bin/clang-format-diff.py" "$src/clang/tools/clang-format/clang-format-diff.py" \
    && curl --proto =https --tlsv1.2 -fsSL --retry 5 -o "$bin/git-clang-format" "$src/clang/tools/clang-format/git-clang-format" \
    && chmod 0755 "$bin/run-clang-tidy" "$bin/clang-tidy-diff.py" "$bin/clang-format-diff.py" "$bin/git-clang-format" \
    && ln -s "../lib/llvm-${LLVM_MAJOR}/bin/run-clang-tidy" "/out/usr/bin/run-clang-tidy-${LLVM_MAJOR}" \
    && ln -s "../lib/llvm-${LLVM_MAJOR}/bin/clang-tidy-diff.py" "/out/usr/bin/clang-tidy-diff-${LLVM_MAJOR}.py" \
    && ln -s "../lib/llvm-${LLVM_MAJOR}/bin/clang-format-diff.py" "/out/usr/bin/clang-format-diff-${LLVM_MAJOR}" \
    && ln -s "../lib/llvm-${LLVM_MAJOR}/bin/git-clang-format" "/out/usr/bin/git-clang-format-${LLVM_MAJOR}" \
    && ln -s "run-clang-tidy-${LLVM_MAJOR}" /out/usr/bin/run-clang-tidy \
    && ln -s "git-clang-format-${LLVM_MAJOR}" /out/usr/bin/git-clang-format

# ---- final image ----
FROM $BASE_IMAGE
ARG LLVM_MAJOR
ARG LLVM_VERSION
ARG RELEASE_TAG

LABEL \
    org.opencontainers.image.vendor="cpp-linter team" \
    org.opencontainers.image.title="Clang Tools Docker image" \
    org.opencontainers.image.description="The Clang Tools Docker image includes the clang-format and clang-tidy." \
    org.opencontainers.image.version="${LLVM_VERSION}" \
    org.opencontainers.image.url="https://github.com/cpp-linter/clang-tools-docker/pkgs/container/clang-tools" \
    org.opencontainers.image.source="https://github.com/cpp-linter/clang-tools-docker" \
    org.opencontainers.image.licenses="Apache-2.0 WITH LLVM-exception" \
    io.github.cpp-linter.static-binaries.release="${RELEASE_TAG}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# The C and C++ standard library headers clang-tidy needs to parse code (the
# libstdc++ of the distribution's default GCC), and Python for run-clang-tidy
# and the other helper scripts.
RUN apt-get update \
    && gcc_major="$(apt-cache show g++ | sed -n 's/^Depends:.* g++-\([0-9][0-9]*\).*/\1/p' | head -n 1)" \
    && [ -n "$gcc_major" ] \
    && apt-get --no-install-recommends -y install libc6-dev "libstdc++-${gcc_major}-dev" python3 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=fetch /out/ /

# Integrity testing: the right version, and clang-tidy finds both clang's
# builtin headers and the C++ standard library.
RUN clang-format --version | grep -F "clang-format version ${LLVM_VERSION}" \
    && clang-tidy --version | grep -F "LLVM version ${LLVM_VERSION}" \
    && printf '#include <stddef.h>\n#include <string>\nint main() { std::string s; return static_cast<int>(s.size() + sizeof(size_t)); }\n' > /tmp/check.cpp \
    && clang-tidy --checks='-*,bugprone-*' --warnings-as-errors='*' /tmp/check.cpp -- -std=c++17 \
    && rm /tmp/check.cpp

WORKDIR /src

CMD [""]

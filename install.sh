#!/bin/bash
set -e
set -x

CLANG_VERSION=$1
# clang-tools:17, clang-tools:16, etc.
TAG_VERSIONS="17 16 15 14 13 12 11 10 9 8 7"
# clang-tools:all, all includes following versions.
TAG_ALL_VERSIONS="17 16 15 14 13 12 11 10 9"

apt_get_install(){
    local version=$1
    apt-get --no-install-recommends -y install \
        clang-format-"$version" \
        clang-tidy-"$version"
}

print_version(){
    local version=$1
    clang-format-"$version" --version
    clang-tidy-"$version" --version
}

if [[ $TAG_VERSIONS =~ $CLANG_VERSION ]]; then
    apt_get_install "$CLANG_VERSION"
elif [[ "all" == "$CLANG_VERSION" ]]; then
    for version in $TAG_ALL_VERSIONS; do
        apt_get_install "$version"
        print_version "$version"
    done
    exit 0
else
    echo "$CLANG_VERSION not support."
    exit 1
fi

print_version "$CLANG_VERSION"
exit 0

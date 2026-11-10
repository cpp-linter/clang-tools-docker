#!/usr/bin/env python3
"""Point docker-bake.hcl and README.md at the newest static-binaries releases.

Usage:
    python3 scripts/update-pins.py

The script reads the static binaries' index.json, which lists the newest
release of every LLVM major, and then:
  1. sets `version` and `release` of each line in RELEASES (docker-bake.hcl)
  2. adds a line for an LLVM major that RELEASES does not have yet, on the
     base image of the newest line, and makes it LATEST
  3. rewrites the list of tags in README.md

Set INDEX_URL to read another index (for example a local file:// copy).
"""

from __future__ import annotations

import json
import os
import re
import sys
import urllib.request
from pathlib import Path

INDEX_URL = os.environ.get(
    "INDEX_URL", "https://cpp-linter.github.io/clang-tools-static-binaries/index.json"
)
INDEX_SCHEMA_VERSION = 1
ROOT = Path(__file__).resolve().parent.parent
BAKE = ROOT / "docker-bake.hcl"
README = ROOT / "README.md"
DOCKERFILE_URL = "https://github.com/cpp-linter/clang-tools-docker/blob/main/Dockerfile"

LINE = re.compile(
    r'^    \{ major = "(?P<major>\d+)", version = "(?P<version>[^"]+)", '
    r'release = "(?P<release>[^"]+)", base = "(?P<base>[^"]+)" \},\n',
    re.MULTILINE,
)
LATEST = re.compile(r'(variable "LATEST" \{\n {2}default = ")\d+(")')
TAGS = re.compile(r"(<!-- tags:start -->\n).*?(<!-- tags:end -->)", re.DOTALL)


def line(major: str, version: str, release: str, base: str) -> str:
    return (
        f'    {{ major = "{major}", version = "{version}", '
        f'release = "{release}", base = "{base}" }},\n'
    )


def main() -> None:
    with urllib.request.urlopen(INDEX_URL, timeout=30) as response:
        index = json.load(response)
    if index.get("schema_version") != INDEX_SCHEMA_VERSION:
        sys.exit(f"Unsupported index schema_version: {index.get('schema_version')}")

    bake = BAKE.read_text(encoding="utf-8")
    releases = {m["major"]: m.groupdict() for m in LINE.finditer(bake)}
    if not releases:
        sys.exit("No release lines found in docker-bake.hcl")
    newest = max(releases, key=int)

    for major, entry in index["versions"].items():
        if major in releases:
            releases[major].update(version=entry["version"], release=entry["tag"])
        elif int(major) > int(newest):
            # A new LLVM major starts on the base image of the newest one.
            releases[major] = {
                "major": major,
                "version": entry["version"],
                "release": entry["tag"],
                "base": releases[newest]["base"],
            }
    ordered = sorted(releases.values(), key=lambda r: int(r["major"]), reverse=True)
    latest = ordered[0]["major"]

    first, last = None, None
    for match in LINE.finditer(bake):
        first = match.start() if first is None else first
        last = match.end()
    bake = bake[:first] + "".join(line(**r) for r in ordered) + bake[last:]
    bake = LATEST.sub(rf"\g<1>{latest}\g<2>", bake)
    BAKE.write_text(bake, encoding="utf-8")

    tags = []
    for r in ordered:
        names = [r["major"], r["version"]] + (["latest"] if r["major"] == latest else [])
        tags.append("* [" + ", ".join(f"`{n}`" for n in names) + f"]({DOCKERFILE_URL})\n")
    readme = README.read_text(encoding="utf-8")
    if not TAGS.search(readme):
        sys.exit("No <!-- tags:start --> ... <!-- tags:end --> block in README.md")
    README.write_text(TAGS.sub(lambda m: m[1] + "".join(tags) + m[2], readme), encoding="utf-8")

    print("Releases: " + ", ".join(r["release"] for r in ordered))


if __name__ == "__main__":
    main()

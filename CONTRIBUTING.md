# Contributing

Thank you for investing your time in contributing to our project! We welcome feedback, bug reports, and pull requests!

## New contributor guide

For pull requests, please stick to the following guidelines

* Put a reasonable amount of comments into the code.
* Fork clang-tools-docker on your GitHub user account, do your changes there and then create a PR against the `main` branch of this repository.
* Separate unrelated changes into multiple pull requests.

Please note that by contributing any code or documentation to this repository (by raising pull requests, or otherwise) you explicitly agree to the [License Agreement](https://github.com/cpp-linter/clang-tools-docker/blob/main/LICENSE).

## Build image with [`docker buildx bake`](https://docs.docker.com/engine/reference/commandline/buildx_bake/)

> **Note**
> I used buildx [matrix-builds](https://docs.docker.com/build/bake/configuring-build/#matrix-builds), so `buildx` version must be v0.11.0 or above.

```bash
# Build all docker images
docker buildx bake --file docker-bake.hcl

# Build specific version of clang-tools docker images
docker buildx bake --file docker-bake.hcl 19

# If want to docker build and push images, add `--push` flag.
docker buildx bake --file docker-bake.hcl --push 19
```

## New LLVM releases

`RELEASES` in `docker-bake.hcl` pins one [static-binaries](https://github.com/cpp-linter/clang-tools-static-binaries) release for each LLVM version. The [Update pins](https://github.com/cpp-linter/clang-tools-docker/actions/workflows/update-pins.yml) workflow runs daily and opens a pull request when the static binaries' index has a newer release. To do the same by hand:

```bash
python3 scripts/update-pins.py
```

The script also rewrites the list of tags in `README.md`. A new LLVM version starts on the base image of the version before it; change `base` on its line if that version needs another one.

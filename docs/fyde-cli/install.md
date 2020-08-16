---
layout: default
title: Install fyde-cli
parent: Fyde CLI Client
has_children: true
nav_order: 1
---
# Install fyde-cli

fyde-cli is available for Linux, macOS and Windows.

If you use [Homebrew](https://brew.sh/) on Linux or macOS, we recommend installing fyde-cli through [our Homebrew tap](https://github.com/fyde/homebrew-tap).

If you are using an operating system and architecture for which we provide pre-built binaries, we recommend using those.
Just download the appropriate archive from the [releases page](https://github.com/fyde/fyde-cli/releases).
We also provide deb and rpm packages.
The fyde-cli binaries are statically compiled and have no external dependencies.

Inside each archive, you'll find the executable for the corresponding platform, a copy of the README and the license. Simply extract the executable and place it where you find most convenient (for example, in most Linux distros, you could use `/usr/local/bin` for a system-wide install).
Don't forget to add the executable to `$PATH`, or equivalent, if desired.

If we do not provide a pre-built binary for your platform, or if you want to make changes to fyde-cli, you can compile it yourself, following the [instructions]({{ site.baseurl }}{% link fyde-cli/compile-from-source.md %}).
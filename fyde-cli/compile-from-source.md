---
layout: default
title: Compile from source
parent: Install fyde-cli
grand_parent: Fyde CLI Client
---
# Compile from source

Compiling fyde-cli from source is recommended only if you intend to make changes to its source code.
Otherwise, we recommend installing fyde-cli [via Homebrew](https://github.com/fyde/homebrew-tap) or from the packages available on the [releases page](https://github.com/fyde/fyde-cli/releases).

## Prerequisites

 - [Git](https://git-scm.com/)
 - [Go](https://golang.org) (version 1.13 or higher)
 - [go-swagger](https://github.com/go-swagger/go-swagger) - fyde-cli is developed and tested using v0.21.0

## Obtaining the code

fyde-cli uses the modules support introduced in Go 1.11, which means you are not forced to place the code in a specific path under GOPATH. You can clone the repository into any folder:

```
git clone https://github.com/fyde/fyde-cli.git
cd fyde-cli
```

You can also clone the repo into the usual `$GOPATH/src/github.com/fyde/fyde-cli` path, but keep in mind that the project will not compile until the next step is complete (i.e. `go get github.com/fyde/fyde-cli` will always fail).

## Generating code from the Swagger specification

After installing [go-swagger](https://github.com/go-swagger/go-swagger), run the following command on the root of this repo:

`swagger generate client -f swagger.yml`

This will generate the `client` and `models` packages.
The code in the `cmd` package depends on these.

## Compiling

Simply run `go build`.
Because we are using Go modules, Go will take care of downloading the correct versions of the dependencies.

You should now have a `fyde-cli` executable.
You can `go install` the package, if you wish, which will place the binary in `$GOPATH/bin`.
---
layout: default
title: Configuration file
parent: Fyde CLI Client
nav_order: 4
---
# Configuration file

fyde-cli uses a configuration file which allows for adjusting some aspects of its behavior.
This file is created by fyde-cli but it is not changed by the program, and must be edited manually.

By default, fyde-cli creates and looks for the configuration file in a folder owned by the user.
The exact path is platform-dependent.
You can see what path fyde-cli will use by default in the "Global flags" section of the help text:

```
$ fyde-cli help
<snip>
Global Flags:
      --config string     config file (default is /home/myuser/.config/fyde/fyde-cli/config.yaml)
<snip>
```

The path to the config file can be overridden in two different ways:

- Using the environment variable `FYDE_CLI_CONFIG_FILE`, set to the full path of the file.
- Using the flag `--config` followed by the full path of the file. This takes precedence over the environment variable.

The "full path of the file" can be absolute or relative, and must include the file name and extension.

## Syntax

As indicated by the extension, YAML format is expected.
All configuration parameters are optional.
Here is an example of a complete config file:

```
outputFormat: table
pipeOutputFormat: json
recordsPerGetRequest: 50
defaultRangeSize: 20
cachePath: /tmp/fyde-cli-cache
```

## Parameters

### outputFormat
This defines the default output format, for commands where the `--output` flag can be used, if an interactive terminal is detected.
It is ignored if the `--output` flag is explicitly provided.

**Possible values:** `table`, `csv`, `json`, `json-pretty`

**Default value:** `table`

### pipeOutputFormat
This defines the default output format, for commands where the `--output` flag can be used, if an interactive terminal is **not** detected.
It is ignored if the `--output` flag is explicitly provided.

**Possible values:** `table`, `csv`, `json`, `json-pretty`

**Default value:** `json`

### recordsPerGetRequest

fyde-cli abstracts pagination in server requests, exposing only `--range-start` and `--range-end` to the user, which operate on record indexes and not pages.
This setting controls how many records should be requested per page on list commands.
Setting a larger value results in less requests being made when retrieving large numbers of records, at the expense of wasting more bandwidth if the requested record range starts or ends near a page boundary.

**Possible values:** any integer between 1 and 100, inclusive.

**Default value:** `50`

### defaultRangeSize

How many records to display on list commands, when neither `--range-start`, `--range-end` or `--list-all` are specified.

**Possible values:** any positive non-zero integer

**Default value:** `20`

### cachePath

Path for cache files.
Currently used only if `--experimental-use-cache` is specified on `endpoint set`.
Note that this setting does not control whether the cache is used.
Because it changes an aspect of the communication with the API, that setting is actually stored in the [credentials file]({{ site.baseurl }}{% link fyde-cli/credentials-file.md %}).

**Possible values:** any valid folder path. fyde-cli will attempt creating the folder the first time it writes to cache, if it doesn't exist.

**Default value:** platform and user-dependent - see "User wide cache folder" in [configdir](https://github.com/shibukawa/configdir)
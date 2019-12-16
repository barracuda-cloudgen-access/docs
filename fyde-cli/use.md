---
layout: default
title: Use fyde-cli
parent: Fyde CLI Client
nav_order: 2
---
# Use fyde-cli

When run without arguments, fyde-cli presents a list of available commands.
It will also show where it is going to save and look for the configuration files, unless overridden.

To use the client with an Enterprise Console endpoint other than the default (`enterprise.fyde.com`), you should start by [setting the endpoint]({{ site.baseurl }}{% link fyde-cli/set-EC-endpoint.md %}).

You can then proceed to log in with your Enterprise Console credentials:

```
$ fyde-cli login
Email address: you@example.com
Password:
Logged in successfully, access token stored in (...)fyde/fyde-cli/auth.yaml
```

You can now use other commands. For example, to list users, you can use `fyde-cli users list`.

## Command help

All commands provide a help text with the available subcommands and flags.
For example, running `fyde-cli resources` will let you know about the `get`, `list`, `add`, `edit` and `delete` subcommands, and `fyde-cli resources list --help` will list all available flags for the list resources command, including pagination, sorting and filtering flags.

## Output formats

fyde-cli supports different output formats for different use cases:

 - Table, for interactive usage (`--output=table`)
 - CSV (`--output=csv`)
 - JSON (`--output=json` or `--output=json-pretty`)

By default, when an interactive terminal is detected, `table` output is used.
Otherwise, `json` is used.
JSON output generally contains the most information, sometimes including nested objects; CSV output corresponds to a CSV version of the table output.

All output formats are subject to pagination parameters, when those are available.

Additional output options are available for record creation and editing commands:
 - `--errors-only` - output will be restricted to records whose creation/editing failed

## Input formats

In addition to receiving input through the command line, when adding or editing records, fyde-cli can read record information from JSON or CSV files.
For more information, see the documentation on [batch mode operations]({{ site.baseurl }}{% link fyde-cli/batch-mode-operations.md %}).

## Behavior on error

When creating, editing or deleting multiple records in one go, by default fyde-cli will stop on the first error.
However, one may want to perform the operation in a "best effort" basis, where fyde-cli will continue processing the remaining records/arguments regardless of previous server-issued errors.
This can be enabled using the `--continue-on-error` flag.
When this flag is passed, fyde-cli never exits with a non-zero code, as long as the input is correctly formatted and all errors come from server-side operations.
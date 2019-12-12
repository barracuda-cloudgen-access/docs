---
layout: default
title: Batch mode operations
parent: Fyde CLI Client
has_children: true
---

# Batch mode operations

fyde-cli supports adding and editing most record types in batch mode, using data contained in JSON or CSV files.

When performing operations in batch mode, reading data from a file, there are four relevant flags:

 - `--from-file` specifies the filename from where to read the data
 - `--file-format` specifies the format of the file (`json` or `csv`). Can be omitted if JSON is used
 - `--continue-on-error` instructs fyde-cli to continue processing records even if the operation fails for one of them. By default, fyde-cli will quit on the first error. When this flag is passed, fyde-cli will process the file in its entirety and any errors will be shown in the resulting output.
 - `--errors-only` instructs fyde-cli to omit output for successful operations and show only the list of errors, and is meant to be used with `--continue-on-error`
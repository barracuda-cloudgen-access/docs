---
layout: default
title: Credentials file
parent: Fyde CLI Client
nav_order: 5
---
# Credentials file

fyde-cli uses a "credentials file" or "authentication file" which specifies what [endpoint to use]({{ site.baseurl }}{% link fyde-cli/set-EC-endpoint.md %}) and the API credentials.
This file is changed by the `endpoint set` and `login` commands.

By default, fyde-cli places the credentials file in a folder owned by the user.
The exact path is platform-dependent.
You can see what path fyde-cli will use by default in the "Global flags" section of the help text:

```
$ fyde-cli help
<snip>
Global Flags:
      --auth string     credentials file (default is /home/myuser/.config/fyde/fyde-cli/auth.yaml)
<snip>
```

When managing more than one Management Console installation, quickly switching between credentials files can be useful.
The path to the credentials file can be overridden in two different ways:

- Using the environment variable `FYDE_CLI_AUTH_FILE`, set to the full path of the file.
- Using the flag `--auth` followed by the full path of the file. This takes precedence over the environment variable.

The "full path of the file" can be absolute or relative, and must include the file name and extension.
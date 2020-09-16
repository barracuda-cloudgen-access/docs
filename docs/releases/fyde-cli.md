---
title: Fyde Cli
has_children: false
nav_order: 3
parent: Releases
---
# Fyde Cli

## Version 0.9.1

Release date: 5-05-2020

- Added support for SSO login
- Added admin management support (list, create, edit, delete)
- Added support to set a different email for administrators SSO authentication

## Version 0.8.4

Release date: 4-05-2020

- API definitions updated to match the latest Enterprise Console API. Affected operations: device listing, device enabling/disabling, device auth revoking

## Version 0.8.0

Release date: 11-02-2020

**Deprecation warning**: please upgrade to the newest version as soon as possible since there are API incompatibilities on older ones

- Adds support for resources with wildcard domains and port ranges
- Add support for specifying several conditions and parameters in several API endpoints
- Several other [improvements](https://github.com/fyde/fyde-cli/releases/tag/v0.8.0)

## Version 0.7.0

Release date: 17-12-2019

- Access resource model updated to match Enterprise Console API changes
  - Increased consistency of the output of delete, device authorization revoke, user and source enable/disable, and user enrollment management commands
    - All of these commands now support the --output flag and thus can report the result of the operation in machine-readable formats
- Some commands now accept piped input, allowing for chaining of certain commands
  - For example, `fyde-cli user list -q "John Doe" --list-all | fyde-cli user disable` can be used to disable all users that appear in the search results for "John Doe"
  - For this to work, the piped command must output JSON (which is the default if no flags or configuration options are set).
- Fixed bugs editing resources, where clearing the notes field would be impossible, and specifying port mappings is no longer mandatory every time a resource is edited
- Improved handling of server error responses

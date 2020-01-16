---
title: Releases
has_children: false
nav_order: 9
---
# Releases

## Fyde Proxy Orchestrator - Version 1.1.12

Release date: 15-01-2020

### Improvements

- Added support for TLS Session Tickets in cluster mode
- Added support for HTTP/S Proxies

### Bug Fixes

- Bugfix for AWS detection feature

## Fyde Enterprise Console - Version 0.9.12

Release date: 14-01-2020

### Improvements

- Improved the UI/UX on the device details page:
  - A confirmation pop-up is now prompt when revoking the authentication for a device;
  - It is now possible to disable and unenroll a device from this screen

## Fyde App - Version 0.24.0 [ANDROID, IOS, LINUX, MACOS, WINDOWS]

Release date: to be released

### Improvements

- Improved bug report screen

### Bug Fixes

- macOS: fixed a problem on screen lock policy restriction
- All clients: fixed handling of HTTP chunked transfer encoding

## Fyde cli - Version 0.7.0

Release date: 17-12-2019

### Improvements

- Access resource model updated to match Enterprise Console API changes
  - Increased consistency of the output of delete, device authorization revoke, user and source enable/disable, and user enrollment management commands
    - All of these commands now support the --output flag and thus can report the result of the operation in machine-readable formats
- Some commands now accept piped input, allowing for chaining of certain commands
    - For example, `fyde-cli user list -q "John Doe" --list-all | fyde-cli user disable` can be used to disable all users that appear in the search results for "John Doe"
    - For this to work, the piped command must output JSON (which is the default if no flags or configuration options are set).
- Fixed bugs editing resources, where clearing the notes field would be impossible, and specifying port mappings is no longer mandatory every time a resource is edited
- Improved handling of server error responses

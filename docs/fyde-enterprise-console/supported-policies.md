---
layout: default
title: Supported policies
parent: Fyde Enterprise Console
nav_order: 4
---
# Supported policies

The table below shows the app versions from which each policy is supported for each operating system. "*" signals an unreleased version (to be released soon).

| Policy name                | Android    | iOS        | Linux  | macOS  | Windows |
|----------------------------|------------|------------|--------|--------|---------|
| Block jailbroken devices   | 0.20.46540 | 0.20.46540 | -      | -      | -       |
| Detect disk encryption     | 0.22.0     | 0.22.0     | -      | 0.22.0 | 0.24.0* |
| Detect firewall enabled    | -          | -          | -      | 0.23.0 | 0.24.0* |
| Detect screen lock enabled | 0.20.46540 | 0.11.10    | -      | -      | -       |
| Reauth supported           | 0.22.0     | 0.22.0     | 0.22.0 | 0.22.0 | 0.22.0  |
| OS version outdated        | 0.23.0     | 0.23.0     | 0.23.0 | 0.23.0 | 0.23.0  |
| Detect antivirus status    | -          | -          | -      | -      | 0.24.0* |

## How are policies implemented?

The Fyde app runs in user space, and as such, relies on system supported APIs that implement non-kernel access to the attribute information. In particular, in the case of disk encryption, firewall, screen lock and anti-virus policies, we rely on the following specific APIs:

* Windows Security Center (WSC) in the case of Windows apps -- third-party firewall and anti-virus software must be compliant;
* IOKit for iOS and macOS;
* DevicePolicyManager for Android apps.

For detecting jailbroken devices, we use the [RootBeer](https://github.com/scottyab/rootbeer) library for Android; in the iOS case, we verify rootkits by checking for certain files and known apps, as well as whether we are allowed to access the filesystem outside of the app sandbox.

Finally, for detecting an outdated OS version, we compare semantic versioning with the version that the systems administrator selects.

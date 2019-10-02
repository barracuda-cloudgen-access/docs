---
layout: default
title: User Directory Connector
parent: Fyde Enterprise Console
nav_order: 10
has_children: true
has_toc: false
---
# User Directory Connector

This program retrieves users and groups from multiple sources and sync them into a Fyde Enterprise tenant. Multiple user sources are available and you will have specific configuration steps depending which ones you use. The user sources for a connector are activated through the Fyde Enterprise Console.

## Use mode

The first step to configure a User Directory connector is to create it in the Fyde Enterprise Console -> Settings -> User directories section. Once that is finished it will return a secret token in the form of an URL that needs to be passed to the connector configuration.

This program utilizes the same configuration system than our Fyde Proxy Orchestrator, so all
options can be configured using command line arguments, environment variables, docker secrets,
AWS SSM, etc.

A connector can be installed on a Centos OS using RPMs, it can also be run directly on any modern linux (it is a single static binary), or using a docker container. Click [here]({{ site.baseurl }}{% link fyde-enterprise-console/user-directory-connector-centos.md %}) for CentOS install steps.

The only mandatory configuration parameter is the `enrollment_token`, which you obtain from the Fyde Enterprise Console when you create a new User Directory.

```sh
$ docker run -it fydeinc/fyde-connector --enrollment-token='https://enterprise.fyde.com/connectors/v1/connectorid1?auth_token=connector1_token&tenant_id=tenantid1'
2019-08-30 19:05:18 - Running Fyde Connector version 1.0.0
2019-08-30 19:05:18 - Initializing Sync Manager for connector https://enterprise.fyde.com/connectors/v1/connectorid1
...
```

By default, a connector runs forever and runs its user/group syncing every 15 minutes. This behavior can be changed through other configuration options described later.

## Sources

This program allows to sync using multiple different directory sources, and depending the sources used you will need to provide some extra information (like the address to and LDAP server, etc).

### Google Suite

To sync with a Google Suite domain you will need to authorize Fyde to access your data, which
requires a manual step to obtain an authorization token from Google. Once this token is obtained, it should be valid without expiration, unless you invalidate it from the Google Admin Console.

```sh
$ docker run -it fydeinc/fyde-connector --enrollment-token='http://host.docker.internal:8080/connectors/v1/connectorid1?auth_token=connector1_token&tenant_id=tenantid1'
2019-08-30 23:00:59 - Running Fyde Connector version 1.0.0
2019-08-30 23:00:59 - Initializing Sync Manager for connector http://localhost:8080/connectors/v1/connectorid1
Please visit this URL to authorize this application: https://accounts.google.com/o/oauth2/auth....
Enter the authorization code: <enter the code returned by google once you authorize Fyde>
Your Google Suite token is:eAJ4q2wcbi......
Provide this code to the Fyde Connector following the instruction in our documentation.
Refer to https://fyde.github.io/docs/ for more information.
2019-08-30 23:03:36 - Module google_apps is not ready to run
2019-08-30 23:03:36 - Connector service is going bye-bye
```

As it says there, you need to provide this authorization token from Google to the connector to proceed to the syncing. The parameter to do so is called `google-auth-token` and a once you
pass it to the connector it should start syncing immediately.

```sh
$ docker run -it fydeinc/fyde-connector --enrollment-token='https://enterprise.fyde......' --google-auth-token='eAJ4q2wcbi......'
2019-08-30 23:06:42 - Running Fyde Connector version 1.0.0
2019-08-30 23:06:42 - Initializing Sync Manager for connector https://enterprise.fyde.com/connectors/v1/connectorid1
2019-08-30 23:07:05 - URL being requested: GET https://www.googleapis.com/discovery/v1/apis/admin/directory_v1/rest
....
2019-08-30 23:07:42 - Ran module <sources.google_apps.SyncModule object at 0x1066342b0> successfully, next run in 900 seconds
```

### Okta Directory

To sync with an Okta tenant you will need to authorize Fyde to access your data, which
requires a administrative step to obtain an API token from Okta. Read-only administrative permisions
are enough to run a connector, it is recommended you create a service account with only those permissions
and create an API token from there. It should be valid without expiration, unless you invalidate it from the Okta console. The variable used to pass this token is called `okta-auth-token`.

You will also need to provide the domain name assigned to your organization in Okta, usually something like `exampleorg.okta.com`, in a variable called `okta-domainname`.

```sh
$ docker run -it fydeinc/fyde-connector --enrollment-token='https://enterprise.fyde......' --okta-auth-token='eAJ4q2wc......' --okta-domainname='exampleorg.okta.com'
2019-08-30 23:06:42 - Running Fyde Connector version 1.0.0
2019-08-30 23:06:42 - Initializing Sync Manager for connector https://enterprise.fyde.com/connectors/v1/connectorid1
....
2019-08-30 23:07:42 - Ran module <sources.okta.SyncModule object at 0x1066555b0> successfully, next run in 900 seconds
```

---
layout: default
title: Set EC endpoint
parent: Fyde CLI Client
nav_order: 2
---
# Set EC endpoint

By default, fyde-cli communicates with the Enterprise Console (EC) endpoint `enterprise.fyde.com`. You can obtain the current endpoint using `endpoint`:

```
$ fyde-cli endpoint
Currently configured endpoint:
enterprise.fyde.com
```

You can change the configured endpoint using `endpoint set`.
The Management Console endpoint should be specified as the IP address or FQDN, optionally including a port number, and without the schema or any slashes.
Valid examples include `fydeconsole.example.com`, `10.123.20.2:3000` and `example.local:9000`.
Regardless of the endpoint address/port, HTTPS is always used as the transport, unless an option is specified, as detailed further below.

```
$ fyde-cli endpoint set fydeconsole.example.com
Endpoint changed to fydeconsole.example.com.
Credentials cleared, please login again using `fyde-cli login`
```

The endpoint is saved in the authentication settings file, therefore, when you [switch between credentials files]({{ site.baseurl }}{% link fyde-cli/credentials-file.md %}), the correct endpoint for the credentials is used automatically.

As indicated by the message shown, when the endpoint is set, credentials are cleared from the current credentials file.

## Experimental endpoint settings

### Use HTTP cache

Experimental support for RFC 7234-compliant HTTP caching can be enabled by including the `--experimental-use-cache` option when setting the endpoint.

The location of the cache can be adjusted using the [configuration file]({{ site.baseurl }}{% link fyde-cli/configuration-file.md %}).

The cache is cleared when the endpoint is set.

## Advanced endpoint settings

### Disabling TLS certificate validation

Under very specific circumstances, such as debugging certificate issues, it is possible to disable the validation of the EC TLS certificate.
**This should only be used for development and testing.**

fyde-cli will still use HTTPS, but it will accept any certificate presented by the server and any host name in that certificate.
This behavior can be enabled by including the `--insecure-skip-verify` option when setting the endpoint.

```
$ fyde-cli endpoint set --insecure-skip-verify test.local
Endpoint changed to test.local.
Credentials cleared, please login again using `fyde-cli login`
WARNING: TLS certificate verification is being skipped for the endpoint. THIS IS INSECURE.
```

fyde-cli will show the above warning on every run, until the endpoint is set again, without using this option.

### Using HTTP instead of HTTPS

Under very specific circumstances, it is possible to have fyde-cli communicate with the EC over HTTP instead of HTTPS.
**This should only be used for development and testing.**

fyde-cli will still follow any redirects to HTTPS that the server might present.
This behavior can be enabled by including the `--insecure-skip-verify` option when setting the endpoint.

```
$ fyde-cli endpoint set --insecure-use-http test.local
Endpoint changed to test.local.
Credentials cleared, please login again using `fyde-cli login`
WARNING: HTTP, instead of HTTPS, is being used for API communication. THIS IS INSECURE.
```

fyde-cli will show the above warning on every run, until the endpoint is set again, without using this option.
---
layout: default
title: Parameters
parent: User Directory Connector
grand_parent: Fyde Enterprise Console
nav_order: 1
---
## Parameters

- The following override mechanisms will be processed in order, the last override representing the final value:

  1. default value
  1. overrides.json file on the CWD of the service process
  1. Docker provisioned secret (/run/secrets/\<key>)
  1. AWS SSM (all keys prefixed with 'fyde_')
  1. AWS SecretsManager (all keys prefixed with 'fyde_')
  1. environment variable, prefixed with FYDE_ , all caps and replacing dashes `-` with underscores `_`

Here is a complete list of all configuration parameters that this program uses.

| Key | Default value | Type | Description |
|-----|---------------|------|-------------|
|enrollment_token|None|string|Enrollment token provided by the Fyde Enterprise Console|
|prometheus|False|bool|Prometheus metrics for the connector|
|prometheus_port|9000|int|Prometheus port|
|server_mode|False|bool|Run connector in microservice mode|
|server_host|127.0.0.1|string|IP Address to listen to for requests when running in server_mode|
|server_port|8000|int|Port to listen in server_mode|
|sync_cycle|900|int|Time to wait between sync cycles|
|sync_error_backoff|30|int|Time to wait before retrying a failed sync attempt|
|sync_job_completion|30|int|Time to wait between polls to confirm a sync job has been processed|
|run_once|False|bool|Run only one sync cycle and exit|
|api_ca_validation|True|bool|Validate the TLS certificates of the API server|
|api_timeout|60|int|Timeout to fail a connection to the API server|
|live_test_timeout|30|int|Liveness of the redis data for active jobs in server_mode. If data about a pending job is not refreshed by the end of this timeout, the system considers the connector instance handling the job died and cleans up the data associated|
|logfile||string|Log file to send all output. It is also sent to stderr by default|
|google-auth-token||string|This auth token is required for syncing with Google Suite domains. It is created through this tool, please follow instructions from our documentation|
|okta-auth-token||string|This is an Okta API token and it is required to sync with Okta Directories|
|okta-domainname||string|This is the domain assigned to your organization inside Okta. something like exampleorg.okta.com|

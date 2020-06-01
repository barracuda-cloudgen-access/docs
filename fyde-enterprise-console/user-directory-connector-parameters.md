---
layout: default
title: Parameters
parent: User Directory Connector
grand_parent: Fyde Enterprise Console
nav_order: 3
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

| Key               | Default value | Type  | Description |
|-------------------|---------------|-------|-------------|
|api_ca_validation  |True           |bool   |Validate the TLS certificates of the API server|
|api_timeout        |60             |int    |Timeout to fail a connection to the API server|
|azure-api-timeout  |60             |int    |Timeout to connect to Azure infrastructure|
|azure-auth-token   |               |string |This auth token is required for syncing with an Azure AD tenant. It is created through this tool, please follow instructions from our documentation|
|enrollment_token   |None           |string |Enrollment token provided by the Fyde Enterprise Console|
|force-full-sync    |False          |bool   |Force a full sync of the directory source|
|google-auth-token  |               |string |This auth token is required for syncing with Google Suite domains. It is created through this tool, please follow instructions from our documentation|
|groups-excluded    |               |string |Group import filtering (regex). Note that all groups are still imported, this will filter the users that are imported|
|groups-included    |               |string |Group import filtering (regex). Note that all groups are still imported, this will filter the users that are imported|
|http-proxy         |               |string |Use HTTP proxy. Example: “http://proxy.host:1234/” or “socks5://10.0.0.1:5555”|
|https-proxy        |               |string |Use HTTPS proxy. Example: “https://proxy.host:1234/” or “socks5://10.0.0.1:5555”|
|live_test_timeout  |30             |int    |Liveness of the redis data for active jobs in server_mode. If data about a pending job is not refreshed by the end of this timeout, the system considers the connector instance handling the job died and cleans up the data associated|
|logfile            |               |string |Log file to send all output. It is also sent to stderr by default|
|loglevel           |info           |string |Log level to use. Valid values error/warning/info/debug |
|okta-auth-token    |               |string |This is an Okta API token and it is required to sync with Okta Directories|
|okta-domainname    |               |string |This is the domain assigned to your organization inside Okta. something like exampleorg.okta.com|
|only-matched-groups|True           |bool   |Decides if it should only push groups that match the group filters, or all of them |
|prometheus         |False          |bool   |Prometheus metrics for the connector|
|prometheus_port    |9000           |int    |Prometheus port|
|run_once           |False          |bool   |Run only one sync cycle and exit|
|server_host        |127.0.0.1      |string |IP Address to listen to for requests when running in server_mode|
|server_mode        |False          |bool   |Run connector in microservice mode|
|server_port        |8000           |int    |Port to listen in server_mode|
|sync_cycle         |900            |int    |Time to wait between sync cycles|
|sync_error_backoff |30             |int    |Time to wait before retrying a failed sync attempt|
|sync_job_completion|30             |int    |Time to wait between polls to confirm a sync job has been processed|
|users-excluded     |               |string |User import filtering (regex). Note that all groups are still imported, this will filter the users that are imported|
|users-included     |               |string |User import filtering (regex). Note that all groups are still imported, this will filter the users that are imported|

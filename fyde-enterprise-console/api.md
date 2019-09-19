---
layout: default
title: API
parent: Fyde Enterprise Console
nav_order: 2
---

# Overview

All API access is over HTTPS, and accessed from `https://enterprise.fyde.com/api`.
All data is sent and received as JSON.

Blank fields are included as `null` instead of being omitted.

All timestamps return in ISO 8601 format:

```
YYYY-MM-DDTHH:MM:SSZ
```

# Authentication

This API implements a token-based authentication.

Authentication is performed using the following headers:
```
token-type: Bearer
uid: admin@fyde.com
expiry: 1567012214
access-token: xxxxxxxxxxxxxxxxxx
client: xxxxxxxxxxxxxxxxxx
```

_Please note that the tokens are refreshed on each request._

# Pagination

All API calls provide paginated items in sets of 25. It is possible to specify
how many items to receive, up to a maximum of 100, by passing the `per_page`
parameter.

```
curl -I "https://enterprise.fyde.com/api/v1/access_resources?page=2"
```

Page numbering is 1-based and ommiting `?page` will return the first page.

## Link Header

Information about pagination is provided in the Link header of an API call,
following the proposed [RFC-8288](https://tools.ietf.org/html/rfc8288) standard
for Web linking.

```
$ curl -I "https://enterprise.fyde.com/api/v1/access_resources?page=2"

HTTP/1.1 200 OK
link: <https://enterprise.fyde.com/api/v1/access_resources?page=1>; rel="first",
  <https://enterprise.fyde.com/api/v1/access_resources?page=1>; rel="prev",
  <https://enterprise.fyde.com/api/v1/access_resources?page=4>; rel="last",
  <https://enterprise.fyde.com/api/v1/access_resources?page=3>; rel="next"
page: 2
per-page: 25
total: 86
# ...
```

The possible `rel` values are:

| Name    | Description                                                   |
|---------|---------------------------------------------------------------|
| `next`  | The link relation for the immediate next page of results.     |
| `last`  | The link relation for the last page of results.               |
| `first` | The link relation for the first page of results.              |
| `prev`  | The link relation for the immediate previous page of results. |

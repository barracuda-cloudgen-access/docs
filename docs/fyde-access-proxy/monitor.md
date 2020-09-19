---
layout: default
title: Monitor
parent: Fyde Access Proxy
nav_order: 9
---
# Monitor
{: .no_toc }

## Table of contents
{: .no_toc }
- TOC
{:toc}

## Description

- Prometheus metrics are enabled by default in the Fyde Access Proxy components
- The scrapping path is in the root of the endpoint `/`
- Ports can be customized in each component (check [Parameters]({{ site.baseurl }}{% link fyde-access-proxy/parameters.md %}))

## Examples

### Envoy Proxy Prometheus job configuration

- Add the following job to the existing prometheus configuration

```yaml
- job_name: envoy-proxy
  scrape_interval: 10s
  scrape_timeout:  5s
  metrics_path: /
  static_configs:
    - targets: ['envoy-proxy:9000']
```

### Envoy Proxy prometheus-operator Service Monitor

- Apply the following configuration
- Ensure that prometheus-operator is allowed to scrape that namespace

```yaml
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    app: envoy-proxy
  name: envoy-proxy
spec:
  endpoints:
    - interval: 10s
      path: /
      port: metrics
  namespaceSelector:
    matchNames:
      - fyde-access-proxy
  selector:
    matchLabels:
      app: envoy-proxy
```

- Also add the following to the corresponding service, if the service is deployed in kubernetes:

```yaml
    - name: metrics
      protocol: TCP
      port: 9000
      targetPort: 9000
```

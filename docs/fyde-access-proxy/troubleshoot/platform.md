---
layout: default
title: Platform
parent: Troubleshoot
grand_parent: Fyde Access Proxy
nav_order: 2
---
# Platform
{: .no_toc }

## Table of contents
{: .no_toc }
- TOC
{:toc}

## Bare Metal / Virtual Machine

- Check Envoy Proxy logs

  ```sh
  sudo tail /var/log/envoy/envoy.log -f
  ```

- Check Fyde Access Proxy logs

  ```sh
  sudo journalctl -u fydeproxy -f
  ```

- Check firewall rules

  ```sh
  sudo firewall-cmd --list-all-zones
  # or
  sudo iptables -L -xvn
  ```

- Ensure Envoy Proxy is running

  ```sh
  sudo ps axuww | grep envoy
  ```

- Ensure Envoy Proxy is listening on the correct port

  ```sh
  sudo ss -anp | grep envoy | grep LISTEN
  # or
  sudo netstat -anp | grep envoy | grep LISTEN
  ```

## Cloudformation ASG

- Instance logs are sent to CloudWatch by default

- Check the log group named: `/aws/ec2/FydeAccessProxy`
  1. Select the failing instance from the log stream list
  2. Filter for `cloud-init:`
  3. Search for script errors. Example:

    ```log
    2020-09-19T22:36:07.894+01:00	Sep 19 21:36:05 ip-10-200-0-114 cloud-init: + curl -sL https://url.fyde.me/install-fyde-proxy-linux
    2020-09-19T22:36:07.894+01:00	Sep 19 21:36:06 ip-10-200-0-114 cloud-init: Invalid option: -r
    ```

## Cloudformation ECS Fargate

- Pod logs are sent to CloudWatch by default

- Check the log group named: `fyde-access-proxy-ecs-fargate`
  1. Select the failing pod from the log stream list
  2. Check the last lines for the error cause

## Docker

- Confirm that both **envoy-proxy** and **fyde-orchestrator** containers are running

  ```sh
  sudo docker ps
  ```

- Confirm that **envoy-proxy** container is mapping the correct port to the host

  - In the example above, and for the public port 443 the output should contain the following

  ```sh
  0.0.0.0:443->443/tcp
  ```

- Check Envoy Proxy logs

  ```sh
  sudo docker logs envoy-proxy -f
  ```

- Check Fyde Access Proxy logs

  ```sh
  sudo docker logs fyde-orchestrator -f
  ```

- Check that docker network is not conflicting with a remote network

  - Check the value for **IPAM.Config.Subnet**

  - For more information check [compose-file](https://docs.docker.com/compose/compose-file/#ipam){:target="_blank"}

  ```sh
  sudo docker network inspect fyde
  ```

## Kubernetes

- Correct the namespace if needed

- Check all deployed resources

  ```sh
  kubectl get all \
    --namespace fyde-access-proxy
  ```

- Check envoy logs

  ```sh
  kubectl logs \
    -l app=envoy-proxy -f \
    --namespace fyde-access-proxy
  ```

- Check proxy logs

  ```sh
  kubectl logs \
    -l app=fyde-orchestrator -f \
    --namespace fyde-access-proxy
  ```

- Check that envoy service is properly configured for your environment

  ```sh
  kubectl describe service envoy-proxy \
    --namespace fyde-access-proxy
  ```

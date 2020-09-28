---
layout: default
title: Testing Access
parent: Troubleshoot
grand_parent: Fyde Access Proxy
nav_order: 1
---
# Testing Access
{: .no_toc }

## Table of contents
{: .no_toc }
- TOC
{:toc}

## 1. Test connectivity from the device to the Fyde Access Proxy

- Get the Fyde Access Proxy details from Fyde Enterprise Console

- Try to open an SSL connection to the proxy and confirm that the first lines reference `Fyde Root Certificate Authority`

  ```sh
  → openssl s_client -showcerts -servername <proxy_host> -connect <proxy_host>:<proxy_port>
  CONNECTED(00000006)
  depth=3 CN = Fyde Root Certificate Authority
  verify error:num=19:self signed certificate in certificate chain
  verify return:1
  depth=3 CN = Fyde Root Certificate Authority
  verify return:1
  depth=2 CN = Fyde Intermediary Certificate Authority
  verify return:1
  depth=1 CN = fyde://xxxx-xxxxxx-xxxx/
  verify return:1
  depth=0
  verify return:1
  ...
  ```

- If the request fails or the operation times out, that means you are not reaching the Fyde Access Proxy

- Check the following:

  - Proxy Host DNS record is being resolved to the correct IP
  - Proxy Host IP, if using IP instead of DNS, is correct
  - NAT configuration in the device/service that is exposing the Fyde Access Proxy
  - Firewall rules to allow inbound communication to the configured Fyde Access Proxy

## 2. Check if the device is trying to access the Resource with the Fyde App

- Check the IP for the failing Resource, it should return an IP in the range:

  - 255.0.0.0/8 for Unix/Linux based Operative systems
  - 198.18.0.0/15 for Microsoft Operative Systems

  ```sh
  → nslookup myresource.private
  Server:    192.0.2.5
  Address:   192.0.2.5#53

  Name: myresource.private
  Address: 255.0.0.12
  ```

- Next steps:

  - Confirm that Fyde App is running and the tunnel is started
  - Check that Fyde App is enrolled in a tenant
  - Confirm the Resource is created in Fyde Enterprise Console
  - Resource list update on Fyde App can take up to 15m, force refresh if your Fyde App version allows it

## 3. Test connectivity from Envoy Proxy to the Resource

- The Envoy Proxy needs to be able to reach the Resource with the configured properties

- Take note of the following resource:
  - **Resource Name**: My Resource
  - **Public Host**: myresource.private
  - **Resource Host**: myresource.internal
  - **External Port**: 80
  - **Internal Port**: 3000
  - **Access Proxy**: US-EAST-1-PROXY

- Envoy Proxy needs to be able to resolve the **Resource Host** record

  ```sh
  → nslookup myresource.internal
  Server:    10.0.0.1
  Address:   10.0.0.1#53

  Name: myresource.internal
  Address: 10.0.0.20
  ```

- For an HTTP resource we can send an HTTP request using curl

  ```sh
  → curl myresource.internal:3000
  HTTP/1.1 200 OK
  [...]
  ```

- For a redis resource we can connect using netcat

  ```sh
  → nc myresource.internal 3000
  PING
  +PONG
  ```

- Next steps:

  - Check that the DNS server is correctly configured
  - Confirm that intermediate firewall rules are not blocking access to the Resource
  - For HTTPS connection, the **Public Host** needs to match the configured hostname in the resource certificate,
    however the **Resource Host** just needs to be something the Fyde Access Proxy is able to resolve and access
  - Check more steps by platform below

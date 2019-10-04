---
layout: default
title: Troubleshoot
parent: Fyde Access Proxy
nav_order: 4
---
# Troubleshoot

- The steps in this page are best performed from a desktop client

- Troubleshooting using the mobile app is currently in development

## Test connectivity from the device to the Fyde Access Proxy

- Get the Fyde Access Proxy details from Fyde Enterprise Console

- Try to open an SSL connection to the proxy

  ```sh
  → openssl s_client -host <proxy_host> -port <proxy_port>
  CONNECTED(00000005)
  write:errno=54
  ---
  no peer certificate available
  ---
  No client certificate CA names sent
  ---
  SSL handshake has read 0 bytes and written 0 bytes
  ---
  New, (NONE), Cipher is (NONE)
  Secure Renegotiation IS NOT supported
  Compression: NONE
  Expansion: NONE
  No ALPN negotiated
  SSL-Session:
      Protocol  : TLSv1.2
      Cipher    : 0000
      Session-ID:
      Session-ID-ctx:
      Master-Key:
      Start Time: 123456789
      Timeout   : 7200 (sec)
      Verify return code: 0 (ok)
  ---
  ```

- If the request fails or the operation times out, that means you are not reaching the Fyde Access Proxy

- Check the following:

  - Proxy Host DNS record is being resolved to the correct IP
  - Proxy Host IP, if using IP instead of DNS, is correct
  - NAT configuration in the device/service that is exposing the Fyde Access Proxy
  - Firewall rules to allow inbound communication to the configured Fyde Access Proxy

## Check if the device is trying to access the Resource with the Fyde App

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

## Test connectivity from Envoy Proxy to the Resource

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
  - For HTTPS connection, the **Public Host** needs to match the configured hostname in the resource certificate, however the **Resource Host** just needs to be something the Fyde Access Proxy is able to resolve and access
  - Check more steps by platform below

## Fyde Access Proxy troubleshooting by platform

### Bare Metal / Virtual Machine

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

### Docker

- Confirm that both **envoy-proxy** and **fyde-orchestrator** containers are running

  ```sh
  sudo docker ps
  ```

- Confirm that **envoy-proxy** container is mapping the correct port to the host

  - In the example above, and for the public port 8000 the output should contain the following

  ```sh
  0.0.0.0:8000->8000/tcp
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

### Kubernetes

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

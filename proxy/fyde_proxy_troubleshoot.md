# Troubleshoot

## Test connectivity from the device to the Fyde Access Proxy

- Get the Access Proxy details from the Enterprise Console

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

## Check if the Device is trying to access the Resource with the Fyde App

- Check the IP for the failing Resource, it should return an IP in the 192.0.2.0/24 range

  ```sh
  → nslookup myresource.private
  Server:    192.0.2.2
  Address:   192.0.2.2#53

  Name: myresource.private
  Address: 192.0.2.4
  ```

- Next steps:

  - Confirm that Fyde App is running and the tunnel is started
  - Check that Fyde App is enrolled in a tenant
  - Confirm the Resource is created in the Enterprise Console
  - Resource list update on Fyde App can take up to 15m, force refresh if your Fyde App version allows it

## Test connectivity from the Fyde Access Proxy to the Resource

- The Fyde Access Proxy needs to be able to reach the Resource with the configured properties

- Take note of the following resource:
  - **Resource Name**: My Resource
  - **Public Host**: myresource.private
  - **Resource Host**: myresource.internal
  - **External Port**: 80
  - **Internal Port**: 3000
  - **Access Proxy**: US-EAST-1-PROXY

- Fyde Access Proxy needs to be able to resolve the **Resource Host** record

  ```sh
  → nslookup myresource.internal
  Server:    10.0.0.1
  Address:   10.0.0.1#53

  Name: myresource.internal
  Address: 10.0.0.20
  ```

- For an HTTP resource we could send an HTTP request with curl

  ```sh
  → curl myresource.internal:3000
  HTTP/1.1 200 OK
  [...]
  ```

- For a redis resource we could send the HTTP request through netcat

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

- Check envoy logs

  ```sh
  sudo tail /var/log/envoy/envoy.log -f
  ```

- Check proxy logs

  ```sh
  sudo journalctl -u fydeproxy -f
  ```

- Check firewall rules

  ```sh
  sudo firewall-cmd --list-all-zones
  # or
  sudo iptables -L -xvn
  ```

- Ensure envoy is running

  ```sh
  sudo ps axuww | grep envoy
  ```

- Ensure envoy is listening on the correct port

  ```sh
  sudo ss -anp | grep envoy | grep LISTEN
  # or
  sudo netstat -anp | grep envoy | grep LISTEN
  ```

### Docker

- Confirm that both envoy-proxy and proxy-client containers are running

  ```sh
  sudo docker ps
  ```

- Confirm that envoy is mapping the correct port to the host

  - In the example above, and for the public port 8000 the output should contain the following

  ```sh
  0.0.0.0:8000->8000/tcp
  ```

- Check envoy-proxy logs

  ```sh
  sudo docker logs envoy-proxy -f
  ```

- Check proxy-client logs

  ```sh
  sudo docker logs proxy-client -f
  ```

- Check that docker network is not conflicting with another remote network

  - Check the value for `IPAM.Config.Subnet`

  - For more information check [compose-file/#ipam](https://docs.docker.com/compose/compose-file/#ipam)

  ```sh
  sudo docker network inspect fyde
  ```

### Kubernetes

- Correct the namespace if needed

- Check all deployed resources

  ```sh
  kubectl get all \
    --namespace fyde-proxy
  ```

- Check envoy logs

  ```sh
  kubectl logs \
    -l app=envoy-proxy -f \
    --namespace fyde-proxy
  ```

- Check proxy logs

  ```sh
  kubectl logs \
    -l app=proxy-client -f \
    --namespace fyde-proxy
  ```

- Check that envoy service is properly configured for your environment

  ```sh
  kubectl describe service envoy-proxy \
    --namespace fyde-proxy
  ```

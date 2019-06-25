# Add new resource

To add a new resource, go to **Access tab** and click the **“+”** icon in the top right.

![Control Screen](imgs/access_resources.png)

Fill in the details:

![Add Resource](imgs/access_add_resource.png )

- **Resource Name**: Simple identifier for the resource in the console

- **Public Host**: Hostname used by the Fyde Client (in the device) to redirect the request to the Access Proxy
  - Needs to be a valid DNS record
  - Doesn’t need to exist as a public DNS record, private or at all

- **Resource Host**: Internal resource hostname or IP used by the Access Proxy to connect to
  - Needs to be a hostname or IP that the Access Proxy can resolve and connect to

- **External Port**: Port used for the request to the Public Host from the device

- **Internal Port**: Internal Resource port used by the Fyde Proxy to connect to the Resource Host

- **Access Proxy**: The Access Proxy that will be used and has access to the resource being configured

- **Policy Name**: The policy used to allow access for this resource

- **Notes**: Can be used to add extra information regarding the resource

Please note:

- When accessing an internal resource with HTTPS configured, the **Public Host** needs to match the configured hostname in the resource certificate

To cancel the entry and go back to the **Resources**, click **Cancel**.

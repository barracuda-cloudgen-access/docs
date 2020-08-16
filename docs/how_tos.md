---
title: How to's
has_children: false
nav_order: 8
---
# How to's

## Setting up a Windows Share

To enable a Windows Share, add a resource where the public and internal host are the name of the share and enable ports 139 and 445.

If you are using an active directory domain, the name of the share should be the name of the machine suffixed by the AD domain, for example: `\\machinewithshare.windomain.int\ShareName`. In this case `machinewithshare` is the name of the machine hosting the share folders and `windomain.int` is the AD domain. The domain name to add as a resource would be `machinewithshare.windomain.int`.

## Setting up Azure SQL Server

To set up an Azure SQL Server:

1. Create a new subnet in a VNET that will be used specifically to access the SQL server;
1. Create the proxy VM, attach it to this subnet, and add a publicly accessible IP to it;
1. Enter the SQL Database config and click on "Set server firewall";
1. Add a Virtual Network rule allowing access to the server from the proxy's subnet.

On the Fyde Enterprise Console, create the proxy and the DB resource using the public domain name of the Azure DB (from Azure DB config) and port 1433.

Do not forget to use the same name for the Public Host in the resource as the one Azure assigns; alternatively, pass the domain name of the DB server in the username (for example, `user@somedb.database.windows.net` while logging in).

Finally, you need to change the SQL Server mode to Proxy mode, using the steps listed [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-connectivity-architecture#change-azure-sql-database-connection-policy){:target="_blank"}. You need a CLI or PowerShell console to do it.

---
title: FAQ
has_children: false
nav_order: 7
---
# FAQ

## I uninstalled the Fyde app and am not enrolled in my company/cannot enroll again.

Every time the app is uninstalled, the enrollment information is lost, so you need to enroll again. If you still have enrollment slots available, it suffices to use the same URL, either via the received email or directly. Otherwise, you will need to contact your sysadmin to generate a shareable link with you via Users > Your User > Enrollment under the Fyde Enterprise Console.

## I am having problems with my Azure SQL Server connections.

Azure SQL Servers, by default, use SQL Gateways to receive client connections.
However, it implements a split logic depending if the connection is internal (from inside Azure) or external.

For internal connections, it supports a Redirect mode, where you login and authenticate through the SQL Gateway
(your xxx.database.windows.net); then, it instructs the SQL Client to connect again to a different worker server.
For external connections, it uses a mode called Proxy, where the entirety of the connection goes through the gateway
you connect initially. Please see [the SQL database connectivity docs](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-connectivity-architecture){:target="_blank"} for more info.

When a Fyde Proxy is inside Azure, the SQL Gateway will try to use the redirect mode by default. This secondary connection is to a randomly allocated SQL worker server and, as such, is not caught by the Fyde proxy. In order to make this work with Fyde, please switch the SQL Server to always use Proxy mode. After this change, all traffic will go through the same 1433 port on the same TCP connection instead of using the worker model.

Please check [the Azure SQL server how to]({{ site.baseurl }}{% link how_tos.md %}#setting-up-azure-sql-server) for more information.

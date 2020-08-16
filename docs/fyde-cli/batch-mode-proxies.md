---
layout: default
title: Add and edit proxies
parent: Batch mode operations
grand_parent: Fyde CLI Client
nav_order: 4
---
# Add and edit proxies in batch mode

fyde-cli supports adding and editing proxies in batch mode, importing data from JSON or CSV files.
Batch operations on proxies use the [common batch mode flags]({{ site.baseurl }}{% link fyde-cli/batch-mode-operations.md %}).

JSON files should contain an array of objects, each containing the fields for each proxy one wishes to add or edit.

CSV files should be comma-separated.
They must contain a header, specifying the fields and their order, followed by the records (one per line).

When editing proxies, unspecified non-mandatory fields remain unchanged.

## Fields

The expected fields for each format are as follows:

| JSON field name | JSON type | CSV field name | Example | Description | Mandatory
| --- | --- | --- | --- | --- | --- |
| `id` | string | `ID` | `74bf962e-2082-4f89-ac07-49fb792e09ff` | ID of the proxy to edit.<br>**Used only when editing** | When editing
| `name` | string | `Name` | `GCN Proxy` | Name of the proxy | When adding
| `location` | string | `Location` | `US-East` | Location of the proxy | No
| `host` | string | `Host` | `myproxy.example.com` | Host of the proxy | When adding
| `port` | string (adding) / integer (editing) | `Port` | `9000` | Port of the proxy | When adding

## File examples

Note: field order can be different from what is shown in the examples, and non-mandatory fields can be omitted.
When using CSV, make sure to specify the correct field order in the header, and to maintain the order and number of fields consistent throughout each line.

### Adding proxies

#### JSON

```json
[
    {
        "name": "One Proxy", "location": "US-East",
        "host": "phost1.example.com", "port": "8080"
    },
    {
        "name": "Another Proxy", "location": "EU-Central",
        "host": "phost2.example.com", "port": "9001"
    }
]
```

`$ fyde-cli proxies add --from-file=example.json`

#### CSV

```
Name,Location,Host,Port
One Proxy,US-East,phost1.example.com,8080
Another Proxy,EU-Central,phost2.example.com,9001
```

`$ fyde-cli proxies add --from-file=example.csv --file-format=csv`

### Editing proxies

#### JSON

```json
[
    {
        "id": "1a012898-64a4-49bd-81cf-f240811bc5a7",
        "name": "One Proxy", "location": "US-East",
        "host": "phost1.example.com", "port": 9000
    },
    {
        "id": "bd7b5ec9-30ba-4e18-9513-a58f7d156096",
        "name": "Different Proxy", "location": "EU-Central",
        "host": "newproxy.example.com", "port": 10100
    }
]
```

`$ fyde-cli proxies edit --from-file=example.json`

#### CSV

```
ID,Name,Location,Host,Port
1a012898-64a4-49bd-81cf-f240811bc5a7,One Proxy,US-East,phost1.example.com,9000
bd7b5ec9-30ba-4e18-9513-a58f7d156096,Different Proxy,EU-Central,newproxy.example.com,10100
```

`$ fyde-cli proxies edit --from-file=example.csv --file-format=csv`
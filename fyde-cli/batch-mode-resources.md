---
layout: default
title: Add and edit resources
parent: Batch mode operations
grand_parent: Fyde CLI Client
nav_order: 3
---
# Add and edit resources in batch mode

fyde-cli supports adding and editing resources in batch mode, importing data from JSON or CSV files.
Batch operations on resources use the [common batch mode flags]({{ site.baseurl }}{% link fyde-cli/batch-mode-operations.md %}).

JSON files should contain an array of objects, each containing the fields for each resource one wishes to add or edit.

CSV files should be comma-separated.
They must contain a header, specifying the fields and their order, followed by the records (one per line).

When editing resources, unspecified non-mandatory fields remain unchanged.

## Fields

The expected fields for each format are as follows:

| JSON field name | JSON type | CSV field name | Example | Description | Mandatory
| --- | --- | --- | --- | --- | --- |
| `id` | string | `ID` | `0090b4e1-99d8-46c5-bd80-84fabcd67214` | ID of the resource to edit.<br>**Used only when editing** | When editing
| `name` | string | `Name` | `Gitea` | Name of the resource | When adding
| `public_host` | string | `PublicHost` | `gitea.local` | Public host of the resource | When adding
| `internal_host` | string | `InternalHost` | `gitea.local` | Internal host of the resource | When adding
| `port_mappings` | object | `PortMappings` | _See below_ | Port mappings | When adding
| `access_proxy_id` | string | `AccessProxyID` | `01b79087-2146-4399-802f-30e5fd2e2d8f` | Proxy ID for the resource | When adding
| `enabled` | boolean | `Enabled` | `true` | Whether the resource is enabled | When adding
| `access_policy_ids` | integer array | `AccessPolicyIds` | `[123]` | Resource access policy IDs | No
| `notes` | string | `Notes` | `some notes` | Notes on the resource | No

### `port_mappings`

In JSON, port mappings are specified as follows (`label` is optional):

```json
"port_mappings": [
    {
        "label": "HTTP",
        "public_ports": ["80", "443"],
        "internal_ports": ["80", "443"]
    },
    {
        "label": "Misc. service",
        "public_ports": ["9000-9100", "10000"],
        "internal_ports": ["1000-1100", "2000"]
    }
]
```

In this example, public ports 80, 443 and 10000 are mapped to the internal ports 80, 443 and 2000, respectively, and the public port range 9000 to 9100 (inclusive) is mapped to the internal range 1000 to 1100.

In CSV, port mappings are specified like on the command line.
In this situation, all mappings will be created under the same untitled label.
Refer to the CSV file examples below.

## File examples

Note: field order can be different from what is shown in the examples, and non-mandatory fields can be omitted.
When using CSV, make sure to specify the correct field order in the header, and to maintain the order and number of fields consistent throughout each line.

### Adding resources

#### JSON

```json
[
    {
        "name": "Test Resource 1",
        "access_proxy_id": "609e83f9-8004-4ef0-a3d4-b4c32ba3db4b",
        "enabled": true, "internal_host": "www.example.com",
        "public_host": "www.example.com",
        "port_mappings": [
            { "public_ports": ["80"], "internal_ports": ["80"] }
        ],
        "notes": "batch created"
    },
    {
        "name": "Test Resource 2",
        "access_proxy_id": "609e83f9-8004-4ef0-a3d4-b4c32ba3db4b",
        "enabled": true, "internal_host": "another.example.com",
        "public_host": "another.example.com",
        "port_mappings": [
            { "public_ports": ["80", "443"], "internal_ports": ["80", "443"] }
        ],
        "notes": "batch created"
    }
]
```

`$ fyde-cli resources add --from-file=example.json`

#### CSV

```
Name,PublicHost,InternalHost,Ports,AccessProxyID,Enabled,AccessPolicyIds,Notes
Test Resource 1,www.example.com,www.example.com,"[80:80]",609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch created
Test Resource 2,another.example.com,another.example.com,"[80:80, 443:443]",609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch created
```

`$ fyde-cli resources add --from-file=example.csv --file-format=csv`

### Editing resources

#### JSON

```json
[
    {
        "id": "155cbd52-4e39-4a16-9f59-0cf92f23cf2a",
        "name": "Test Resource 1",
        "access_proxy_id": "609e83f9-8004-4ef0-a3d4-b4c32ba3db4b",
        "enabled": true, "internal_host": "www.example.com",
        "public_host": "www.example.com",
        "port_mappings": [
            { "internal_ports": ["80"], "public_ports": ["80"] }
        ],
        "notes": "batch edited"
    },
    {
        "id": "c665a0f3-7474-416b-826d-9f626e9bc18f",
        "name": "Test Resource 2",
        "access_proxy_id": "609e83f9-8004-4ef0-a3d4-b4c32ba3db4b",
        "enabled": true, "internal_host": "another.example.com",
        "public_host": "another.example.com",
        "port_mappings": [
            { "public_ports": ["80", "443"], "internal_ports": ["80", "8000"] }
        ],
        "notes": "batch edited"
    }
]
```

`$ fyde-cli resources edit --from-file=example.json`

#### CSV

```
ID,Name,PublicHost,InternalHost,Ports,AccessProxyID,Enabled,AccessPolicyIds,Notes
155cbd52-4e39-4a16-9f59-0cf92f23cf2a,Test Resource 1,www.example.com,www.example.com,"[80:80]",609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch edited
c665a0f3-7474-416b-826d-9f626e9bc18f,Test Resource 2,another.example.com,another.example.com,"[80:80, 443:8000]",609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch edited
```

`$ fyde-cli resources edit --from-file=example.csv --file-format=csv`
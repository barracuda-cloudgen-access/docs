---
layout: default
title: Add and edit resources
parent: Batch mode operations
grand_parent: Fyde CLI Client
nav_order: 3
---
# Add and edit resources in batch mode

fyde-cli supports adding and editing resources in batch mode, importing data from JSON or CSV files.
Batch operations on resources use the [common batch mode flags](https://github.com/fyde/fyde-cli/wiki/Common-batch-mode-flags).

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
| `ports` | string array | `Ports` | `["80:80","443:8080"]` | Port mappings. In CSV, surround by quotes | When adding
| `access_proxy_id` | string | `AccessProxyID` | `01b79087-2146-4399-802f-30e5fd2e2d8f` | Proxy ID for the resource | When adding
| `enabled` | boolean | `Enabled` | `true` | Whether the resource is enabled | When adding
| `access_policy_ids` | integer array | `AccessPolicyIds` | `[123]` | Resource access policy IDs | No
| `notes` | string | `Notes` | `some notes` | Notes on the resource | No

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
        "ports": ["80:80"], "notes": "batch created"        
    },
    {
        "name": "Test Resource 2",
        "access_proxy_id": "609e83f9-8004-4ef0-a3d4-b4c32ba3db4b",
        "enabled": true, "internal_host": "another.example.com",
        "public_host": "another.example.com",
        "ports": ["80:80", "443:443"], "notes": "batch created"
    }
]
```

`$ fyde-cli resources add --from-file=example.json`

#### CSV

```
Name,PublicHost,InternalHost,Ports,AccessProxyID,Enabled,AccessPolicyIds,Notes
Test Resource 1,www.example.com,www.example.com,["80:80"],609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch created
Test Resource 2,another.example.com,another.example.com,"[\"80:80\", \"443:443\"]",609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch created
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
        "public_host": "www.example.com", "ports": ["80:80"],
        "notes": "batch edited"        
    },
    {
        "id": "c665a0f3-7474-416b-826d-9f626e9bc18f",
        "name": "Test Resource 2",
        "access_proxy_id": "609e83f9-8004-4ef0-a3d4-b4c32ba3db4b",
        "enabled": true, "internal_host": "another.example.com",
        "public_host": "another.example.com", "ports": ["80:80", "8000:8000"],
        "notes": "batch edited"
    }
]
```

`$ fyde-cli resources edit --from-file=example.json`

#### CSV

```
ID,Name,PublicHost,InternalHost,Ports,AccessProxyID,Enabled,AccessPolicyIds,Notes
155cbd52-4e39-4a16-9f59-0cf92f23cf2a,Test Resource 1,www.example.com,www.example.com,["80:80"],609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch edited
c665a0f3-7474-416b-826d-9f626e9bc18f,Test Resource 2,another.example.com,another.example.com,"[\"80:80\", \"8000:8000\"]",609e83f9-8004-4ef0-a3d4-b4c32ba3db4b,true,[40],batch edited
```

`$ fyde-cli resources edit --from-file=example.csv --file-format=csv`
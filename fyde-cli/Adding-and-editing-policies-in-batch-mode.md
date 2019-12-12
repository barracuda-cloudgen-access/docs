fyde-cli supports adding and editing policies in batch mode, importing data from JSON or CSV files.
Batch operations on policies use the [common batch mode flags](https://github.com/fyde/fyde-cli/wiki/Common-batch-mode-flags).

JSON files should contain an array of objects, each containing the fields for each policy one wishes to add or edit.

CSV files should be comma-separated.
They must contain a header, specifying the fields and their order, followed by the records (one per line).

When editing policies, unspecified non-mandatory fields remain unchanged.

# Fields

The expected fields for each format are as follows:

| JSON field name | JSON type | CSV field name | Example | Description | Mandatory
| --- | --- | --- | --- | --- | --- |
| `id` | integer | `ID` | `123` | ID of the policy to edit.<br>**Used only when editing** | When editing
| `name` | string | `Name` | `Allow QA` | Name of the policy | When adding
| `access_resource_ids` | string array | `AccessResourceIds` | `["2a70f6e3-879d-462d-a14f-c58ccf048b9a"]` | Resource IDs of the policy | No
| `conditions` | object | _Unsupported_ |  | See below | No

## `conditions`

To enable RBAC for this policy, include a `conditions` object as follows:

```json
"conditions": {
    "rbac": {
        "enabled": true,
        "group_ids": [28, 29, 30],
        "user_ids": [247, 45, 46]
    }
}
```

`group_ids` and `user_ids` can be empty arrays.
If both are empty arrays, the policy will deny access to all users and groups.

Specifying RBAC settings is not supported when using the CSV format.

# File examples

Note: field order can be different from what is shown in the examples, and non-mandatory fields can be omitted.
When using CSV, make sure to specify the correct field order in the header, and to maintain the order and number of fields consistent throughout each line.

## Adding policies

### JSON

```json
[
    {
        "name": "Allow QA",
        "access_resource_ids": ["2a70f6e3-879d-462d-a14f-c58ccf048b9a"],
        "conditions": {
            "rbac": {
               "enabled": true,
               "group_ids": [33],
               "user_ids": []
            }
        }
    },
    {
        "name": "Example policy"
    }
]
```

`$ fyde-cli policies add --from-file=example.json`

### CSV

```
Name,AccessResourceIds
Allow QA,[90]
Example policy,[55]
```

`$ fyde-cli policies add --from-file=example.csv --file-format=csv`

## Editing policies

### JSON

```json
[
    {
        "id": 890, "name": "Allow QA and Marketing",
        "access_resource_ids": ["2a70f6e3-879d-462d-a14f-c58ccf048b9a"]
    },
    {
        "id": 893, "name": "Example policy",
        "access_resource_ids": ["f613d08e-4899-4330-9963-267361f09a16"]
    }
]
```

`$ fyde-cli policies edit --from-file=example.json`

### CSV

```
ID,Name,AccessResourceIds
890,Allow QA and Marketing,["2a70f6e3-879d-462d-a14f-c58ccf048b9a"]
893,Example policy,["f613d08e-4899-4330-9963-267361f09a16"]
```

`$ fyde-cli policies edit --from-file=example.csv --file-format=csv`
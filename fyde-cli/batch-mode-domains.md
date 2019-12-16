---
layout: default
title: Add domains
parent: Batch mode operations
grand_parent: Fyde CLI Client
nav_order: 6
---
# Add domains in batch mode

fyde-cli supports adding domains in batch mode, importing data from JSON or CSV files.
This operation uses the [common batch mode flags](https://github.com/fyde/fyde-cli/wiki/Common-batch-mode-flags).

JSON files should contain an array of objects, each containing the fields for each domain one wishes to add.

CSV files should be comma-separated.
They must contain a header, specifying the fields and their order, followed by the records (one per line).

## Fields

The expected fields for each format are as follows:

| JSON field name | JSON type | CSV field name | Example | Description | Mandatory
| --- | --- | --- | --- | --- | --- |
| `name` | string | `Name` | `example.com` | Domain name | Yes
| `asset_source_id` | string | `AssetSourceID` | `d1662335-f4a7-4325-932a-0d0dfc7951f0` | Asset Source ID | Yes
| `category` | string | `Category` | `domain` | Must be `domain` | Yes

## File examples

Note: field order can be different from what is shown in the examples, and non-mandatory fields can be omitted.
When using CSV, make sure to specify the correct field order in the header, and to maintain the order and number of fields consistent throughout each line.

### Adding domains

#### JSON

```json
[
    {
        "name": "one.example.com", "category": "domain",
        "asset_source_id": "f0968915-e227-404b-8ddb-9ac76b8b8be3"
    },
    {
        "name": "another.example.com", "category": "domain",
        "asset_source_id": "94173764-605f-4cd0-b34f-387439667569"
    }
]
```

`$ fyde-cli domains add --from-file=example.json`

#### CSV

```
Name,AssetSourceID,Category
one.example.com,f0968915-e227-404b-8ddb-9ac76b8b8be3,domain
another.example.com,94173764-605f-4cd0-b34f-387439667569,domain
```

`$ fyde-cli domains add --from-file=example.csv --file-format=csv`
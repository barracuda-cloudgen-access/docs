---
layout: default
title: Adding and editing groups in batch mode
parent: Batch mode operations
---

# Adding and editing groups in batch mode

fyde-cli supports adding and editing groups in batch mode, importing data from JSON or CSV files.
Batch operations on groups use the [common batch mode flags](https://github.com/fyde/fyde-cli/wiki/Common-batch-mode-flags).

JSON files should contain an array of objects, each containing the fields for each group one wishes to add or edit.

CSV files should be comma-separated.
They must contain a header, specifying the fields and their order, followed by the records (one per line).

When editing groups, unspecified non-mandatory fields remain unchanged.

## Fields

The expected fields for each format are as follows:

| JSON field name | JSON type | CSV field name | Example | Description | Mandatory
| --- | --- | --- | --- | --- | --- |
| `id` | integer | `ID` | `123` | ID of the group to edit.<br>**Used only when editing** | When editing
| `name` | string | `Name` | `QA` | Name of the group | When adding
| `description` | string | `Description` | `Quality Assurance personnel` | Description of the group | No
| `color` | string | `Color` | `#FF0088` | Color of the group, in HTML hex notation (must include the `#`) | No

## File examples

Note: field order can be different from what is shown in the examples, and non-mandatory fields can be omitted.
When using CSV, make sure to specify the correct field order in the header, and to maintain the order and number of fields consistent throughout each line.

### Adding groups

#### JSON

```json
[
    {
        "name": "Group 1", "description": "First group", "color": "#FF0000"
    },
    {
        "name": "Group 2", "description": "Second group", "color": "#00FF00"
    }
]
```

`$ fyde-cli groups add --from-file=example.json`

#### CSV

```
Name,Description,Color
Group 1,First group,#FF0000
Group 2,Second group,#00FF00
```

`$ fyde-cli groups add --from-file=example.csv --file-format=csv`

### Editing groups

#### JSON

```json
[
    {
        "id": 123, "name": "Group 1",
        "description": "First group", "color": "#5F6600"
    },
    {
        "id": 456, "name": "Another group",
        "description": "Second group", "color": "#11FF44"
    }
]
```

`$ fyde-cli groups edit --from-file=example.json`

#### CSV

```
ID,Name,Description,Color
123,Group 1,First group,#5F6600
456,Another group,Second group,#11FF44
```

`$ fyde-cli groups edit --from-file=example.csv --file-format=csv`
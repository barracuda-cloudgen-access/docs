---
layout: default
title: Add and edit users
parent: Batch mode operations
grand_parent: Fyde CLI Client
nav_order: 1
---
# Add and edit users in batch mode

fyde-cli supports adding and editing users in batch mode, importing data from JSON or CSV files.
Batch operations on users use the [common batch mode flags](https://github.com/fyde/fyde-cli/wiki/Common-batch-mode-flags).

JSON files should contain an array of objects, each containing the fields for each user one wishes to add or edit.

CSV files should be comma-separated.
They must contain a header, specifying the fields and their order, followed by the records (one per line).

When editing users, unspecified non-mandatory fields remain unchanged.

## Fields

The expected fields for each format are as follows:

| JSON field name | JSON type | CSV field name | Example | Description | Mandatory
| --- | --- | --- | --- | --- | --- |
| `id` | integer | `ID` | `123` | ID of the user to edit.<br>**Used only when editing** | When editing
| `name` | string | `Name` | `John Doe` | Name of the user | When adding
| `email` | string | `Email` | `john@site.com` | Email address of the user | No
| `phone_number` | string | `PhoneNumber` | `1234567890` | Phone number of the user | No
| `group_ids` | integer array | `GroupIds` | `[12,56]` | User group IDs. In CSV, surround by quotes | No
| `enabled` | boolean | `Enabled` | `true` | Whether the user is enabled | No
| `send_email`<br>`_invitation` | boolean | `SendEmail`<br>`Invitation` | `false` | Whether to send an email invitation.<br>**Used only when adding** | No

## File examples

Note: field order can be different from what is shown in the examples, and non-mandatory fields can be omitted.
When using CSV, make sure to specify the correct field order in the header, and to maintain the order and number of fields consistent throughout each line.

### Adding users

#### JSON

```json
[
    {
        "name": "User 1", "email": "1@example.com", "phone_number": "123456",
        "group_ids": [34,56], "enabled": true, "send_email_invitation": false
    },
    {
        "name": "User 2", "email": "2@example.com", "phone_number": "644889998",
        "group_ids": [], "enabled": true,  "send_email_invitation": true
    }
]
```

`$ fyde-cli users add --from-file=example.json`

#### CSV

```
Name,Email,PhoneNumber,GroupIds,Enabled,SendEmailInvitation
User 1,1@example.com,123456,"[34,56]",true,false
User 2,2@example.com,644889998,[],true,true
```

`$ fyde-cli users add --from-file=example.csv --file-format=csv`

### Editing users

#### JSON

```json
[
    {
        "id": 12, "name": "User 1", "email": "1@example.com",
        "phone_number": "123456", "group_ids": [], "enabled": false
    },
    {
        "id": 34, "name": "User 2", "email": "2@example.com",
        "phone_number": "644889998", "group_ids": [34,56], "enabled": true
    }
]
```

`$ fyde-cli users edit --from-file=example.json`

#### CSV

```
ID,Name,Email,PhoneNumber,GroupIds,Enabled
12,User 1,1@example.com,123456,[],false
34,User 2,2@example.com,644889998,"[34,56]",true
```

`$ fyde-cli users edit --from-file=example.csv --file-format=csv`
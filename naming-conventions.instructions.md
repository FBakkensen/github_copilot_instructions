---
applyTo: '**/*.al'
---
# Naming Conventions

This document outlines the naming conventions for variables, parameters, and objects in Business Central AL code.

## General Naming Guidelines

- Use PascalCase for all identifiers (objects, variables, parameters, methods)
- Create descriptive names that clearly indicate the purpose
- Avoid abbreviations unless they are widely understood
- Be consistent with naming patterns throughout the codebase
- Follow Microsoft's official AL naming guidelines

## Variables and Parameters

### Record Variables

- Names of variables and parameters of type `Record` should be suffixed with the table name without whitespaces
- For multiple variables of the same record type, use meaningful suffixes

**Wrong:**
```al
JobRecordJob: Record Job;
```

**Right:**
```al
Job: Record Job;
```

### Page Variables

- Names of variables and parameters of type `Page` should be suffixed with the page name without whitespaces

**Wrong:**
```al
JobPage: Page Job;
```

**Right:**
```al
JobPage: Page Job;
```

### Multiple Variables of Same Type

- If there is a need for multiple variables or parameters of the same type, the name must be suffixed with a meaningful name

**Example:**
```al
CustomerNew: Record Customer;
CustomerOld: Record Customer;
```

### Parameter Declaration

- A parameter must only be declared as `var` if necessary (when the parameter needs to be modified)

### Variable Ordering

- Object and complex variable types must be listed first, and then simple variables
- The order is: Record, Report, Codeunit, XmlPort, Page, Query, Notification, BigText, DateFormula, RecordId, RecordRef, FieldRef, and FilterPageBuilder
- The rest of the variables are not sorted

## Object Naming

### Tables and Fields

- Table names should be singular nouns
- Field names should clearly describe the data they contain
- Boolean fields should be named with a positive assertion (e.g., "Is Complete" not "Not Complete")

### Pages

- List pages should be named with the plural form of the entity
- Card pages should be named with "Card" suffix
- Document pages should be named with the document type

### Codeunits

- Codeunits implementing business logic should be named after the functionality they provide
- Utility codeunits should have a suffix indicating their purpose (e.g., "Mgt" for management)
- Event subscriber codeunits should have "Event Subscribers" in their name

### Reports

- Report names should clearly indicate their purpose and output
- Processing reports should include "Processing" in their name

## Prefix Guidelines

1. All objects must have a prefix
2. The prefix is defined in the AppSourceCop.json file
3. The prefix is always in this format '<Prefix> ' where <Prefix> is the prefix defined in the AppSourceCop.json file
4. The prefix is always in uppercase
5. The prefix is always followed by a space
6. The prefix is always just once in the object name
7. The prefix is always in the beginning of the object name

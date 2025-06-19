---
applyTo: '**/*.al'
---
# Object-Specific Guidelines

This document outlines specific guidelines for different object types in Business Central AL code.

## Tables and Table Extensions

- All fields must include a tooltip
- Field numbers in tables must start with the number defined in app.json
- New fields must use the first available number in the range defined in app.json
- Tooltips in fields always start with 'Specifies '
- Fields on tables must have a Dataclassification property set to `CustomerContent`
- Identifiers on fields on tables should not have a prefix
- Identifiers on fields on tableextensions must have a prefix
- Use appropriate field types for the data they will contain
- Implement proper validation for fields
- Use FlowFields and FlowFilters appropriately

## Pages and Page Extensions

- No implicit Rec is allowed
- The layout must be defined before the actions
- Identifiers of fields and actions must not be prefixed
- The properties `Promoted` and `PromotedCategory` must not be used for actions, instead use the actionref syntax
- The identifier for a promoted actionref must have a suffix of `_Promoted`
- Tooltips should be on table fields not on the page fields
- Fields must have an ApplicationArea property set to `All`
- Follow the standard Business Central page layout patterns
- Group related fields together
- Use appropriate FastTabs for organizing content
- Implement proper field validation

## Codeunits

- Procedures must only be marked with `[Scope('OnPrem')]` if this is explicitly stated
- Procedures must follow the Single Responsibility Principle (SRP)
- Check for IsGuiAllowed() before using any GUI functions
- For major functionality create a codeunit with the name of the functionality

### Codeunit Pattern for Major Functionality

```al
codeunit 50100 "My Functionality"
{
    procedure DoSomething(var MyRecord: Record "My Record")
    var
        Handled: Boolean;
    begin
        OnBeforeDoSomething(MyRecord, Handled);
        DoDoSomething(MyRecord, Handled);
        OnAfterDoSomething(MyRecord);
    end;

    local procedure DoDoSomething(var MyRecord: Record "My Record"; var Handled: Boolean)
    begin
        if Handled then
            exit;

        // Implementation here

        Handled := true;
    end;

    [BusinessEvent(false)]
    local procedure OnBeforeDoSomething(var MyRecord: Record "My Record"; var Handled: Boolean)
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnAfterDoSomething(var MyRecord: Record "My Record")
    begin
    end;
}
```

- For small functionality create a codeunit with the name of the functionality and the suffix `Mgt`

## Reports

- Use appropriate data items and columns
- Implement proper filtering options
- Use request pages for user input
- Follow standard Business Central report layouts
- Implement proper error handling
- Use processing-only reports for data manipulation without output
- Optimize report performance for large datasets

## XMLPorts

- Use proper element and attribute naming
- Implement proper validation for imported data
- Handle errors gracefully
- Document the expected XML structure
- Implement proper encoding and character handling
- Consider performance for large XML files

## Queries

- Use appropriate filters and sorting
- Optimize for performance
- Document the purpose and usage of the query
- Consider using queries for complex data retrieval operations
- Implement proper security filtering

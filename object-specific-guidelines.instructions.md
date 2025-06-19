---
applyTo: '**/*.al'
---
---
applyTo: '**/*.al'
---
# Object-Specific Guidelines

> **CONTENT MOVED NOTICE**: This content has been consolidated and enhanced in the CoreDevelopment workflow.

## Consolidated Location

The complete object-specific guidelines have been moved to:
- **Primary Location**: `CoreDevelopment/object-patterns.instructions.md`

This consolidated file includes:
- Table and Table Extension guidelines
- Page and Page Extension patterns
- Codeunit development patterns
- Best practices for each object type
- Complete code examples and templates

## Cross-Reference to Shared Standards

Object development should also follow these shared standards:
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.instructions.md`
- **Code Style**: `SharedGuidelines/Standards/code-style.instructions.md`
- **Error Handling**: `SharedGuidelines/Standards/error-handling.instructions.md`

For detailed object-specific patterns, examples, and advanced guidance, please refer to the consolidated file in the CoreDevelopment workflow.
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

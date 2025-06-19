---
applyTo: '**/*.al'
---
# AL Coding Standards

> **CONSOLIDATED CONTENT NOTICE**: Core coding standards have been consolidated into SharedGuidelines for better organization and to eliminate duplication.

## Consolidated Standards Reference

For complete coding standards and style guidelines, refer to these consolidated locations:

### Core Standards (Apply to All Workflows)
- **Code Style Guidelines**: `SharedGuidelines/Standards/code-style.instructions.md`
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.instructions.md`
- **Error Handling Patterns**: `SharedGuidelines/Standards/error-handling.instructions.md`
- **Core AL Principles**: `SharedGuidelines/Configuration/core-principles.instructions.md`

### Workflow-Specific Standards
- **Object Development Patterns**: `CoreDevelopment/object-patterns.instructions.md`
- **Performance Guidelines**: `PerformanceOptimization/optimization-guide.instructions.md`
- **Testing Standards**: `TestingValidation/testing-strategy.instructions.md`

## Business Central Specific Requirements

### Prefix Guidelines

1. All objects must have a prefix
2. The prefix is defined in the AppSourceCop.json file
3. The prefix is always in this format '<Prefix> ' where <Prefix> is the prefix defined in the AppSourceCop.json file
4. The prefix is always in uppercase
5. The prefix is always followed by a space
6. The prefix is always just once in the object name
7. The prefix is always in the beginning of the object name

### Numbering

- Check that new objects are numbered correctly, that should start with the number defined in app.json
- New objects must use the first available number in the range defined in app.json
- Field numbers in tables must start with the number defined in app.json
- New fields must use the first available number in the range defined in app.json

## Prefix Guidelines

1. All objects must have a prefix
2. The prefix is defined in the AppSourceCop.json file
3. The prefix is always in this format '<Prefix> ' where <Prefix> is the prefix defined in the AppSourceCop.json file
4. The prefix is always in uppercase
5. The prefix is always followed by a space
6. The prefix is always just once in the object name
7. The prefix is always in the beginning of the object name

## Numbering

- Check that new objects are numbered correctly, that should start with the number defined in app.json
- New objects must use the first available number in the range defined in app.json
- Field numbers in tables must start with the number defined in app.json
- New fields must use the first available number in the range defined in app.json

## Text Constants and Localization

- Use text constants or labels for all user-facing strings to support localization
- Define text constants at the beginning of the codeunit or page where they are used
- Use descriptive names for text constants that indicate their purpose
- When using StrSubstNo, always use a text constant or label for the format string
- Format text constant names as: ErrorMsg, ConfirmQst, InfoMsg, etc.
- Example:
  ```al
  var
      TypeMismatchErr: Label 'Field type mismatch: %1 field cannot be mapped to %2 field.';
  begin
      ErrorMessage := StrSubstNo(TypeMismatchErr, Format(CustomFieldType), Format(TargetFieldType));
  end;
  ```

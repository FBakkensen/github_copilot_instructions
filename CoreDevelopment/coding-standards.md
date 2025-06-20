# AL Coding Standards

This document outlines the basic coding standards, patterns, and style guidelines for AL development in Business Central.

## Table of Contents

1. [Basic Coding Standards](#basic-coding-standards)
2. [AL Development Patterns](#al-development-patterns)
3. [Coding Style](#coding-style)
4. [Tooltips](#tooltips)
5. [Prefix Guidelines](#prefix-guidelines)
6. [Numbering](#numbering)
7. [Text Constants and Localization](#text-constants-and-localization)
8. [Search Keywords](#search-keywords)
9. [Cross-References](#cross-references)

## Basic Coding Standards

1. Use PascalCase for public and private members (objects, fields, methods)
2. Create descriptive names for all objects and elements
3. Use object IDs in appropriate ranges defined in app.json
4. Follow Microsoft's official AL style guide
5. Implement proper indentation and spacing for readability

## AL Development Patterns

1. Use the extension model instead of direct base application modifications
2. Leverage event publishers and subscribers for integration points
3. Encapsulate business logic in codeunits
4. Use table and page extensions for modifying existing functionality
5. Implement optimized data access patterns (SetLoadFields, limited record fetching)
6. Apply proper error handling with meaningful error messages
7. Follow modular design principles for maintainability
8. Implement proper permission sets for security
9. Use AL's object-based architecture with appropriate object types
10. Add telemetry for diagnostic purposes

## Coding Style

- Use 4 spaces for indentation
- Use PascalCase for object names, variables, and parameters
- Only use Begin End for multi-line conditions
- Use `if` statements without `begin` and `end` for single-line conditions
- Use Record.IsEmpty() instead of Record.FindSet() or Record.FindFirst() if the queried record is not used
- Prefer early exits in procedures to reduce nesting and improve readability
- Use guard clauses to make all validation at the beginning of a procedure
- Use `exit` to return from a procedure when necessary
- Always use the `this` qualifier when accessing object properties within methods of the same object
- Use text constants or labels for all format strings in StrSubstNo calls to support localization
- Avoid hardcoded strings in error messages and notifications

## Tooltips

- All fields should have tooltips to provide context and guidance to users
- Use the `Tooltip` property in AL to define tooltips for fields, actions, and controls
- Ensure tooltips are concise and informative, helping users understand the purpose and usage of each field or action
- Avoid overly technical jargon in tooltips; aim for clarity and simplicity
- Use consistent terminology and phrasing across tooltips to maintain a cohesive user experience
- Review and update tooltips regularly to ensure they reflect any changes in functionality or user interface
- Tooltips on fields must start with 'Specifies' to maintain consistency and clarity

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

## Search Keywords

### AL Language Keywords
**Coding Standards**: PascalCase, object naming, field naming, method naming, AL style guide
**Object Development**: Table creation, page layout, codeunit architecture, object IDs, numbering
**Code Patterns**: Extension model, event programming, business logic encapsulation

### Business Central Concepts
**Development Standards**: Coding patterns, style guidelines, prefix requirements, AppSource compliance
**Object Structure**: Table fields, page controls, codeunit procedures, object properties
**Localization**: Text constants, labels, multilingual support, user interface text

### Development Patterns
**Code Quality**: Consistent formatting, readable code, maintainable structure, documentation
**Best Practices**: AL development patterns, Microsoft guidelines, quality standards
**Project Standards**: Naming conventions, numbering schemes, prefix guidelines, team consistency

## Cross-References

### Related SharedGuidelines
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.md` - Detailed naming rules and patterns
- **Code Style**: `SharedGuidelines/Standards/code-style.md` - Comprehensive formatting guidelines
- **Error Handling**: `SharedGuidelines/Standards/error-handling.md` - Text constant and error message patterns

### Related CoreDevelopment Files
- **AL Development Guide**: `CoreDevelopment/al-development-guide.md` - Comprehensive development standards
- **Object Patterns**: `CoreDevelopment/object-patterns.md` - Specific object creation patterns

### Workflow Applications
- **TestingValidation**: Apply coding standards to test code development
- **PerformanceOptimization**: Maintain standards while implementing optimizations
- **AppSourcePublishing**: Ensure standards compliance for marketplace requirements
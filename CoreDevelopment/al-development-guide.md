# AL Development Standards for Business Central

You are an expert AL developer assistant specialized in Microsoft Dynamics 365 Business Central development. Your primary function is to help create efficient, maintainable, and compliant AL code for Business Central extensions, with particular focus on AppSource-ready applications.

> **Note:** Always refer to the official Microsoft documentation for the most up-to-date information on AL programming for Business Central.
> [Business Central AL Programming Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-programming-in-al)

## Table of Contents

### Quick Navigation
- [Quick Reference](#quick-reference) - Essential AL development rules and patterns
- [Common Scenarios](#common-scenarios) - Typical development use cases
- [Troubleshooting](#troubleshooting) - Problem resolution guidance

### Detailed Content
1. [Core Principles](#core-principles)
2. [General Instructions for AI Assistant](#general-instructions-for-ai-assistant)
   - [Code Quality and Standards](#code-quality-and-standards)
   - [Project Structure](#project-structure)
   - [Implementation Guidelines](#implementation-guidelines)
3. [AL Language Best Practices](#al-language-best-practices)
4. [Data Access Patterns](#data-access-patterns)
5. [Business Logic Implementation](#business-logic-implementation)
6. [User Interface Guidelines](#user-interface-guidelines)
7. [Performance Optimization](#performance-optimization)
8. [Error Handling Patterns](#error-handling-patterns)
9. [Integration Standards](#integration-standards)
10. [Testing Approaches](#testing-approaches)
11. [Search Keywords](#search-keywords)
12. [Cross-References](#cross-references)

## Core Principles

When developing for Business Central, always follow these core principles:

1. Write clean, maintainable code that follows AL best practices
2. Optimize for performance, especially for operations that may handle large datasets
3. Follow the extension model rather than modifying base application directly
4. Implement proper error handling with meaningful, actionable messages
5. Use consistent naming conventions and coding style
6. Ensure your extensions integrate seamlessly with the Business Central user experience
7. Follow Microsoft's requirements for AppSource publication when applicable

# General Instructions for AI Assistant

## Code Quality and Standards

1. **Always Check for Linter Errors**: Before completing any code changes, check for and fix linter errors in the affected files. Use the diagnostics tool to identify issues and ensure the code follows AL best practices.

2. **Follow AL Code Style Guidelines**: Adhere to the AL code style guidelines specified in the `al_code_style.md` file. This includes proper variable naming, code formatting, object property qualification, and string formatting.

3. **Maintain Backward Compatibility**: When modifying existing code, ensure backward compatibility unless explicitly instructed otherwise. Preserve method signatures and parameters.

4. **Document Code Changes**: Add appropriate comments to explain complex logic or business rules. Use XML documentation comments for procedures.

## Project Structure

1. **Respect Existing Architecture**: Follow the existing architectural patterns and design principles in the codebase.

2. **Use Proper Object IDs**: When creating new objects, use the appropriate ID ranges as defined in the project.

3. **Maintain Object Naming Conventions**: Follow the established naming conventions for objects, including the required prefix "NALICF".

## Implementation Guidelines

1. **Centralized Utilities**: Use centralized utility codeunits when available instead of duplicating functionality.

2. **Error Handling**: Implement proper error handling with descriptive error messages.

3. **Performance Considerations**: Write code with performance in mind, especially for operations that might be executed frequently.

4. **Testing**: Consider testability when implementing new features or modifying existing ones.

## Before Submitting Changes

1. **Review Code**: Review the code for logical errors, edge cases, and potential improvements.

2. **Check for Linter Errors**: Ensure there are no linter errors in the modified files.

3. **Verify Functionality**: Confirm that the implemented changes meet the requirements and work as expected.

4. **Document Decisions**: Document any significant decisions or trade-offs made during implementation.

By following these instructions, you'll contribute high-quality, maintainable code to the project.


# AL Code Style Guidelines

This document outlines the coding standards and best practices for AL code in this project. Following these guidelines ensures consistent, maintainable, and high-quality code.

## Variable Naming Conventions

1. **PascalCase for Object Names**: Use PascalCase for all object names (tables, pages, codeunits, etc.)
   ```al
   codeunit 50100 "Sales Order Processor"
   ```

2. **PascalCase for Variable Names**: Use PascalCase for all variable names
   ```al
   var
       Customer: Record Customer;
       SalesHeader: Record "Sales Header";
       TotalAmount: Decimal;
   ```

3. **Prefix Temporary Variables**: Use prefix 'Temp' for temporary records
   ```al
   var
       TempSalesLine: Record "Sales Line" temporary;
   ```

4. **Variable Declaration Order**: Variables should be ordered by type in the following sequence:
   - Record
   - Report
   - Codeunit
   - XmlPort
   - Page
   - Query
   - Notification
   - BigText
   - DateFormula
   - RecordId
   - RecordRef
   - FieldRef
   - FilterPageBuilder
   - Other types (Text, Integer, Decimal, etc.)

## Code Formatting and Indentation

1. **Indentation**: Use 4 spaces for indentation (not tabs)

2. **Line Length**: Keep lines under 120 characters when possible

3. **Braces**: Place opening braces on the same line as the statement
   ```al
   if Customer.Find() then begin
       // Code here
   end;
   ```

4. **BEGIN..END Usage**: Only use BEGIN..END to enclose compound statements (multiple lines)
   ```al
   // Correct
   if Customer.Find() then
       Customer.Delete();

   // Also correct (for multiple statements)
   if Customer.Find() then begin
       Customer.CalcFields("Balance (LCY)");
       Customer.Delete();
   end;
   ```

5. **IF-ELSE Structure**: Each 'if' keyword should start a new line
   ```al
   if Condition1 then
       Statement1
   else if Condition2 then
       Statement2
   else
       Statement3;
   ```

6. **CASE Statement**: Use CASE instead of nested IF-THEN-ELSE when comparing the same variable against multiple values
   ```al
   // Instead of this:
   if Type = Type::Item then
       ProcessItem()
   else if Type = Type::Resource then
       ProcessResource()
   else
       ProcessOther();

   // Use this:
   case Type of
       Type::Item:
           ProcessItem();
       Type::Resource:
           ProcessResource();
       else
           ProcessOther();
   end;
   ```

## Object Property Qualification

1. **Use "this" Qualification**: Always use "this" to qualify object properties when accessing them from within the same object
   ```al
   // In a table or page method
   procedure SetStatus(NewStatus: Enum "Status")
   begin
       this.Status := NewStatus;
       this.Modify();
   end;
   ```

2. **Explicit Record References**: Always use explicit record references when accessing fields
   ```al
   // Correct
   Customer.Name := 'CRONUS';

   // Incorrect
   Name := 'CRONUS';
   ```

## String Formatting

1. **Text Constants for String Formatting**: Use text constants for string formatting instead of hardcoded strings
   ```al
   // Define at the top of the object
   var
       CustomerCreatedMsg: Label 'Customer %1 has been created.';

   // Use in code
   Message(CustomerCreatedMsg, Customer."No.");
   ```

2. **String Concatenation**: Use string formatting instead of concatenation
   ```al
   // Instead of this:
   Message('Customer ' + Customer."No." + ' has been created.');

   // Use this:
   Message(CustomerCreatedMsg, Customer."No.");
   ```

3. **Placeholders**: Use numbered placeholders (%1, %2, etc.) in labels
   ```al
   ErrorMsg: Label 'Cannot delete %1 %2 because it has %3 entries.';
   ```

## Error Handling

1. **Descriptive Error Messages**: Provide clear, actionable error messages
   ```al
   if not Customer.Find() then
       Error(CustomerNotFoundErr, CustomerNo);
   ```

2. **Error Constants**: Define error messages as constants
   ```al
   CustomerNotFoundErr: Label 'Customer %1 does not exist.';
   ```

## Comments

1. **Procedure Comments**: Document the purpose of procedures, parameters, and return values
   ```al
   /// <summary>
   /// Calculates the total amount for a sales document.
   /// </summary>
   /// <param name="DocumentType">The type of the sales document.</param>
   /// <param name="DocumentNo">The number of the sales document.</param>
   /// <returns>The total amount of the sales document.</returns>
   procedure CalculateTotalAmount(DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20]): Decimal
   ```

2. **Code Comments**: Add comments to explain complex logic or business rules

## Removing Unused Variables

1. **Remove Unused Variables**: Delete variables that are declared but not used in the code
   ```al
   // If TempRecord is never used, remove it
   var
       Customer: Record Customer;
       // TempRecord: Record "Temp Record";  // Unused - should be removed
   ```

## Performance Considerations

1. **Use FindSet() with Repeat-Until**: For looping through records
   ```al
   if SalesLine.FindSet() then
       repeat
           // Process each record
       until SalesLine.Next() = 0;
   ```

2. **Use SetRange/SetFilter Before Find**: Limit record sets before processing
   ```al
   Customer.SetRange("Country/Region Code", 'US');
   if Customer.FindSet() then
   ```

By following these guidelines, you'll create more maintainable, readable, and efficient AL code.

# Performance Optimization Guidelines

This document outlines best practices for optimizing AL code performance in Business Central.

## Database Operations

### Minimize Database Operations Through Efficient Filtering

- Use appropriate filters before reading records
- Use SetLoadFields() to load only needed fields
- Use SetRange/SetFilter with indexed fields when possible
- Avoid using FIND('-') without filters

### Avoid Nested Database Loops

- Never put database calls inside loops if possible
- Use temporary tables to store intermediate results
- Consider using queries for complex data retrieval
- Use bulk operations instead of record-by-record processing

### Use TempTables for Intermediate Data

- Declare record variables as temporary for in-memory operations
- Process data in memory before writing to database
- Use temporary tables for sorting and filtering operations

### Implement Proper Transaction Handling

- Keep transactions as short as possible
- Avoid user interaction during transactions
- Use LockTable() only when necessary and as late as possible
- Consider using snapshot isolation for read operations

## UI Performance

### Minimize Code in OnAfterGetRecord Triggers

- Move complex calculations to separate procedures
- Use CurrPage.UPDATE(FALSE) to avoid unnecessary refreshes
- Consider using background tasks for heavy calculations

### Use FlowFields and FlowFilters Appropriately

- Avoid excessive CALCFIELDS calls, especially in loops
- Use SetAutoCalcFields only for fields that are always needed
- Consider using normal fields with manual updates for frequently accessed calculated values

### Optimize UI Performance

- Use DisableControls/EnableControls when updating multiple records
- Implement virtual scrolling for large datasets
- Minimize the number of visible fields on list pages
- Use page extensions instead of replacing entire pages

## Background Processing

### Implement Background Processing for Long-Running Operations

- Use StartSession for non-interactive processing
- Consider job queue entries for scheduled operations
- Implement proper progress reporting for long-running tasks

## Report Optimization

### Optimize Report Performance

- Use appropriate filters to limit data retrieval
- Consider using processing-only reports for data manipulation
- Use temporary tables to prepare data before rendering

## SQL Optimization

### Optimize SQL Queries

- Use indexed fields in filters and sorting
- Avoid complex calculations in WHERE clauses
- Use EXISTS/IN instead of joins when appropriate
- Monitor and optimize slow-running queries

## Caching

### Implement Caching for Frequently Accessed Data

- Cache lookup values that don't change frequently
- Use application cache for shared data
- Implement proper cache invalidation when data changes

## Performance Monitoring

### Monitor and Measure Performance

- Implement telemetry to track operation durations
- Use the performance profiler to identify bottlenecks
- Set up alerts for slow-running operations
- Regularly review performance metrics

# Business Central Integration Standards

This document outlines best practices for integrating with Business Central and ensuring a consistent user experience.

## User Experience Integration

1. Respect the standard Business Central user experience patterns
2. Use standard controls and UI patterns
3. Follow the Business Central action patterns
4. Implement proper field validation
5. Apply personalization capabilities where appropriate
6. Consider multi-language support
7. Implement proper dimension support
8. Follow Business Central API design principles

## Event-Based Integration

1. Use event publishers and subscribers for loose coupling between modules
2. Implement proper event handling with clear documentation
3. Follow the standard event naming conventions:
   - OnBefore[Action]
   - OnAfter[Action]
   - On[Action]
4. Use business events for integration points that may be consumed by other extensions

## API Integration

1. Follow RESTful API design principles
2. Implement proper authentication and authorization
3. Use standard Business Central API endpoints when available
4. Document all API endpoints thoroughly
5. Implement proper error handling and status codes
6. Consider rate limiting and throttling for high-volume integrations
7. Use OData standards for query parameters and filtering

## External System Integration

1. Use proper authentication mechanisms for external systems
2. Implement retry logic for external API calls
3. Handle timeouts and connection issues gracefully
4. Log all integration activities for troubleshooting
5. Implement proper error handling for external system failures
6. Consider using queues for asynchronous processing
7. Implement proper data validation before sending to external systems

## Integration Security

1. Never store credentials in code or configuration files
2. Use OAuth or other secure authentication methods
3. Implement proper error handling that doesn't expose sensitive information
4. Validate all input from external systems
5. Implement proper logging for security events
6. Follow the principle of least privilege for integration accounts
7. Regularly review and update integration security measures

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

## Quick Reference

### Essential AL Development Rules
- **Follow Extension Model**: Never modify base application, use table/page extensions
- **Use Proper Naming**: Follow PascalCase, meaningful names, consistent terminology
- **Implement Error Handling**: Actionable error messages with user guidance
- **Optimize Performance**: Use SetLoadFields, avoid nested loops, proper filtering
- **Maintain Code Quality**: Always check for linter errors, follow style guidelines

### Common Development Patterns
```al
// Standard object creation with prefix
table 50100 "ABC Custom Table"
{
    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; Description; Text[100]) { }
    }
}

// Performance-optimized record access
Customer.SetLoadFields("No.", Name, "E-Mail");
if Customer.FindSet() then
    repeat
        // Process each record
    until Customer.Next() = 0;
```

## Search Keywords

### AL Language Keywords
**Object Types**: Table, Page, Codeunit, Report, XMLport, Query, Enum, Interface, ControlAddIn
**AL Syntax**: Procedure, trigger, field, key, flowfield, var, begin, end, case, if-then-else
**Data Access**: SetLoadFields, SetRange, FindSet, Insert, Modify, Delete, record processing

### Business Central Concepts
**Extension Development**: Table extension, page extension, extension model, AppSource publishing
**Business Logic**: Workflows, validation, integration, API development, event handling
**User Experience**: Pages, actions, factboxes, navigation, accessibility, tooltips

### Development Patterns
**Code Quality**: AL best practices, coding standards, maintainable code, performance optimization
**Architecture**: Object patterns, design principles, modular development, separation of concerns
**Integration**: Event-based programming, web services, APIs, external system connectivity

## Cross-References

### Related SharedGuidelines
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.md` - Object and variable naming rules
- **Code Style**: `SharedGuidelines/Standards/code-style.md` - Formatting and style standards  
- **Error Handling**: `SharedGuidelines/Standards/error-handling.md` - Error handling best practices
- **Core Principles**: `SharedGuidelines/Configuration/core-principles.md` - Development foundation

### Related CoreDevelopment Files
- **Coding Standards**: `CoreDevelopment/coding-standards.md` - Basic coding patterns and standards
- **Object Patterns**: `CoreDevelopment/object-patterns.md` - Specific object creation patterns

### Workflow Transitions
- **From**: `SharedGuidelines/Configuration/core-principles.md` - Apply foundational principles
- **To**: `TestingValidation/testing-strategy.md` - Validate development with comprehensive testing
- **To**: `PerformanceOptimization/optimization-guide.md` - Optimize developed solutions
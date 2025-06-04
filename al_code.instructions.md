---
applyTo: '**/*.al'
---
# AL Development Standards for Business Central

You are an expert AL developer assistant specialized in Microsoft Dynamics 365 Business Central development. Your primary function is to help create efficient, maintainable, and compliant AL code for Business Central extensions, with particular focus on AppSource-ready applications.

> **Note:** Always refer to the official Microsoft documentation for the most up-to-date information on AL programming for Business Central.
> [Business Central AL Programming Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-programming-in-al)

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

# AL Coding Standards

This document outlines the basic coding standards, patterns, and style guidelines for AL development in Business Central.

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

  # Project Structure Guidelines

## Documentation and Working Files Organization

This project follows a standardized structure for AI-assisted development:

### Documentation Folders

- `.aidocs/`: Contains the comprehensive project documentation
  - Generated documentation about architecture, data models, and code organization
  - Serves as the knowledge base for understanding the entire project

### Working Documents

- `.aiwork/`: Contains working documents for current feature development
  - Feature specifications
  - Implementation notes
  - Testing guidelines for the current work

## Using These Folders with Augment Code

When working with Augment Code:

1. Reference the `.aidocs/` folder for questions about overall project structure, architecture, and existing functionality
2. Use the `.aiwork/` folder for context about the current feature being developed
3. When starting a new feature, create appropriate documentation in the `.aiwork/` folder

## Standard Paths

- Project documentation: `./.aidocs/**/*.md`
- Current work: `./.aiwork/**/*`

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

# Linter Check Instructions

## Always Check for Linter Errors

Before completing any code changes, always check for and fix linter errors in the affected files. This ensures that the code follows AL best practices and coding standards.

## Steps to Check and Fix Linter Errors

1. **Identify Affected Files**: Determine which files have been modified or created during the implementation.

2. **Run Diagnostics**: Use the diagnostics tool to check for linter errors in the affected files.
   ```
   diagnostics(["path/to/file1.al", "path/to/file2.al"])
   ```

3. **Fix Common Linter Errors**:
   - Remove unused variables
   - Order variable declarations by type
   - Replace nested if-then-else structures with case statements
   - Ensure proper use of BEGIN..END blocks
   - Make sure 'if' keywords start on a new line
   - Use "this" qualification for object properties
   - Use text constants for string formatting

4. **Recheck After Fixes**: After making changes, run diagnostics again to ensure all linter errors have been resolved.

5. **Document Any Remaining Issues**: If any linter errors cannot be fixed (e.g., due to compatibility concerns), document the reason.

## Example Linter Error Fixes

### Unused Variables
```al
// Before
var
    Customer: Record Customer;
    TempSalesLine: Record "Sales Line" temporary; // Unused

// After
var
    Customer: Record Customer;
```

### Variable Declaration Order
```al
// Before
var
    TotalAmount: Decimal;
    Customer: Record Customer;

// After
var
    Customer: Record Customer;
    TotalAmount: Decimal;
```

### Replace IF-THEN-ELSE with CASE
```al
// Before
if FieldNo = Customer.FieldNo(Name) then
    ProcessName()
else if FieldNo = Customer.FieldNo(Address) then
    ProcessAddress()
else
    ProcessOther();

// After
case FieldNo of
    Customer.FieldNo(Name):
        ProcessName();
    Customer.FieldNo(Address):
        ProcessAddress();
    else
        ProcessOther();
end;
```

### Proper BEGIN..END Usage
```al
// Before
if Customer.Find() then begin
    Customer.Delete();
end;

// After
if Customer.Find() then
    Customer.Delete();
```

### 'if' Keywords on New Lines
```al
// Before
if Condition1 then
    Statement1
else if Condition2 then
    Statement2;

// After
if Condition1 then
    Statement1
else
if Condition2 then
    Statement2;
```

By following these instructions, you'll maintain high code quality and consistency throughout the project.


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

# Error Handling Best Practices

This document outlines best practices for error handling in Business Central AL code.

## Actionable Error Handling

1. Always use actionable error handling that helps users understand and resolve issues. Error messages should:
   - Clearly explain what went wrong
   - Provide context about why it happened
   - Offer guidance on how to fix the problem
   - When possible, include actions the user can take directly from the error

2. Use AL's error handling mechanisms appropriately:
   - Use `Error` for critical errors that should stop processing
   - Use `Message` for informational messages that don't stop processing
   - Use `Confirm` when user confirmation is required before proceeding
   - Use `StrMenu` when the user needs to make a choice

## Implementation Examples

### Actionable Error Messages

```al
// Define the error message with action
ActionableErr: Label 'The customer %1 has no email address. Would you like to add one now?', Comment = '%1 = Customer No.';

// Use in code
if Customer."E-Mail" = '' then
    Error(ActionableErr, Customer."No.");
```

### Error Callstack

```al
ErrorInfo.Create(StrSubstNo(SomeErrorMsg, SomeValue));
ErrorInfo.AddAction(ActionMsg, Codeunit::"Some Handler", 'SomeMethod');
ErrorInfo.Recall();
```

### TryFunction Implementation

```al
[TryFunction]
local procedure TryDoSomething(var MyRecord: Record "My Record")
begin
    // Code that might fail
    MyRecord.Insert(true);
end;
```

### Checking TryFunction Results

```al
if not TryDoSomething(MyRecord) then begin
    ErrorMessage := GetLastErrorText();
    ClearLastError();
    Error(CannotCreateRecordErr, MyRecord."No.", ErrorMessage);
end;
```

## Best Practices

### Use Labels for Error Messages

```al
ErrorMsg: Label 'Cannot delete %1 because it is used in %2. Please remove the references first.', Comment = '%1 = Record ID, %2 = Table Name';
// Later in code
Error(ErrorMsg, RecordID, TableName);
```

### Validate Input Parameters

```al
if Customer."No." = '' then
    Error(MissingCustomerNoErr, Customer.TableCaption());
```

### Avoid TestField Without Context

```al
// Instead of:
Customer.TestField("E-Mail");

// Use this for more context and actionability:
if Customer."E-Mail" = '' then
    Error(MissingEmailErr, Customer."No.", Customer.Name, CustomerCardPageId);
```

### Log Significant Errors

Always log significant errors for diagnostics and troubleshooting. This helps with:
- Identifying recurring issues
- Understanding error patterns
- Improving application stability
- Providing better customer support

# AppSource Requirements

This document outlines the requirements for creating AppSource-ready extensions for Business Central.

## App Identity and Metadata

1. Proper app identity in app.json:
   - Unique publisher name
   - Unique app ID
   - Descriptive app name
   - Proper version numbering
   - Accurate app description
   - Appropriate app category

2. Clear dependency management:
   - Explicitly declare all dependencies
   - Use proper version ranges for dependencies
   - Minimize dependencies when possible
   - Test with all supported versions of dependencies

## Documentation Requirements

1. Comprehensive application documentation:
   - User guides
   - Administrator guides
   - Installation instructions
   - Configuration guides
   - Troubleshooting information

2. Per-object documentation:
   - XML documentation comments for public methods
   - Clear descriptions of object purpose
   - Parameter documentation
   - Return value documentation
   - Exception documentation

## Technical Requirements

1. Implementation of telemetry:
   - Track usage patterns
   - Monitor performance
   - Log errors and exceptions
   - Implement proper telemetry privacy controls

2. Proper error handling and user feedback:
   - Actionable error messages
   - Clear user guidance
   - Proper error logging
   - Graceful degradation on failure

3. Compliance with Microsoft's technical validation requirements:
   - Pass all AppSource validation tests
   - Follow all Business Central design guidelines
   - Implement proper security measures
   - Follow performance best practices

## Localization and Accessibility

1. Multi-language support when appropriate:
   - Use label system for all user-facing text
   - Implement proper translation workflow
   - Test with all supported languages
   - Consider cultural differences in design

2. Accessibility compliance:
   - Follow WCAG guidelines
   - Test with screen readers
   - Implement proper keyboard navigation
   - Use appropriate color contrast

## Upgrade and Maintenance

1. Proper upgrade code path:
   - Implement upgrade codeunits
   - Handle data schema changes gracefully
   - Provide clear upgrade documentation
   - Test upgrade scenarios thoroughly

2. Maintenance plan:
   - Regular updates and bug fixes
   - Security patch process
   - Customer support channels
   - Feedback mechanism

# Error Handling Best Practices

This document outlines best practices for error handling in Business Central AL code.

## Table of Contents

1. [Actionable Error Handling](#actionable-error-handling)
2. [Implementation Examples](#implementation-examples)
   - [Actionable Error Messages](#actionable-error-messages)
   - [Structured Error Handling](#structured-error-handling)
   - [User-Friendly Messages](#user-friendly-messages)
3. [Error Prevention Strategies](#error-prevention-strategies)
4. [Search Keywords](#search-keywords)
5. [Cross-References](#cross-references)

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

## Search Keywords

### AL Language Keywords
**Error Handling**: Error, Message, Confirm, StrMenu, TestField, exception handling, try/catch patterns
**User Experience**: Actionable errors, user guidance, error messages, confirmation dialogs
**AL Syntax**: Error procedures, message functions, user interaction, dialog boxes

### Business Central Concepts
**Error Management**: Error prevention, validation, data integrity, business rules enforcement
**User Interface**: User-friendly messages, guidance provision, action suggestions, error recovery
**Application Quality**: Error logging, diagnostics, troubleshooting, stability improvement

### Development Patterns
**Best Practices**: Actionable error handling, meaningful messages, context provision, error prevention
**Code Quality**: Proper error handling, user experience optimization, maintainable error patterns
**Quality Assurance**: Error validation, testing error scenarios, error message standards

## Cross-References

### Related SharedGuidelines
- **Code Style**: `SharedGuidelines/Standards/code-style.md` - Text constant formatting and error message style
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.md` - Error variable and message naming
- **Core Principles**: `SharedGuidelines/Configuration/core-principles.md` - Quality and user experience principles

### Workflow Applications
- **CoreDevelopment**: Implementation of error handling in object development
- **TestingValidation**: Error handling validation and testing error scenarios
- **PerformanceOptimization**: Error handling performance considerations
- **AppSourcePublishing**: Error handling compliance for marketplace requirements

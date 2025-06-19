---
applyTo: '**/*.al'
---
---
applyTo: '**/*.al'
---
# Linter Check Instructions

> **CONTENT MOVED NOTICE**: This content has been consolidated and enhanced in the TestingValidation workflow.

## Consolidated Location

The complete linter check procedures and quality validation guidelines have been moved to:
- **Primary Location**: `TestingValidation/quality-validation.instructions.md`

This consolidated file includes:
- Comprehensive linter error checking procedures
- Steps to identify and fix common linter errors
- Code quality validation processes
- Examples of linter error fixes
- Best practices for maintaining code quality

## Quick Reference

**Key Process**: Always check for and fix linter errors before completing any code changes using the diagnostics tool to ensure code follows AL best practices.

## Cross-Reference to Standards

Quality validation should also follow these shared standards:
- **Code Style**: `SharedGuidelines/Standards/code-style.instructions.md`
- **Error Handling**: `SharedGuidelines/Standards/error-handling.instructions.md`
- **Testing Strategy**: `TestingValidation/testing-strategy.instructions.md`

For detailed linter procedures, examples, and advanced quality validation guidance, please refer to the consolidated file in the TestingValidation workflow.
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

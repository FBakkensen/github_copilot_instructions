---
applyTo: '**/*.al'
---
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

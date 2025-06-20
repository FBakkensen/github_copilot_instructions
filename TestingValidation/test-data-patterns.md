# Test Data Generation Patterns

This document outlines comprehensive patterns and best practices for generating test data in Business Central AL test libraries and test codeunits.

## Table of Contents

### Quick Navigation
- [Quick Reference](#quick-reference) - Essential test data rules and X prefix requirements
- [Common Patterns](#common-patterns) - Typical test data generation scenarios
- [Troubleshooting](#troubleshooting) - Test data conflict resolution

### Detailed Content
1. [Test Data Prefixing Requirements](#test-data-prefixing-requirements)
   - [Code and Text Field Prefixes](#code-and-text-field-prefixes)
   - [Best Practices for Prefixing](#best-practices-for-prefixing)
2. [Test Data Generation Patterns](#test-data-generation-patterns)
3. [Data Isolation Strategies](#data-isolation-strategies)
4. [Test Data Cleanup](#test-data-cleanup)
5. [Advanced Test Data Scenarios](#advanced-test-data-scenarios)
6. [Performance Considerations](#performance-considerations)
7. [Search Keywords](#search-keywords)
8. [Cross-References](#cross-references)

## Test Data Prefixing Requirements

### Code and Text Field Prefixes

When generating test data in Library files and test codeunits, always prefix Code and Text fields with 'X' to ensure the data does not conflict with existing data in the database.

**This requirement applies to:**
- Test Library codeunits
- Test codeunits
- Any procedure that creates test data

**Examples:**

```al
// In a test library codeunit
procedure CreateTestCustomer(var Customer: Record Customer)
begin
    Customer.Init();
    Customer."No." := 'XTEST001';  // Prefixed with 'X'
    Customer.Name := 'XTest Customer Name';  // Prefixed with 'X'
    Customer.Address := 'XTest Street 123';  // Prefixed with 'X'
    Customer.Insert(true);
end;

procedure CreateTestItem(var Item: Record "Item")
begin
    Item.Init();
    Item."No." := 'XITEM001';  // Prefixed with 'X'
    Item.Description := 'XTest Item Description';  // Prefixed with 'X'
    Item."Base Unit of Measure" := 'XPCS';  // Prefixed with 'X'
    Item.Insert(true);
end;
```

### Unique Test Data Generation

For generating unique test data, combine the 'X' prefix with incremental numbers or GUIDs:

```al
procedure CreateUniqueCustomerNo(): Code[20]
var
    Counter: Integer;
begin
    Counter := GetNextCounter();
    exit('XCUST' + Format(Counter).PadLeft(5, '0'));  // Returns: XCUST00001, XCUST00002, etc.
end;

procedure CreateUniqueDescription(): Text[100]
begin
    exit('XTest ' + Format(CreateGuid()).Substring(1, 8));  // Returns: XTest 12345678
end;
```

## Best Practices for Test Data

### 1. Use Consistent Prefixes

Always use the 'X' prefix consistently across all test data to make it easily identifiable:

```al
// Good
Customer."No." := 'XCUST001';
Vendor."No." := 'XVEND001';
Item."No." := 'XITEM001';

// Bad - inconsistent prefixing
Customer."No." := 'TESTCUST001';
Vendor."No." := 'V001';
Item."No." := 'XITEM001';
```

### 2. Clean Up Test Data

Always clean up test data after tests complete:

```al
[Test]
procedure TestCustomerCreation()
var
    Customer: Record Customer;
begin
    // Arrange
    CreateTestCustomer(Customer);

    // Act & Assert
    // ... test logic ...

    // Cleanup
    Customer.Delete(true);
end;
```

### 3. Use Library Functions

Create reusable library functions for common test data scenarios:

```al
codeunit 50100 "Test Data Library"
{
    procedure CreateCustomerWithEmail(var Customer: Record Customer)
    begin
        CreateTestCustomer(Customer);
        Customer."E-Mail" := 'Xtest@example.com';  // Prefixed email
        Customer.Modify(true);
    end;

    procedure CreateItemWithInventory(var Item: Record Item; Quantity: Decimal)
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        CreateTestItem(Item);
        // Create inventory using prefixed batch names
        CreateItemJournalLine(ItemJournalLine, 'XTEST', Item."No.", Quantity);
        PostItemJournal(ItemJournalLine);
    end;
}
```

### 4. Document Test Data Patterns

Document the test data patterns used in your test libraries:

```al
/// <summary>
/// Creates a test customer with the pattern XCUST##### where ##### is a sequential number
/// </summary>
procedure CreateTestCustomer(var Customer: Record Customer)
begin
    // Implementation
end;
```

## Common Test Data Patterns

### Master Data
- Customer No.: `XCUST#####`
- Vendor No.: `XVEND#####`
- Item No.: `XITEM#####`
- G/L Account No.: `X####`

### Document Data
- Sales Order No.: `XSO#####`
- Purchase Order No.: `XPO#####`
- Transfer Order No.: `XTO#####`

### Setup Data
- Location Code: `XLOC##`
- Dimension Code: `XDIM##`
- Unit of Measure: `XUOM##`

## Exception Cases

The 'X' prefix requirement does NOT apply to:
- Numeric fields (amounts, quantities, dates)
- Boolean fields
- Enum/Option fields
- System-generated fields

## Benefits of This Approach

1. **Prevents Data Conflicts**: The 'X' prefix ensures test data won't conflict with production or demo data
2. **Easy Identification**: Test data is immediately recognizable in the database
3. **Simplified Cleanup**: Can easily identify and remove all test data using filters
4. **Consistent Testing**: Reduces random test failures due to data conflicts

By following these guidelines, you ensure that test data is properly isolated and won't interfere with existing data or cause unexpected test failures.

## Quick Reference

### Essential Test Data Rules
- **X Prefix Requirement**: Always prefix Code and Text fields with 'X' in test data
- **Data Isolation**: Generate unique test data to avoid conflicts with existing records
- **Cleanup Strategy**: Implement proper test data cleanup after test execution
- **Consistent Patterns**: Use standardized test data generation patterns across test libraries

### Common Test Data Patterns
```al
// Standard test data creation with X prefix
procedure CreateTestCustomer(var Customer: Record Customer)
begin
    Customer.Init();
    Customer."No." := 'XTEST001';
    Customer.Name := 'XTest Customer Name';
    Customer.Address := 'XTest Street 123';
    Customer.Insert(true);
end;

// Test data cleanup pattern
procedure CleanupTestData()
begin
    Customer.SetFilter("No.", 'X*');
    Customer.DeleteAll();
end;
```

## Search Keywords

### Test Data Generation
**Data Patterns**: Test data creation, X prefix requirement, data isolation, test libraries, test codeunits
**Test Management**: Test data cleanup, data conflicts prevention, test data organization
**AL Testing**: Test procedures, test scenarios, test data generation patterns, test libraries

### Quality Assurance
**Data Integrity**: Test data validation, data consistency, conflict prevention, data isolation strategies
**Testing Standards**: Test data standards, X prefixing rules, test data best practices
**Test Reliability**: Consistent test data, reproducible tests, test environment management

### Business Central Testing
**Test Framework**: AL test framework, test codeunit patterns, test library design, test data setup
**Extension Testing**: Test data for extensions, AppSource testing requirements, test environment setup
**Development Testing**: Unit testing data, integration testing data, test scenario preparation

## Search Keywords

### Test Data Generation
**Data Patterns**: Test data creation, X prefix requirement, data isolation, test libraries, test codeunits
**Test Management**: Test data cleanup, data conflicts prevention, test data organization
**AL Testing**: Test procedures, test scenarios, test data generation patterns, test libraries

### Quality Assurance  
**Data Integrity**: Test data validation, data consistency, conflict prevention, data isolation strategies
**Testing Standards**: Test data standards, X prefixing rules, test data best practices
**Test Reliability**: Consistent test data, reproducible tests, test environment management

### Business Central Testing
**Test Framework**: AL test framework, test codeunit patterns, test library design, test data setup
**Extension Testing**: Test data for extensions, AppSource testing requirements, test environment setup
**Development Testing**: Unit testing data, integration testing data, test scenario preparation

## Cross-References

### Related SharedGuidelines
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.md` - Test object and variable naming
- **Code Style**: `SharedGuidelines/Standards/code-style.md` - Test code formatting and style
- **Error Handling**: `SharedGuidelines/Standards/error-handling.md` - Error handling in test scenarios

### Related TestingValidation Files
- **Testing Strategy**: `TestingValidation/testing-strategy.md` - Overall testing approach and methodology
- **Quality Validation**: `TestingValidation/quality-validation.md` - Test data quality validation

### Workflow Applications
- **CoreDevelopment**: Test data generation for object development validation
- **PerformanceOptimization**: Test data patterns for performance testing scenarios
- **AppSourcePublishing**: Test data compliance for marketplace testing requirements

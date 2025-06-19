---
applyTo: '**/*.al'
---
# Testing Strategy Guidelines

This document outlines comprehensive testing strategies and best practices for AL development in Business Central.

## Core Testing Principles

- There should be no comments in the code about refactoring
- Names on procedures must not contain information about they are refactored or optimized, names should reflect what they do
- When generating test data in Library files, always prefix Code and Text fields with an 'X' to ensure the data does not conflict with existing data in the database. This is only relevant for Tests and Test Libraries

## Test Design Patterns

### Test Structure (Arrange-Act-Assert)

Follow the Arrange-Act-Assert pattern for all test methods:

```al
[Test]
procedure TestCustomerValidation()
var
    Customer: Record Customer;
    ExpectedError: Text;
begin
    // Arrange
    CreateTestCustomer(Customer);
    ExpectedError := 'Customer name cannot be empty';

    // Act & Assert
    asserterror Customer.Validate(Name, '');
    Assert.ExpectedError(ExpectedError);
end;
```

### Test Isolation

- Each test should be independent and not rely on other tests
- Clean up test data after each test execution
- Use transaction rollback when possible to avoid permanent data changes

### Test Naming Conventions

- Use descriptive test names that explain what is being tested
- Format: `Test[Functionality][Scenario]`
- Examples: `TestCustomerCreationWithValidData`, `TestItemInventoryCalculation`

## Test Categories

### Unit Tests

Test individual procedures and functions in isolation:

```al
[Test]
procedure TestCalculateTotalAmount()
var
    SalesLine: Record "Sales Line";
    ExpectedTotal: Decimal;
    ActualTotal: Decimal;
begin
    // Arrange
    CreateTestSalesLine(SalesLine);
    ExpectedTotal := SalesLine.Quantity * SalesLine."Unit Price";

    // Act
    ActualTotal := CalculateTotalAmount(SalesLine);

    // Assert
    Assert.AreEqual(ExpectedTotal, ActualTotal, 'Total amount calculation failed');
end;
```

### Integration Tests

Test interactions between different objects and systems:

```al
[Test]
procedure TestSalesOrderPosting()
var
    SalesHeader: Record "Sales Header";
    PostedInvoiceNo: Code[20];
begin
    // Arrange
    CreateTestSalesOrder(SalesHeader);

    // Act
    PostedInvoiceNo := PostSalesOrder(SalesHeader);

    // Assert
    VerifyPostedSalesInvoice(PostedInvoiceNo);
end;
```

### Business Process Tests

Test complete business workflows:

```al
[Test]
procedure TestCompleteOrderToInvoiceProcess()
var
    Customer: Record Customer;
    Item: Record Item;
    SalesHeader: Record "Sales Header";
begin
    // Arrange
    CreateTestCustomer(Customer);
    CreateTestItem(Item);

    // Act
    CreateSalesOrder(SalesHeader, Customer, Item);
    PostSalesOrder(SalesHeader);

    // Assert
    VerifyCustomerLedgerEntry(Customer."No.");
    VerifyItemLedgerEntry(Item."No.");
end;
```

## Test Data Management

### Test Libraries

Create dedicated test libraries for reusable test data:

```al
codeunit 50100 "Sales Test Library"
{
    procedure CreateTestCustomer(var Customer: Record Customer)
    begin
        Customer.Init();
        Customer."No." := CreateCustomerNo();
        Customer.Name := CreateCustomerName();
        Customer.Insert(true);
    end;

    local procedure CreateCustomerNo(): Code[20]
    begin
        exit('XCUST' + Format(Random(99999)).PadLeft(5, '0'));
    end;
}
```

### Data Cleanup

Always clean up test data to prevent side effects:

```al
[Test]
procedure TestWithCleanup()
var
    Customer: Record Customer;
begin
    // Arrange
    CreateTestCustomer(Customer);

    try
        // Act & Assert
        // ... test logic ...
    finally
        // Cleanup
        Customer.Delete(true);
    end;
end;
```

## Error Testing

### Expected Error Testing

Test that appropriate errors are thrown:

```al
[Test]
procedure TestInvalidCustomerThrowsError()
var
    Customer: Record Customer;
begin
    // Arrange
    Customer.Init();
    Customer."No." := '';

    // Act & Assert
    asserterror Customer.Insert(true);
    Assert.ExpectedError('No. must have a value');
end;
```

### Error Message Validation

Verify specific error messages:

```al
[Test]
procedure TestSpecificErrorMessage()
var
    ErrorMessage: Text;
begin
    // Arrange & Act
    asserterror ValidateBusinessRule();
    ErrorMessage := GetLastErrorText();

    // Assert
    Assert.IsTrue(ErrorMessage.Contains('Expected error text'), 'Wrong error message');
end;
```

## Performance Testing

### Execution Time Testing

Test performance-critical operations:

```al
[Test]
procedure TestLargeDatasetPerformance()
var
    StartTime: DateTime;
    EndTime: DateTime;
    ExecutionTime: Duration;
begin
    // Arrange
    CreateLargeTestDataset();
    StartTime := CurrentDateTime();

    // Act
    ProcessLargeDataset();
    EndTime := CurrentDateTime();

    // Assert
    ExecutionTime := EndTime - StartTime;
    Assert.IsTrue(ExecutionTime < 5000, 'Processing took too long'); // 5 seconds max
end;
```

## Test Maintenance

### Regular Test Reviews

- Review and update tests when business logic changes
- Remove obsolete tests that no longer provide value
- Ensure test coverage remains adequate

### Test Documentation

- Document complex test scenarios
- Explain the business rationale behind specific tests
- Maintain test data setup instructions

## Best Practices

1. **Keep Tests Simple**: Each test should focus on one specific behavior
2. **Use Meaningful Assertions**: Assert exactly what you expect to happen
3. **Avoid Logic in Tests**: Tests should be straightforward and easy to understand
4. **Fast Execution**: Design tests to run quickly to encourage frequent execution
5. **Deterministic Results**: Tests should always produce the same result given the same input
6. **Clear Error Messages**: When tests fail, the error message should clearly indicate what went wrong

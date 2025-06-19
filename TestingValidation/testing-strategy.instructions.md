---
applyTo: '**/*.al'
---
# Testing Strategy Guidelines

This document outlines comprehensive testing strategies and best practices for AL development in Business Central.

## Table of Contents

### Quick Navigation
- [Quick Reference](#quick-reference) - Essential testing patterns and Arrange-Act-Assert structure
- [Common Scenarios](#common-scenarios) - Typical testing use cases and patterns
- [Troubleshooting](#troubleshooting) - Test failure resolution and debugging

### Detailed Content
1. [Core Testing Principles](#core-testing-principles)
2. [Test Design Patterns](#test-design-patterns)
   - [Test Structure (Arrange-Act-Assert)](#test-structure-arrange-act-assert)
   - [Test Data Management](#test-data-management)
   - [Test Isolation](#test-isolation)
3. [Unit Testing Strategies](#unit-testing-strategies)
4. [Integration Testing Approaches](#integration-testing-approaches)
5. [Performance Testing Guidelines](#performance-testing-guidelines)
6. [Test Automation](#test-automation)
7. [Test Coverage Requirements](#test-coverage-requirements)
8. [Search Keywords](#search-keywords)
9. [Cross-References](#cross-references)

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

### Complete Test Codeunit Example

```al
codeunit 50200 "X ABC Customer Rating Tests"
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;
        LibraryRandom: Codeunit "Library - Random";
        LibraryUtility: Codeunit "Library - Utility";
        CustomerRatingMgt: Codeunit "ABC Customer Rating Mgt";
        IsInitialized: Boolean;

    [Test]
    procedure TestCreateCustomerRatingWithValidData()
    var
        CustomerRating: Record "ABC Customer Rating";
        Customer: Record Customer;
    begin
        // Arrange
        Initialize();
        CreateTestCustomer(Customer);
        
        // Act
        CreateTestCustomerRating(CustomerRating, Customer."No.");
        
        // Assert
        CustomerRating.TestField("Customer No.", Customer."No.");
        CustomerRating.TestField("Rating Date");
        Assert.IsTrue(CustomerRating."Rating Score" >= 1, 'Rating score should be at least 1');
        Assert.IsTrue(CustomerRating."Rating Score" <= 5, 'Rating score should be at most 5');
    end;

    [Test]
    procedure TestCustomerRatingValidationWithEmptyCustomerNo()
    var
        CustomerRating: Record "ABC Customer Rating";
    begin
        // Arrange
        Initialize();
        CustomerRating.Init();
        CustomerRating."Rating Date" := Today;
        CustomerRating."Rating Score" := 5;
        
        // Act & Assert
        asserterror CustomerRating.Insert(true);
        Assert.ExpectedError('Customer No. must have a value');
    end;

    [Test]
    procedure TestCustomerRatingValidationWithInvalidScore()
    var
        CustomerRating: Record "ABC Customer Rating";
        Customer: Record Customer;
    begin
        // Arrange
        Initialize();
        CreateTestCustomer(Customer);
        CustomerRating.Init();
        CustomerRating."Customer No." := Customer."No.";
        CustomerRating."Rating Date" := Today;
        
        // Act & Assert - Test lower bound
        asserterror CustomerRating.Validate("Rating Score", 0);
        Assert.ExpectedError('Rating Score must be between 1 and 5');
        
        // Act & Assert - Test upper bound
        asserterror CustomerRating.Validate("Rating Score", 6);
        Assert.ExpectedError('Rating Score must be between 1 and 5');
    end;

    [Test]
    procedure TestCalculateAverageRating()
    var
        CustomerRating: Record "ABC Customer Rating";
        Customer: Record Customer;
        ExpectedAverage: Decimal;
        ActualAverage: Decimal;
        i: Integer;
    begin
        // Arrange
        Initialize();
        CreateTestCustomer(Customer);
        
        // Create multiple ratings for the customer
        for i := 1 to 5 do begin
            Clear(CustomerRating);
            CreateTestCustomerRating(CustomerRating, Customer."No.");
            CustomerRating."Rating Score" := i;
            CustomerRating.Modify(true);
        end;
        
        ExpectedAverage := 3.0; // (1+2+3+4+5)/5 = 3
        
        // Act
        ActualAverage := CustomerRatingMgt.CalculateAverageRating(Customer."No.");
        
        // Assert
        Assert.AreEqual(ExpectedAverage, ActualAverage, 'Average rating calculation failed');
    end;

    [Test]
    procedure TestGetHighestRatingCustomers()
    var
        TempCustomer: Record Customer temporary;
        Customer1, Customer2, Customer3: Record Customer;
        CustomerRating: Record "ABC Customer Rating";
        MinRating: Decimal;
    begin
        // Arrange
        Initialize();
        CreateTestCustomer(Customer1);
        CreateTestCustomer(Customer2);
        CreateTestCustomer(Customer3);
        
        // Create ratings for customers
        CreateTestCustomerRating(CustomerRating, Customer1."No.");
        CustomerRating."Rating Score" := 5;
        CustomerRating.Modify(true);
        
        CreateTestCustomerRating(CustomerRating, Customer2."No.");
        CustomerRating."Rating Score" := 3;
        CustomerRating.Modify(true);
        
        CreateTestCustomerRating(CustomerRating, Customer3."No.");
        CustomerRating."Rating Score" := 4;
        CustomerRating.Modify(true);
        
        MinRating := 4.0;
        
        // Act
        CustomerRatingMgt.GetHighestRatingCustomers(TempCustomer, MinRating);
        
        // Assert
        Assert.AreEqual(2, TempCustomer.Count, 'Should find 2 customers with rating >= 4');
        
        // Verify specific customers are included
        Assert.IsTrue(TempCustomer.Get(Customer1."No."), 'Customer1 should be included');
        Assert.IsTrue(TempCustomer.Get(Customer3."No."), 'Customer3 should be included');
        Assert.IsFalse(TempCustomer.Get(Customer2."No."), 'Customer2 should not be included');
    end;

    [Test]
    procedure TestRatingWorkflowWithApproval()
    var
        CustomerRating: Record "ABC Customer Rating";
        Customer: Record Customer;
        RatingWorkflow: Codeunit "ABC Customer Rating Workflow";
    begin
        // Arrange
        Initialize();
        CreateTestCustomer(Customer);
        SetupApprovalRequiredForLowRatings();
        
        CreateTestCustomerRating(CustomerRating, Customer."No.");
        CustomerRating."Rating Score" := 1; // Low rating requiring approval
        CustomerRating.Modify(true);
        
        // Act
        RatingWorkflow.ProcessRatingWorkflow(CustomerRating);
        
        // Assert
        CustomerRating.Get(CustomerRating."Customer No.", CustomerRating."Rating Date", CustomerRating."Rating Category");
        Assert.AreEqual(Format(CustomerRating.Status::"Pending Approval"), Format(CustomerRating.Status), 'Rating should be pending approval');
    end;

    [Test]
    procedure TestPerformanceWithLargeDataset()
    var
        Customer: Record Customer;
        CustomerRating: Record "ABC Customer Rating";
        StartTime: Time;
        EndTime: Time;
        Duration: Duration;
        i: Integer;
        MaxDuration: Duration;
    begin
        // Arrange
        Initialize();
        CreateTestCustomer(Customer);
        
        // Create large dataset for performance testing
        for i := 1 to 1000 do begin
            Clear(CustomerRating);
            CreateTestCustomerRating(CustomerRating, Customer."No.");
            CustomerRating."Rating Score" := Random(5) + 1;
            CustomerRating.Modify(true);
        end;
        
        MaxDuration := 5000; // 5 seconds maximum
        
        // Act
        StartTime := Time;
        CustomerRatingMgt.CalculateAverageRating(Customer."No.");
        EndTime := Time;
        
        // Assert
        Duration := EndTime - StartTime;
        Assert.IsTrue(Duration <= MaxDuration, StrSubstNo('Performance test failed. Duration: %1ms, Maximum: %2ms', Duration, MaxDuration));
    end;

    local procedure Initialize()
    begin
        if IsInitialized then
            exit;
            
        // Setup any global test data or configuration
        SetupTestConfiguration();
        
        IsInitialized := true;
        Commit();
    end;

    local procedure CreateTestCustomer(var Customer: Record Customer)
    begin
        Customer.Init();
        Customer."No." := 'X' + LibraryUtility.GenerateRandomCode(Customer.FieldNo("No."), Database::Customer);
        Customer.Name := 'XTest Customer ' + Format(LibraryRandom.RandInt(9999));
        Customer."E-Mail" := 'xtest@example.com';
        Customer."Phone No." := 'X123456789';
        Customer.Insert(true);
    end;

    local procedure CreateTestCustomerRating(var CustomerRating: Record "ABC Customer Rating"; CustomerNo: Code[20])
    begin
        CustomerRating.Init();
        CustomerRating."Customer No." := CustomerNo;
        CustomerRating."Rating Date" := Today;
        CustomerRating."Rating Score" := LibraryRandom.RandIntInRange(1, 5);
        CustomerRating."Rating Category" := "ABC Rating Category"::Service;
        CustomerRating.Comments := 'XTest rating comment';
        CustomerRating.Insert(true);
    end;

    local procedure SetupTestConfiguration()
    var
        RatingSetup: Record "ABC Rating Setup";
    begin
        if not RatingSetup.Get() then begin
            RatingSetup.Init();
            RatingSetup."Approval Required Below Score" := 2;
            RatingSetup."High Value Customer Threshold" := 10000;
            RatingSetup.Insert();
        end;
    end;

    local procedure SetupApprovalRequiredForLowRatings()
    var
        RatingSetup: Record "ABC Rating Setup";
    begin
        if RatingSetup.Get() then begin
            RatingSetup."Approval Required Below Score" := 2;
            RatingSetup.Modify();
        end;
    end;

    [ConfirmHandler]
    procedure ConfirmHandler(Question: Text[1024]; var Reply: Boolean)
    begin
        Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024])
    begin
        // Handle messages during testing
    end;
}
```

### Test Data Library Example

```al
codeunit 50201 "X ABC Test Data Library"
{
    // Test library for consistent test data creation

    procedure CreateMinimalCustomerRating(var CustomerRating: Record "ABC Customer Rating"; CustomerNo: Code[20])
    begin
        CustomerRating.Init();
        CustomerRating."Customer No." := CustomerNo;
        CustomerRating."Rating Date" := Today;
        CustomerRating."Rating Score" := 3;
        CustomerRating."Rating Category" := "ABC Rating Category"::Service;
        CustomerRating.Insert(true);
    end;

    procedure CreateFullCustomerRating(var CustomerRating: Record "ABC Customer Rating"; CustomerNo: Code[20]; RatingScore: Integer; RatingCategory: Enum "ABC Rating Category")
    begin
        CustomerRating.Init();
        CustomerRating."Customer No." := CustomerNo;
        CustomerRating."Rating Date" := Today;
        CustomerRating."Rating Score" := RatingScore;
        CustomerRating."Rating Category" := RatingCategory;
        CustomerRating.Comments := 'XTest rating created by library';
        CustomerRating.Insert(true);
    end;

    procedure CreateCustomerWithRating(var Customer: Record Customer; var CustomerRating: Record "ABC Customer Rating"; RatingScore: Integer)
    var
        LibraryUtility: Codeunit "Library - Utility";
    begin
        // Create customer
        Customer.Init();
        Customer."No." := 'X' + LibraryUtility.GenerateRandomCode(Customer.FieldNo("No."), Database::Customer);
        Customer.Name := 'XTest Customer with Rating';
        Customer.Insert(true);
        
        // Create rating for customer
        CreateFullCustomerRating(CustomerRating, Customer."No.", RatingScore, "ABC Rating Category"::Service);
    end;

    procedure CreateMultipleRatingsForCustomer(CustomerNo: Code[20]; NumberOfRatings: Integer; var AvgScore: Decimal)
    var
        CustomerRating: Record "ABC Customer Rating";
        i: Integer;
        TotalScore: Integer;
        LibraryRandom: Codeunit "Library - Random";
    begin
        TotalScore := 0;
        for i := 1 to NumberOfRatings do begin
            Clear(CustomerRating);
            CustomerRating."Customer No." := CustomerNo;
            CustomerRating."Rating Date" := CalcDate('<-' + Format(i) + 'D>', Today);
            CustomerRating."Rating Score" := LibraryRandom.RandIntInRange(1, 5);
            CustomerRating."Rating Category" := "ABC Rating Category"::Service;
            CustomerRating.Insert(true);
            TotalScore += CustomerRating."Rating Score";
        end;
        
        AvgScore := TotalScore / NumberOfRatings;
    end;

    procedure CleanupTestData()
    var
        Customer: Record Customer;
        CustomerRating: Record "ABC Customer Rating";
    begin
        // Clean up customers with X prefix
        Customer.SetFilter("No.", 'X*');
        if Customer.FindSet() then
            repeat
                // Delete related ratings first
                CustomerRating.SetRange("Customer No.", Customer."No.");
                CustomerRating.DeleteAll();
            until Customer.Next() = 0;
        Customer.DeleteAll();

        // Clean up orphaned ratings with X prefix customer numbers
        CustomerRating.SetFilter("Customer No.", 'X*');
        CustomerRating.DeleteAll();
    end;
}

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

## Quick Reference

### Essential Testing Patterns
- **Arrange-Act-Assert**: Structure all tests with clear setup, execution, and verification phases
- **Test Data Prefixing**: Use 'X' prefix for all Code and Text fields in test data
- **Test Isolation**: Ensure tests don't depend on each other or external state
- **Meaningful Names**: Test procedure names should clearly describe what is being tested

### Common Test Structure
```al
[Test]
procedure TestCustomerValidation()
var
    Customer: Record Customer;
begin
    // Arrange
    CreateTestCustomer(Customer);
    
    // Act
    Customer.Validate(Name, '');
    
    // Assert
    asserterror Customer.Insert(true);
end;
```

### Test Data Management
```al
// Always use X prefix for test data
Customer."No." := 'XTEST001';
Customer.Name := 'XTest Customer';
```

## Search Keywords

### Testing Methodology
**Test Patterns**: Arrange-Act-Assert, test structure, unit testing, integration testing, test design patterns
**Test Management**: Test automation, test coverage, test execution, test maintenance, test documentation
**AL Testing**: Test codeunits, test procedures, test data, test libraries, AL test framework

### Quality Assurance
**Test Strategy**: Testing approach, test planning, test scenarios, test case design, test validation
**Test Quality**: Test reliability, test performance, test maintainability, test effectiveness
**Development Testing**: Developer testing, automated testing, continuous testing, test-driven development

### Business Central Testing
**Extension Testing**: AL extension testing, AppSource testing requirements, test environment setup
**Test Framework**: Business Central test framework, test runner, test automation tools
**Test Integration**: CI/CD testing, automated test execution, test pipeline integration

## Cross-References

### Related TestingValidation Files
- **Test Data Patterns**: `TestingValidation/test-data-patterns.instructions.md` - Detailed X prefix requirements and data generation
- **Quality Validation**: `TestingValidation/quality-validation.instructions.md` - Quality gates and validation processes

### Related SharedGuidelines
- **Code Style**: `SharedGuidelines/Standards/code-style.instructions.md` - Test code formatting and style standards
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.instructions.md` - Test procedure and variable naming
- **Error Handling**: `SharedGuidelines/Standards/error-handling.instructions.md` - Error handling in test scenarios

### Workflow Applications
- **CoreDevelopment**: Testing strategies for object development validation
- **PerformanceOptimization**: Performance testing and validation approaches
- **AppSourcePublishing**: Testing requirements for marketplace compliance

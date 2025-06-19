---
applyTo: '**/*.al'
---
# Performance Optimization Guide for AL Development

This comprehensive guide outlines best practices and advanced techniques for optimizing AL code performance in Microsoft Business Central applications.

## Query Optimization and Database Performance

### SetLoadFields Usage - AL-Specific Performance Pattern

```al
// Efficient field loading
Customer.SetLoadFields("No.", "Name", "Credit Limit (LCY)");
if Customer.FindSet() then
    repeat
        // Process only loaded fields for optimal performance
    until Customer.Next() = 0;
```

### Filtering Best Practices

- Use appropriate filters before reading records
- Use SetRange/SetFilter with indexed fields when possible
- Apply filters in the order of selectivity (most selective first)
- Avoid using FIND('-') without filters

```al
// Good: Efficient filtering with indexed fields
Customer.SetRange("Customer Posting Group", PostingGroup);
Customer.SetRange("Blocked", Customer.Blocked::" ");
Customer.SetLoadFields("No.", "Name");

// Avoid: Unfiltered searches
Customer.FindSet(); // This loads all customers without filters
```

### Database Operations Optimization

#### Minimize Database Operations Through Efficient Filtering

- Use SetLoadFields() to load only needed fields for performance
- Use SetRange/SetFilter with indexed fields when possible
- Avoid using FIND('-') without filters
- Leverage Business Central's query capabilities for complex operations

#### Avoid Nested Database Loops

- Never put database calls inside loops if possible
- Use temporary tables to store intermediate results
- Consider using queries for complex data retrieval
- Use bulk operations instead of record-by-record processing

```al
// Bad: Nested database operations
repeat
    SalesLine.SetRange("Document No.", SalesHeader."No.");
    SalesLine.CalcSums(Amount); // Database call in loop
until SalesHeader.Next() = 0;

// Good: Prepare data once, process in memory
TempSalesLine.LoadData(SalesHeaders);
TempSalesLine.ProcessAmountCalculations();
```

### Use TempTables for Intermediate Data

- Declare record variables as temporary for in-memory operations
- Process data in memory before writing to database
- Use temporary tables for sorting and filtering operations

```al
// Efficient temporary table usage
procedure ProcessCustomerData()
var
    TempCustomer: Record Customer temporary;
begin
    LoadCustomersToTemp(TempCustomer);
    TempCustomer.ProcessInMemory();
    TempCustomer.WriteResultsToDatabase();
end;
```

### Transaction Handling for Optimal Performance

- Keep transactions as short as possible
- Avoid user interaction during transactions
- Use LockTable() only when necessary and as late as possible
- Consider using snapshot isolation for read operations

## Memory Management and Object Lifecycle

### AL-Specific Memory Optimization

```al
// Efficient memory usage with proper variable scope
procedure ProcessLargeDataset()
var
    TempBuffer: Record "Integer" temporary;
begin
    // Use temporary records for large datasets
    LoadDataToTempBuffer(TempBuffer);
    ProcessTempBuffer(TempBuffer);
    // TempBuffer automatically cleaned up when procedure exits
end;
```

### Data Structure Optimization

- Use appropriate data types for fields and variables
- Minimize the use of Text variables with large lengths
- Consider using BLOB fields for large text content
- Implement proper cleanup for temporary objects

## UI Performance and Page Loading

### Minimize Code in OnAfterGetRecord Triggers

- Move complex calculations to separate procedures
- Use CurrPage.UPDATE(FALSE) to avoid unnecessary refreshes
- Consider using background tasks for heavy calculations

```al
// Optimized OnAfterGetRecord
trigger OnAfterGetRecord()
begin
    // Minimal processing in trigger
    CalculatedField := GetCachedCalculation(Rec."No.");
end;

// Heavy processing moved to separate procedure
procedure RefreshCalculations()
begin
    // Complex calculations performed on demand
    PerformComplexCalculations();
    CurrPage.Update();
end;
```

### Use FlowFields and FlowFilters Appropriately

- Avoid excessive CALCFIELDS calls, especially in loops
- Use SetAutoCalcFields only for fields that are always needed
- Consider using normal fields with manual updates for frequently accessed calculated values

### Optimize UI Performance

- Use DisableControls/EnableControls when updating multiple records
- Implement virtual scrolling for large datasets
- Minimize the number of visible fields on list pages
- Use page extensions instead of replacing entire pages

## Background Processing Patterns

### Efficient Page Loading Techniques

```al
// Optimize page loading with SetLoadFields
trigger OnOpenPage()
begin
    SetLoadFields("No.", "Name", "Status"); // Load only essential fields
    if FindSet() then; // Prepare recordset efficiently
end;
```

### Implement Background Processing for Long-Running Operations

- Use StartSession for non-interactive processing
- Consider job queue entries for scheduled operations
- Implement proper progress reporting for long-running tasks

```al
// Background processing pattern
procedure ProcessLargeDatasetInBackground()
var
    JobQueueEntry: Record "Job Queue Entry";
begin
    JobQueueEntry.ScheduleJobQueueEntry(
        Codeunit::"Large Dataset Processor",
        Rec.RecordId);
end;
```

## Performance Monitoring and Bottleneck Identification

### AL Performance Monitoring Techniques

```al
// Performance measurement pattern
procedure MeasurePerformance()
var
    StartTime: DateTime;
    Duration: Duration;
begin
    StartTime := CurrentDateTime;

    // Performance-critical operation
    PerformCriticalOperation();

    Duration := CurrentDateTime - StartTime;
    LogPerformanceMetric('CriticalOperation', Duration);
end;
```

### Profiling Techniques for AL Development

- Implement telemetry to track operation durations
- Use the performance profiler to identify bottlenecks
- Set up alerts for slow-running operations
- Regularly review performance metrics with Business Central telemetry

## Report Optimization

### Optimize Report Performance

- Use appropriate filters to limit data retrieval
- Consider using processing-only reports for data manipulation
- Use temporary tables to prepare data before rendering

```al
// Efficient report data preparation
trigger OnPreDataItem()
begin
    SetLoadFields("No.", "Name"); // Optimize field loading
    SetFilter("Date Filter", GetDateFilter()); // Apply business logic filters
end;
```

## SQL Optimization for Business Central

### Optimize Queries for Business Central Database

- Use indexed fields in filters and sorting
- Avoid complex calculations in WHERE clauses
- Use EXISTS/IN instead of joins when appropriate
- Monitor and optimize slow-running queries through telemetry

### Advanced Query Patterns

```al
// Efficient query usage for complex operations
query CustomerSalesAnalysis
{
    elements
    {
        dataitem(Customer; Customer)
        {
            filter(PostingGroup; "Customer Posting Group")
            {
                // Indexed field for efficient filtering
            }
            column(CustomerNo; "No.")
            column(CustomerName; Name)

            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Sell-to Customer No." = Customer."No.";
                column(TotalAmount; Amount)
                {
                    Method = Sum;
                }
            }
        }
    }
}
```

## Caching Strategies

### Implement Caching for Frequently Accessed Data

- Cache lookup values that don't change frequently
- Use application cache for shared data
- Implement proper cache invalidation when data changes

```al
// Caching pattern for lookup data
procedure GetCachedSetupValue(KeyValue: Code[20]): Text
var
    TempSetup: Record "Setup Table" temporary;
begin
    if not TempSetup.Get(KeyValue) then begin
        TempSetup.LoadFromDatabase(KeyValue);
        TempSetup.Insert();
    end;
    exit(TempSetup."Setup Value");
end;
```

## Advanced Performance Patterns

### Bulk Processing Techniques

```al
// Efficient bulk operations
procedure BulkUpdateCustomers()
var
    Customer: Record Customer;
begin
    Customer.SetLoadFields("Credit Limit (LCY)", "Last Modified Date Time");
    if Customer.FindSet(true) then
        repeat
            Customer."Credit Limit (LCY)" := CalculateNewLimit(Customer);
            Customer.Modify(false); // Skip validation for bulk operations
        until Customer.Next() = 0;
end;
```

### Performance Testing and Validation

- Implement automated performance tests
- Use telemetry data to identify regression
- Set performance benchmarks for critical operations
- Monitor resource utilization during peak usage

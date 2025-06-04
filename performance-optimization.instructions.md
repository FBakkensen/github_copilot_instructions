---
applyTo: '**/*.al'
---
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

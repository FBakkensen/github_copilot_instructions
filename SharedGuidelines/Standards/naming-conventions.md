# Naming Conventions for AL Development

This document outlines the comprehensive naming conventions for variables, parameters, and objects in Business Central AL code to ensure consistency and maintainability across all development workflows.

## Table of Contents

1. [General Naming Guidelines](#general-naming-guidelines)
2. [Variables and Parameters](#variables-and-parameters)
   - [Record Variables](#record-variables)
   - [Page Variables](#page-variables)
   - [Multiple Variables of Same Type](#multiple-variables-of-same-type)
   - [Parameter Declaration](#parameter-declaration)
   - [Variable Ordering](#variable-ordering)
3. [Object Naming](#object-naming)
   - [Tables and Fields](#tables-and-fields)
   - [Pages](#pages)
   - [Codeunits](#codeunits)
   - [Reports](#reports)
4. [Prefix Guidelines](#prefix-guidelines)
5. [Search Keywords](#search-keywords)
6. [Cross-References](#cross-references)

## General Naming Guidelines

- Use PascalCase for all identifiers (objects, variables, parameters, methods)
- Create descriptive names that clearly indicate the purpose
- Avoid abbreviations unless they are widely understood
- Be consistent with naming patterns throughout the codebase
- Follow Microsoft's official AL naming guidelines

## Variables and Parameters

### Record Variables

Names of variables and parameters of type `Record` should be suffixed with the table name without whitespaces. For multiple variables of the same record type, use meaningful suffixes.

**Complete Examples:**

```al
// Basic record variable naming
procedure ProcessCustomer()
var
    Customer: Record Customer;
    SalesHeader: Record "Sales Header";
    SalesLine: Record "Sales Line";
begin
    // Implementation
end;

// Multiple variables of the same type - use descriptive suffixes
procedure TransferBetweenCustomers()
var
    SourceCustomer: Record Customer;
    TargetCustomer: Record Customer;
    TempCustomer: Record Customer temporary;
begin
    // Transfer logic implementation
end;

// Complex scenario with related records
procedure AnalyzeCustomerSales()
var
    Customer: Record Customer;
    SalesHeader: Record "Sales Header";
    SalesLine: Record "Sales Line";
    ItemLedgerEntry: Record "Item Ledger Entry";
    TempSalesAnalysis: Record "Sales Analysis" temporary;
    FilterCustomer: Record Customer;
begin
    // Analysis implementation
end;

// Working with extensions and base tables
procedure ProcessCustomerRatings()
var
    Customer: Record Customer;  // Base table
    CustomerRating: Record "ABC Customer Rating";  // Extension table
    TempCustomerSummary: Record "Customer Summary" temporary;
begin
    // Rating processing logic
end;
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

## Search Keywords

### AL Language Keywords
**Variables and Parameters**: Record variables, Page variables, PascalCase, variable naming, parameter declaration, variable ordering
**Object Types**: Table, Page, Codeunit, Report, XML port, Query, object naming patterns
**AL Syntax**: Begin/End, procedure, trigger, field naming, object properties

### Business Central Concepts  
**Development Standards**: Naming conventions, code consistency, maintainability, AL best practices
**Object Architecture**: Table design, page structure, codeunit patterns, report naming
**Extension Development**: AppSource compliance, prefix requirements, object numbering

### Development Patterns
**Naming Patterns**: PascalCase, descriptive naming, meaningful suffixes, consistent terminology
**Code Organization**: Variable ordering, parameter declaration, object structure
**Quality Standards**: Code maintainability, readability, AL programming standards

## Cross-References

### Related SharedGuidelines
- **Code Style**: `SharedGuidelines/Standards/code-style.md` - Formatting and style guidelines
- **Error Handling**: `SharedGuidelines/Standards/error-handling.md` - Error naming patterns
- **Core Principles**: `SharedGuidelines/Configuration/core-principles.md` - Development foundation

### Workflow Applications
- **CoreDevelopment**: Object creation and variable naming implementation
- **TestingValidation**: Test object and test data naming conventions  
- **PerformanceOptimization**: Variable naming for optimized code patterns
- **AppSourcePublishing**: Compliance with AppSource naming requirements

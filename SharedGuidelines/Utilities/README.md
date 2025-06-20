# AL Development Templates and Utilities

This folder contains practical, copy-paste ready templates for common AL development scenarios in Business Central. These templates implement the standards and patterns defined in the SharedGuidelines and follow Business Central Version 26.0 best practices.

## Available Templates

### 1. Table Template (`table-template.al`)
Complete table creation template with:
- ✅ **Proper field structure** with tooltips starting with "Specifies"
- ✅ **Data classification** set to CustomerContent
- ✅ **Validation triggers** with business logic patterns
- ✅ **FlowFields and keys** following performance guidelines
- ✅ **Standard triggers** (OnInsert, OnModify, OnDelete, OnRename)
- ✅ **Enum definition** for status fields
- ✅ **Fieldgroups** for DropDown and Brick displays

**Usage:**
1. Copy the template file
2. Replace `[ObjectID]`, `[Prefix]`, `[EntityName]` with your values
3. Customize fields, validation logic, and business rules
4. Add specific FlowFields and relationships as needed

### 2. Page Templates (`page-template.al`)
Complete page creation templates including:

#### Card Page Template
- ✅ **Proper layout** with General, Details, and Statistics groups
- ✅ **FactBoxes** with related information and system parts
- ✅ **Actions** with Processing, Navigation, and Reporting areas
- ✅ **Promoted actions** using actionref syntax (no PromotedCategory)
- ✅ **Field validation** and UI interaction patterns
- ✅ **ApplicationArea** set to All for all fields

#### List Page Template  
- ✅ **Repeater control** with proper field selection
- ✅ **Bulk operations** and selection handling
- ✅ **Export capabilities** to Excel and reports
- ✅ **FactBox integration** for additional information
- ✅ **Style expressions** for visual indicators

**Usage:**
1. Copy the relevant page template
2. Replace `[ObjectID]`, `[Prefix]`, `[EntityName]` with your values
3. Customize fields, actions, and business logic
4. Add specific FactBoxes and related pages

### 3. Codeunit Templates (`codeunit-template.al`)
Two comprehensive codeunit patterns:

#### Management Codeunit (`[Prefix] [EntityName] Mgt`)
- ✅ **CRUD operations** with validation and error handling
- ✅ **Business logic procedures** following Single Responsibility Principle
- ✅ **Event publishers** for extensibility (OnBefore/OnAfter patterns)
- ✅ **Event subscribers** for table events
- ✅ **Batch processing** with progress indication
- ✅ **Statistics and helper functions**

#### Workflow Codeunit (`[Prefix] [EntityName] Workflow`)
- ✅ **Multi-stage workflow processing** with comprehensive error handling
- ✅ **Business event patterns** for major functionality
- ✅ **Integration events** for external system connectivity
- ✅ **Progress tracking** and user notification
- ✅ **Validation and business rule enforcement**

**Usage:**
1. Choose Management template for simple operations, Workflow for complex processes
2. Replace `[ObjectID]`, `[Prefix]`, `[EntityName]` with your values
3. Implement specific business logic in the marked areas
4. Add custom validation rules and processing steps

### 4. Test Template (`test-template.al`)
Comprehensive test codeunit template with:
- ✅ **Complete test coverage** for CRUD operations
- ✅ **Arrange-Act-Assert** pattern for all test methods
- ✅ **Test data generation** with X prefix following TestingValidation standards
- ✅ **Performance testing** patterns with timing validation
- ✅ **Event testing** for subscribers and publishers
- ✅ **Error scenario testing** with asserterror patterns
- ✅ **Test handlers** for UI interactions (Confirm, Message, Page handlers)
- ✅ **Test isolation** and cleanup procedures

**Usage:**
1. Copy the test template
2. Replace `[ObjectID]`, `[Prefix]`, `[EntityName]` with your values
3. Add specific test scenarios for your business logic
4. Implement test data creation helpers
5. Add custom validation assertions

## Template Replacement Guide

### Common Placeholders
Replace these placeholders throughout the templates:

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[ObjectID]` | Your object ID number | `50100` |
| `[Prefix]` | Your extension prefix | `ABC` |
| `[EntityName]` | Your business entity name | `Customer Rating` |
| `[KeyParameters]` | Method parameters | `CustomerNo: Code[20]; Description: Text[100]` |
| `[Related Table]` | Related table name | `ABC Customer Rating Detail` |
| `[Key Field]` | Foreign key field | `Customer Rating No.` |

### Example Transformation
**From Template:**
```al
table [ObjectID] "[Prefix] [EntityName]"
{
    Caption = '[EntityName]';
    // ...
}
```

**To Implementation:**
```al
table 50100 "ABC Customer Rating"
{
    Caption = 'Customer Rating';
    // ...
}
```

## Business Central 26.0 Features

These templates leverage the latest AL features including:
- ✅ **Modern enum syntax** for status fields
- ✅ **Improved error handling** patterns
- ✅ **Performance optimization** with SetLoadFields
- ✅ **Enhanced event patterns** for extensibility
- ✅ **Current UI patterns** with proper actionref syntax
- ✅ **Data classification** compliance
- ✅ **Accessibility standards** implementation

## Cross-References

### Related SharedGuidelines
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.md`
- **Code Style**: `SharedGuidelines/Standards/code-style.md`
- **Error Handling**: `SharedGuidelines/Standards/error-handling.md`
- **Core Principles**: `SharedGuidelines/Configuration/core-principles.md`

### Related Workflows
- **CoreDevelopment**: Object patterns and development standards
- **TestingValidation**: Test data patterns and testing strategies
- **PerformanceOptimization**: SetLoadFields and optimization patterns
- **AppSourcePublishing**: Marketplace compliance requirements

## Getting Started

1. **Choose the appropriate template** based on your development scenario
2. **Copy the template file** to your AL project directory
3. **Replace all placeholders** with your specific values
4. **Customize business logic** according to your requirements
5. **Test thoroughly** using the test template patterns
6. **Review compliance** with SharedGuidelines standards

These templates provide a solid foundation for AL development while ensuring consistency with the established workflow standards and Business Central best practices.
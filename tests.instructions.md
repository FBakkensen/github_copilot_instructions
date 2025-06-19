---
applyTo: '**/*.al'
---
# AL Testing Instructions

> **CONSOLIDATED CONTENT NOTICE**: Comprehensive testing guidelines have been moved to the TestingValidation workflow for better organization.

## Quick Testing Guidelines

- There should be no comments in the code about refactoring
- Names on procedures must not contain information about they are refactored or optimized, names should reflect what they do.

## Test Data Generation

For complete test data generation patterns and requirements, see:
- **Primary Location**: `TestingValidation/test-data-patterns.instructions.md`

**Key Rule**: When generating test data in Library files, always prefix Code and Text fields with an 'X' to ensure the data does not conflict with existing data in the database.

## Complete Testing Guidelines

For comprehensive testing guidelines, see the TestingValidation workflow:
- **Testing Strategy**: `TestingValidation/testing-strategy.instructions.md`
- **Test Data Patterns**: `TestingValidation/test-data-patterns.instructions.md`
- **Quality Validation**: `TestingValidation/quality-validation.instructions.md`

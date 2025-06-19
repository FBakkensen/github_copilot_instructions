# CoreDevelopment - AL/Business Central Development Guidelines

## Workflow Purpose

CoreDevelopment provides fundamental AL language guidance and object development patterns for Microsoft Dynamics 365 Business Central. This workflow covers the essential building blocks of AL development, from basic language constructs to advanced object implementation patterns.

## Scope and Coverage

This workflow addresses the following AL development areas:
- AL language fundamentals and syntax
- Object creation patterns (tables, pages, codeunits, reports)
- Code structure and organization principles
- Basic AL development best practices

## Included Guidelines

### al-development-guide.instructions.md
**Purpose**: Comprehensive AL language guidance covering development standards and patterns
**When to use**: Starting new AL development, learning AL best practices, implementing standard development patterns
**Key topics**: AL syntax, object development, extension model, code organization

### coding-standards.instructions.md
**Purpose**: Code structure, formatting, and basic coding standards for AL development
**When to use**: Establishing code formatting standards, ensuring consistent code style, following development conventions
**Key topics**: Code formatting, indentation, naming patterns, code organization

### object-patterns.instructions.md
**Purpose**: Detailed patterns and guidelines for specific AL object types
**When to use**: Creating tables, pages, codeunits, reports, or other AL objects with proper implementation patterns
**Key topics**: Table design, page layouts, codeunit structure, report patterns, object relationships

## Usage Instructions

### Getting Started
1. **Identify your scenario**: Determine which aspect of AL development you're working on
2. **Select appropriate guideline**: Choose the instruction file that matches your current task
3. **Apply systematically**: Follow the guidelines step-by-step for consistent results
4. **Cross-reference**: Check SharedGuidelines for naming conventions and code style standards

### Development Process Integration
- **Prerequisites**: Basic understanding of Business Central and AL concepts
- **Dependencies**: SharedGuidelines for naming conventions and code style standards
- **Outputs**: Well-structured AL objects following best practices
- **Next steps**: TestingValidation for quality assurance, PerformanceOptimization for efficiency

## Integration Points

### Related Workflows
- **TestingValidation**: Core development patterns enable effective testing strategies
- **PerformanceOptimization**: Well-designed objects provide foundation for performance optimization
- **SharedGuidelines**: Depends on shared naming conventions, code style, and error handling standards

### Cross-References
- See `SharedGuidelines/Standards/` for: naming-conventions, code-style, error-handling
- See `SharedGuidelines/Configuration/` for: core-principles, ai-assistant-guidelines
- Reference `TestingValidation/` for: testing patterns for developed objects
- Reference `PerformanceOptimization/` for: performance considerations during development

## Quick Reference

### Key Rules
1. **Extension Model**: Always use extension model rather than modifying base application
2. **Object Naming**: Follow meaningful naming conventions with appropriate prefixes
3. **Code Organization**: Structure code logically with proper separation of concerns

### Common Patterns
- **Table Development**: Primary keys, field design, data classification, validation
- **Page Development**: Layout before actions, proper field organization, user experience
- **Codeunit Development**: Single responsibility principle, procedure accessibility, event patterns

### Quick Checklist
- [ ] Object has meaningful, descriptive name with appropriate prefix
- [ ] Code follows established formatting and style standards
- [ ] Object implements proper validation and error handling
- [ ] Fields have appropriate tooltips and properties set
- [ ] Code is organized logically with clear separation of concerns
- [ ] Extension model used instead of base application modification

## Search Keywords

### Primary Keywords
AL development, object creation, core development, fundamental patterns

### AL Language Terms
table, page, codeunit, report, xmlport, query, procedures, triggers, events

### Business Central Concepts
extension model, object design, AL syntax, development patterns, Business Central objects

## Workflow Transitions

### Coming From
- **Project Setup**: After initial project configuration and environment setup
- **SharedGuidelines**: With understanding of core principles and standards

### Leading To
- **TestingValidation**: To validate and test developed objects
- **PerformanceOptimization**: To optimize performance of developed objects
- **IntegrationDeployment**: To integrate objects with external systems

## Examples and Scenarios

### Common Use Cases
1. **Creating New Table**: Design data structure with proper fields, keys, and relationships
   - Apply: object-patterns.instructions.md, coding-standards.instructions.md
   - Focus on: Table design, field naming, data classification

2. **Developing Business Logic**: Implement codeunit with business processes
   - Apply: al-development-guide.instructions.md, coding-standards.instructions.md
   - Focus on: Procedure organization, error handling, event patterns

3. **Building User Interface**: Create pages for data entry and display
   - Apply: object-patterns.instructions.md, al-development-guide.instructions.md
   - Focus on: Page layout, field organization, user experience

## Quality Assurance

### Validation Steps
1. **Code Structure Review**: Verify proper organization and separation of concerns
2. **Naming Convention Check**: Ensure all objects and elements follow naming standards
3. **Standard Compliance**: Confirm adherence to AL development best practices

### Success Criteria
- Objects compile without errors or warnings
- Code follows established formatting and style standards
- Implementation follows AL development best practices
- Objects integrate properly with Business Central platform

## Additional Resources

### Related Documentation
- [Business Central AL Programming Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-programming-in-al)
- [AL Language Reference](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-al-reference)

### Internal References
- `../SharedGuidelines/Standards/` - naming-conventions, code-style, error-handling
- `../SharedGuidelines/Configuration/` - core-principles, ai-assistant-guidelines
- `../TestingValidation/` - testing patterns for developed objects

---

**Workflow Navigation**: CoreDevelopment | [➡️ Next: TestingValidation](../TestingValidation/) | [🏠 Main README](../README.md)

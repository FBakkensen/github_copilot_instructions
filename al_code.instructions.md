---
applyTo: '**/*.al'
---
# AL Development Standards for Business Central

You are an expert AL developer assistant specialized in Microsoft Dynamics 365 Business Central development. Your primary function is to help create efficient, maintainable, and compliant AL code for Business Central extensions, with particular focus on AppSource-ready applications.

> **Note:** Always refer to the official Microsoft documentation for the most up-to-date information on AL programming for Business Central.
> [Business Central AL Programming Documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-programming-in-al)

## Core Principles

For complete AL development core principles, see `core-principles.instructions.md` in `SharedGuidelines/Configuration/`.

This file contains the foundational principles that apply to all AL development work across all workflows.

# General Instructions for AI Assistant

## Code Quality and Standards

1. **Always Check for Linter Errors**: Before completing any code changes, check for and fix linter errors in the affected files. Use the diagnostics tool to identify issues and ensure the code follows AL best practices.

2. **Follow AL Code Style Guidelines**: Adhere to the AL code style guidelines specified in the `al_code_style.md` file. This includes proper variable naming, code formatting, object property qualification, and string formatting.

3. **Maintain Backward Compatibility**: When modifying existing code, ensure backward compatibility unless explicitly instructed otherwise. Preserve method signatures and parameters.

4. **Document Code Changes**: Add appropriate comments to explain complex logic or business rules. Use XML documentation comments for procedures.

## Project Structure

1. **Respect Existing Architecture**: Follow the existing architectural patterns and design principles in the codebase.

2. **Use Proper Object IDs**: When creating new objects, use the appropriate ID ranges as defined in the project.

3. **Maintain Object Naming Conventions**: Follow the established naming conventions for objects, including the required prefix "NALICF".

## Basic Implementation Guidelines

1. **Centralized Utilities**: Use centralized utility codeunits when available instead of duplicating functionality.

2. **Error Handling**: Implement proper error handling with descriptive error messages.

3. **Performance Considerations**: Write code with performance in mind, especially for operations that might be executed frequently.

## Advanced Guidelines Reference

> **CONSOLIDATED CONTENT NOTICE**: Comprehensive AL development guidelines have been organized into specialized workflows to eliminate duplication and improve discoverability.

The detailed AL development standards have been consolidated into organized workflows. For comprehensive guidance, refer to:

### Core Development Standards
- **Object Development Patterns**: `CoreDevelopment/object-patterns.instructions.md`
- **AL Development Guide**: `CoreDevelopment/al-development-guide.instructions.md`
- **Core Development Standards**: `CoreDevelopment/coding-standards.instructions.md`

### Shared Standards (Apply Everywhere)
- **Code Style Guidelines**: `SharedGuidelines/Standards/code-style.instructions.md`
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.instructions.md`
- **Error Handling**: `SharedGuidelines/Standards/error-handling.instructions.md`

### Specialized Guidelines
- **Performance Optimization**: `PerformanceOptimization/optimization-guide.instructions.md`
- **Testing and Validation**: `TestingValidation/testing-strategy.instructions.md`
- **Quality Validation**: `TestingValidation/quality-validation.instructions.md`
- **Integration Standards**: `IntegrationDeployment/integration-patterns.instructions.md`
- **AppSource Requirements**: `AppSourcePublishing/appsource-requirements.instructions.md`

This consolidation eliminates duplication while ensuring all guidelines remain easily accessible through the organized workflow structure.

4. **Testing**: Consider testability when implementing new features or modifying existing ones.

## Before Submitting Changes

1. **Review Code**: Review the code for logical errors, edge cases, and potential improvements.

2. **Check for Linter Errors**: For complete linter check procedures, see `TestingValidation/quality-validation.instructions.md`.

3. **Verify Functionality**: Confirm that the implemented changes meet the requirements and work as expected.

4. **Document Decisions**: Document any significant decisions or trade-offs made during implementation.

## Cross-Reference to Consolidated Standards

For complete guidelines and standards, refer to the following consolidated locations:

### Core Standards (Apply to All AL Development)
- **Code Style Guidelines**: `SharedGuidelines/Standards/code-style.instructions.md`
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.instructions.md`
- **Error Handling Patterns**: `SharedGuidelines/Standards/error-handling.instructions.md`
- **Core AL Principles**: `SharedGuidelines/Configuration/core-principles.instructions.md`

### Workflow-Specific Standards
- **Object Development Patterns**: `CoreDevelopment/object-patterns.instructions.md`
- **Performance Guidelines**: `PerformanceOptimization/optimization-guide.instructions.md`
- **Testing Standards**: `TestingValidation/testing-strategy.instructions.md`
- **Quality Validation**: `TestingValidation/quality-validation.instructions.md`

By following these instructions and referencing the consolidated standards, you'll contribute high-quality, maintainable code to the project.

This consolidation eliminates duplication while ensuring all guidelines remain easily accessible through the organized workflow structure.
   - Use label system for all user-facing text
   - Implement proper translation workflow
   - Test with all supported languages
   - Consider cultural differences in design

2. Accessibility compliance:
   - Follow WCAG guidelines
   - Test with screen readers
   - Implement proper keyboard navigation
   - Use appropriate color contrast

## Upgrade and Maintenance

1. Proper upgrade code path:
   - Implement upgrade codeunits
   - Handle data schema changes gracefully
   - Provide clear upgrade documentation
   - Test upgrade scenarios thoroughly

2. Maintenance plan:
   - Regular updates and bug fixes
   - Security patch process
   - Customer support channels
   - Feedback mechanism

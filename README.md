# AL Development Instructions for Business Central

This folder contains a comprehensive collection of instruction files that define coding standards, best practices, and guidelines for AL development in Microsoft Dynamics 365 Business Central. These instructions are designed to be used by AI assistants and developers to ensure consistent, high-quality code development.

## Folder Structure Overview

The instructions are organized into focused, modular files that cover different aspects of AL development:

```
prompts/
├── README.md                                    # This file - documentation and guidelines
├── instructions.instructions.md                 # Main entry point and core principles
├── general_instructions.instructions.md         # General AI assistant guidelines
├── al_code.instructions.md                      # Comprehensive AL coding guide (consolidated)
├── al_code_style.instructions.md                # Detailed code style and formatting guidelines
├── coding-standards.instructions.md             # Basic coding standards and patterns
├── naming-conventions.instructions.md           # Variable and object naming rules
├── object-specific-guidelines.instructions.md   # Guidelines for specific AL object types
├── error-handling.instructions.md               # Error handling best practices
├── performance-optimization.instructions.md     # Performance optimization guidelines
├── integration-standards.instructions.md        # Business Central integration standards
├── linter_check.instructions.md                 # Linter checking procedures
├── appsource-requirements.instructions.md       # AppSource publication requirements
├── tddflow.instructions.md                      # Test-driven development flow
└── test-data-generation.instructions.md         # Test data generation guidelines
```

## File Descriptions

### Core Foundation Files

#### `instructions.instructions.md`
- **Purpose**: Main entry point that establishes the role and core principles
- **Scope**: Applies to all AL files (`**/*.al`)
- **Content**: Core development principles, reference to Microsoft documentation

#### `general_instructions.instructions.md`
- **Purpose**: High-level guidelines for AI assistants
- **Content**: Code quality standards, project structure guidelines, implementation workflow

### Comprehensive Reference

#### `al_code.instructions.md`
- **Purpose**: Consolidated comprehensive guide containing most AL coding standards
- **Content**: Complete reference including code style, standards, naming conventions, object guidelines, error handling, performance, and more
- **Note**: This is a comprehensive file that consolidates content from multiple other files

### Code Quality and Standards

#### `coding-standards.instructions.md`
- **Purpose**: Basic coding standards and development patterns
- **Content**: PascalCase conventions, extension model usage, modular design principles, telemetry implementation

#### `al_code_style.instructions.md`
- **Purpose**: Detailed code formatting and style guidelines
- **Content**: Variable naming, code formatting, indentation, data types (enums vs options), string formatting, performance considerations

#### `naming-conventions.instructions.md`
- **Purpose**: Comprehensive naming rules for all code elements
- **Content**: Variable naming patterns, object naming conventions, prefix guidelines

#### `procedure-accessibility.instructions.md`
- **Purpose**: Rules for procedure accessibility to ensure testability and encapsulation
- **Content**: Guidelines on using `internal` for procedures, prohibition of `local` procedures, rationale for test app access

### Object-Specific Guidelines

#### `object-specific-guidelines.instructions.md`
- **Purpose**: Guidelines tailored to specific AL object types
- **Content**:
  - Tables/Table Extensions: Field tooltips, numbering, data classification
  - Pages/Page Extensions: Layout rules, action patterns, ApplicationArea settings
  - Codeunits: SRP principles, event patterns, GUI checking
  - Reports, XMLPorts, Queries: Best practices for each object type

### Quality Assurance and Testing

#### `linter_check.instructions.md`
- **Purpose**: Procedures for checking and fixing linter errors
- **Content**: Step-by-step diagnostics process, common error fixes, examples

#### `error-handling.instructions.md`
- **Purpose**: Best practices for error handling and user feedback
- **Content**: Actionable error messages, TryFunction patterns, error logging

#### `tddflow.instructions.md`
- **Purpose**: Test-driven development guidelines
- **Content**: Basic rules about clean code without refactoring comments

#### `test-data-generation.instructions.md`
- **Purpose**: Guidelines for generating test data in AL test libraries
- **Content**: 'X' prefix requirements for test data, unique data generation patterns, cleanup strategies, common test data patterns

### Performance and Integration

#### `performance-optimization.instructions.md`
- **Purpose**: Guidelines for optimizing AL code performance
- **Content**: Database operations, UI performance, background processing, caching strategies

#### `integration-standards.instructions.md`
- **Purpose**: Standards for integrating with Business Central and external systems
- **Content**: UX integration, event-based patterns, API standards, security practices

### Publication Requirements

#### `appsource-requirements.instructions.md`
- **Purpose**: Requirements for AppSource-ready extensions
- **Content**: App metadata, documentation requirements, technical validation, localization

## Current File Organization Analysis

### Content Overlap and Consolidation Notes

1. **`al_code.instructions.md`** appears to be a comprehensive consolidation file containing content from multiple other files including:
   - Complete AL code style guidelines
   - Coding standards
   - Naming conventions
   - Object-specific guidelines
   - Performance optimization
   - Error handling
   - Integration standards
   - AppSource requirements

2. **Specialized vs Consolidated Files**:
   - Individual files like `al_code_style.instructions.md`, `coding-standards.instructions.md` provide focused, detailed guidance
   - `al_code.instructions.md` provides a single comprehensive reference
   - This dual approach allows for both detailed study and quick comprehensive reference

## Guidelines for Adding New Instructions

### Decision Framework

When considering adding new instructions, use this decision framework:

#### Create a New Specialized File When:

1. **New Domain Area**: Introducing guidelines for a completely new area (e.g., API development, security patterns, deployment procedures)
2. **Substantial Standalone Content**: The new content would be substantial enough (>100 lines) to warrant its own file
3. **Different Target Audience**: Instructions for different roles (developers vs administrators vs testers)
4. **Different Scope**: Instructions that apply to different file types or contexts than existing files
5. **Specialized Workflow**: Documenting a specific development workflow or process that doesn't fit existing categories

#### Extend the Comprehensive File (`al_code.instructions.md`) When:

1. **Core AL Development**: Content directly relates to core AL programming practices
2. **Universal Application**: Guidelines that apply to all AL development scenarios
3. **Integration with Existing**: Content that enhances or clarifies existing comprehensive guidelines

#### Extend Existing Specialized Files When:

1. **Related Content**: New guidelines are closely related to existing content in a specific file
2. **Same Object Type**: Adding guidelines for the same AL object types already covered
3. **Minor Additions**: Small additions (5-20 lines) that enhance existing guidelines
4. **Same Scope**: Instructions apply to the same file patterns (`applyTo` scope)

### Content Organization Strategy

Given the current structure with both specialized and comprehensive files:

1. **Maintain Dual Approach**: Keep both detailed specialized files and the comprehensive reference
2. **Sync Important Changes**: When updating specialized files, consider if the comprehensive file needs similar updates
3. **Avoid Complete Duplication**: If content exists in the comprehensive file, specialized files can focus on deeper details or specific scenarios

### File Naming Convention

Follow this pattern for new instruction files:
```
[domain-area].instructions.md
```

Examples:
- `api-development.instructions.md`
- `security-patterns.instructions.md`
- `deployment-guidelines.instructions.md`
- `testing-strategies.instructions.md`

### Required File Structure

Each instruction file must include:

```markdown
---
applyTo: '**/*.al'  # Define which files this applies to
---
# [Title]

Brief description of the file's purpose and scope.

## [Section 1]
Content with practical examples...

## [Section 2]
More content...
```

### Content Guidelines

1. **Be Specific**: Include concrete examples and code samples
2. **Stay Focused**: Keep each file focused on its specific domain
3. **Use Examples**: Provide both correct and incorrect examples when helpful
4. **Reference Standards**: Link to official Microsoft documentation when applicable
5. **Consider AI Context**: Write instructions that AI assistants can easily follow

## Recommended New Instruction Areas

Based on the current structure, consider creating new instruction files for these areas as they become relevant:

### Development Workflow and Process
- `git-workflow.instructions.md` - Git branching strategies, commit message standards, pull request guidelines
- `code-review.instructions.md` - Code review checklists, review standards, and approval processes
- `testing-strategies.instructions.md` - Unit testing patterns, integration testing, test automation
- `debugging-techniques.instructions.md` - Debugging strategies, troubleshooting procedures, diagnostic tools

### Specialized Development Areas
- `api-development.instructions.md` - REST API design, OData patterns, API versioning
- `security-patterns.instructions.md` - Authentication, authorization, data protection, security scanning
- `localization.instructions.md` - Multi-language support, regional considerations, translation workflows
- `upgrade-patterns.instructions.md` - Extension upgrade procedures, data migration strategies
- `custom-controls.instructions.md` - Custom page controls, control add-ins, JavaScript integration

### Architecture and Design
- `architecture-patterns.instructions.md` - Design patterns, architectural decisions, modular design
- `data-modeling.instructions.md` - Table design, relationships, data architecture
- `event-driven-design.instructions.md` - Event publishers/subscribers, event-driven architecture

### Deployment and Operations
- `deployment-guidelines.instructions.md` - Packaging procedures, versioning strategies, deployment automation
- `monitoring.instructions.md` - Telemetry implementation, logging strategies, health monitoring
- `environment-management.instructions.md` - Development, test, and production environment management
- `configuration-management.instructions.md` - App settings, environment-specific configurations

### Specialized Business Central Areas
- `web-services.instructions.md` - Web service development, SOAP/REST endpoints
- `report-development.instructions.md` - Report layouts, data sources, rendering optimization
- `workflow-development.instructions.md` - Business workflow implementation, approval processes
- `dimension-handling.instructions.md` - Dimension design, dimension value handling
- `permission-design.instructions.md` - Permission set design, security model implementation

## Usage by AI Assistants

These instruction files are designed to be consumed by AI assistants to:

1. **Maintain Consistency**: Ensure all generated code follows the same standards across different sessions and contexts
2. **Provide Deep Context**: Give AI assistants comprehensive understanding of project requirements, Business Central best practices, and coding standards
3. **Enable Quality Assurance**: Help AI assistants produce high-quality, production-ready code that passes linting and follows best practices
4. **Support Learning**: Allow AI assistants to understand Business Central patterns, Microsoft conventions, and domain-specific requirements
5. **Accelerate Development**: Reduce the need for repetitive explanations by encoding knowledge in reusable instruction files
6. **Ensure Compliance**: Help maintain compliance with AppSource requirements and Microsoft standards

### Best Practices for AI Usage

1. **Reference Multiple Files**: AI assistants should reference both the comprehensive file and relevant specialized files for complete context
2. **Follow Hierarchical Guidance**: Start with core principles from `instructions.instructions.md`, then apply specific guidelines from relevant specialized files
3. **Check Linter Requirements**: Always follow the linter checking procedures from `linter_check.instructions.md`
4. **Maintain Consistency**: Use the naming conventions and coding standards consistently across all generated code

## Maintenance and Evolution

### Regular Maintenance Tasks

- **Quarterly Reviews**: Review instructions for relevance and accuracy as Microsoft releases new AL features
- **Version Updates**: Update instructions when Microsoft releases significant Business Central updates
- **Content Synchronization**: Ensure specialized files and the comprehensive file remain aligned
- **Community Input**: Incorporate feedback and lessons learned from development experience
- **Documentation Sync**: Keep instructions aligned with official Microsoft documentation

### Evolution Guidelines

1. **Deprecation Process**: When removing or significantly changing guidelines, provide migration guidance
2. **Versioning**: Consider versioning instruction files for major changes
3. **Change Documentation**: Document significant changes and their rationale
4. **Backward Compatibility**: Maintain backward compatibility when possible
5. **Testing**: Test instruction changes with actual development scenarios

### Quality Assurance

- **Consistency Checks**: Regularly verify that instructions across files don't contradict each other
- **Practical Validation**: Test instructions with real development scenarios
- **Feedback Integration**: Incorporate developer feedback and AI assistant learning outcomes
- **Performance Monitoring**: Monitor how well instructions lead to quality code generation

---

*This documentation structure supports maintainable, high-quality AL development for Business Central extensions, with particular focus on AppSource-ready applications.*
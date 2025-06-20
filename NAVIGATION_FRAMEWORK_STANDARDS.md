# Navigation Framework Standards

## Cross-Reference Formatting Standards

### Internal File References
**Format**: `[Description](relative/path/to/file.md)`
**Examples**:
- `[Core AL Principles](SharedGuidelines/Configuration/core-principles.md)`
- `[Testing Strategy](../TestingValidation/testing-strategy.md)`
- `[Naming Conventions](../SharedGuidelines/Standards/naming-conventions.md)`

### Workflow References
**Format**: `[Workflow Name](workflow-folder/)`
**Examples**:
- `[CoreDevelopment](CoreDevelopment/)` - Link to workflow folder
- `[TestingValidation](TestingValidation/)` - Link to testing workflow
- `[SharedGuidelines](SharedGuidelines/)` - Link to shared standards

### Section References
**Format**: `[Section Title](file.md#section-anchor)`
**Examples**:
- `[Object Naming](naming-conventions.md#object-naming)`
- `[Error Handling Patterns](error-handling.md#implementation-examples)`

## Table of Contents Template

### Standard TOC Format for Instruction Files
```markdown
## Table of Contents

1. [Overview](#overview)
2. [Core Principles](#core-principles)
3. [Implementation Guidelines](#implementation-guidelines)
   - [Basic Patterns](#basic-patterns)
   - [Advanced Scenarios](#advanced-scenarios)
4. [Examples](#examples)
5. [Best Practices](#best-practices)
6. [Common Pitfalls](#common-pitfalls)
7. [Related Resources](#related-resources)
8. [Quick Reference](#quick-reference)
```

### Extended TOC for Complex Files
```markdown
## Table of Contents

### Quick Navigation
- [Quick Reference](#quick-reference) - Key rules and patterns
- [Common Scenarios](#common-scenarios) - Typical use cases
- [Troubleshooting](#troubleshooting) - Problem resolution

### Detailed Content
1. [Introduction](#introduction)
2. [Fundamental Concepts](#fundamental-concepts)
3. [Core Guidelines](#core-guidelines)
   - [Basic Requirements](#basic-requirements)
   - [Advanced Requirements](#advanced-requirements)
4. [Implementation Patterns](#implementation-patterns)
   - [Standard Patterns](#standard-patterns)
   - [Complex Patterns](#complex-patterns)
5. [Code Examples](#code-examples)
   - [Basic Examples](#basic-examples)
   - [Advanced Examples](#advanced-examples)
6. [Integration Points](#integration-points)
7. [Quality Assurance](#quality-assurance)
8. [Performance Considerations](#performance-considerations)
9. [Related Workflows](#related-workflows)
```

## Search Keywords Strategy

### Keyword Placement
1. **File Headers**: Include primary keywords in first paragraph
2. **Section Headers**: Use keyword-rich section titles
3. **Content**: Natural keyword integration throughout content
4. **Cross-references**: Use keywords in link descriptions

### AL/Business Central Keyword Categories

#### Core AL Language
- AL programming, Application Language, AL development
- Object types: table, page, codeunit, report, xmlport, query
- Language features: procedures, triggers, events, variables
- Data types: Record, Boolean, Text, Integer, Decimal, Date, DateTime

#### Business Central Platform
- Business Central, Dynamics 365, BC platform
- Extensions, apps, AppSource, marketplace
- Integration, APIs, web services, external systems
- Permission sets, security, user experience

#### Development Processes
- Development workflow, testing strategy, code quality
- Performance optimization, debugging, troubleshooting
- Deployment, publishing, version control
- Documentation, best practices, standards

#### Quality and Compliance
- Code review, validation, compliance
- Accessibility, testability, maintainability
- Error handling, exception management
- Linting, static analysis, quality assurance

## Integration Guidelines Framework

### Workflow Relationship Documentation

#### Dependency Types
1. **Prerequisites**: What must be completed before this workflow
2. **Dependencies**: What this workflow requires from other workflows
3. **Outputs**: What this workflow provides to other workflows
4. **Successors**: What workflows naturally follow this one

#### Integration Points Documentation Format
```markdown
## Workflow Integration

### Incoming Dependencies
- **[Source Workflow]**: [What is received]
  - Example: CoreDevelopment provides object patterns used in testing

### Outgoing Dependencies
- **[Target Workflow]**: [What is provided]
  - Example: TestingValidation provides quality metrics for optimization

### Transition Points
- **From [Previous Workflow]**: [Transition description]
- **To [Next Workflow]**: [Transition description]
```

## Navigation Aids Standards

### Breadcrumb Navigation
**Format**: `Workflow > Subfolder > Current File`
**Examples**:
- `CoreDevelopment > al-development-guide.md`
- `SharedGuidelines > Standards > naming-conventions.md`
- `TestingValidation > test-data-patterns.md`

### Workflow Navigation Footer
**Standard Footer for all README files**:
```markdown
---
**Workflow Navigation**: [Current Workflow] | [⬅️ Previous: Previous_Workflow] | [➡️ Next: Next_Workflow] | [🏠 Main README](../README.md)
```

### Quick Links Sections
**Standard format for quick access**:
```markdown
## Quick Links
- 🏠 [Main README](../README.md) - Repository overview
- 📋 [All Workflows](../README.md#workflow-based-organization) - Complete workflow list
- 🔗 [SharedGuidelines](../SharedGuidelines/) - Cross-cutting standards
- 🎯 [Quick Reference](#quick-reference) - Key rules and patterns
```

## Content Discoverability Standards

### File Naming for Discoverability
1. **Descriptive Names**: Use purpose-driven naming
   - `quality-validation.md` vs `linter_check.md`
   - `integration-patterns.md` vs `integration-standards.md`

2. **Consistent Suffixes**: Use standard file type indicators
   - `.md` for GitHub Copilot instruction files
   - `README.md` for navigation and overview files
   - `-guide.md` for comprehensive guidance
   - `-patterns.md` for implementation examples
   - `-standards.md` for rules and requirements

### Content Organization for Search
1. **Hierarchical Structure**: Organize content in logical hierarchy
2. **Cross-Reference Density**: Include multiple pathways to content
3. **Keyword Integration**: Natural keyword usage for searchability
4. **Quick Reference Sections**: Immediate access to key information

## Template Validation Checklist

### README Template Requirements
- [ ] Workflow purpose clearly stated
- [ ] All included files described with usage scenarios
- [ ] Integration points documented
- [ ] Quick reference section included
- [ ] Search keywords provided
- [ ] Navigation aids present
- [ ] Cross-references functional

### Instruction File Requirements
- [ ] Table of contents for files >50 lines
- [ ] Cross-references to related content
- [ ] Keywords naturally integrated
- [ ] Quick reference section
- [ ] Examples and scenarios
- [ ] Integration points noted

### Navigation Standards Compliance
- [ ] Consistent file naming
- [ ] Standard cross-reference format
- [ ] Workflow integration documented
- [ ] Search keywords comprehensive
- [ ] Navigation aids functional
- [ ] Content discoverable

---

**Framework Purpose**: Ensure consistent, discoverable, and meaningful organization across all AL development workflows.

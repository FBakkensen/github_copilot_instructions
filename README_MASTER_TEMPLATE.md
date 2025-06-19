# AL/Business Central GitHub Copilot Instructions

## Overview

This repository provides comprehensive, workflow-based AL development guidelines for Microsoft Dynamics 365 Business Central development. The instructions are organized by development workflows to create meaningful organization, good indexes, and eliminate duplicate content while maintaining GitHub Copilot accessibility.

## Quick Start

1. **Choose your workflow** based on current development phase
2. **Navigate to workflow folder** for specific guidelines
3. **Reference SharedGuidelines** for cross-cutting standards
4. **Use meaningful file names** to quickly locate needed guidance

## Workflow-Based Organization

### 🏗️ CoreDevelopment
**Purpose**: AL language fundamentals and object development patterns
- `al-development-guide.instructions.md` - Comprehensive AL language guidance
- `coding-standards.instructions.md` - Code structure and formatting standards
- `object-patterns.instructions.md` - Table, page, codeunit, and other object patterns

**When to use**: Creating new AL objects, implementing business logic, following AL best practices

### 🧪 TestingValidation
**Purpose**: Testing strategies and quality assurance processes
- `testing-strategy.instructions.md` - Comprehensive testing methodology
- `test-data-patterns.instructions.md` - Test data generation and management
- `quality-validation.instructions.md` - Linting, code review, and validation processes

**When to use**: Writing tests, validating code quality, ensuring compliance with standards

### 🔄 IntegrationDeployment
**Purpose**: Integration patterns and deployment strategies
- `integration-patterns.instructions.md` - Business Central integration and API development
- `accessibility-standards.instructions.md` - Procedure accessibility and testability requirements

**When to use**: Integrating with external systems, deploying extensions, ensuring accessibility

### ⚡ PerformanceOptimization
**Purpose**: Performance tuning and optimization techniques
- `optimization-guide.instructions.md` - Database performance, UI optimization, and monitoring

**When to use**: Optimizing existing code, improving performance, addressing bottlenecks

### 📦 AppSourcePublishing
**Purpose**: AppSource marketplace compliance and publishing
- `appsource-requirements.instructions.md` - Marketplace requirements and publishing workflow

**When to use**: Preparing extensions for AppSource, ensuring marketplace compliance

### 🔗 SharedGuidelines
**Purpose**: Cross-cutting standards that apply across all workflows

#### Standards/
- `naming-conventions.instructions.md` - Comprehensive naming rules for all AL objects
- `code-style.instructions.md` - Code formatting and style guidelines
- `error-handling.instructions.md` - Error handling patterns and best practices

#### Configuration/
- `core-principles.instructions.md` - Fundamental AL development principles
- `ai-assistant-guidelines.instructions.md` - GitHub Copilot configuration and behavior

#### Utilities/
- Future expansion for tools, templates, and automation scripts

## Navigation Guide

### Finding Specific Guidelines

**By Development Phase:**
- Starting new project → CoreDevelopment
- Writing tests → TestingValidation
- Adding integrations → IntegrationDeployment
- Fixing performance → PerformanceOptimization
- Publishing to AppSource → AppSourcePublishing

**By Topic:**
- Object naming → SharedGuidelines/Standards/naming-conventions
- Code formatting → SharedGuidelines/Standards/code-style
- Error handling → SharedGuidelines/Standards/error-handling
- Core principles → SharedGuidelines/Configuration/core-principles

**Quick Reference:**
- All instruction files use `.instructions.md` extension for GitHub Copilot recognition
- Each workflow folder contains comprehensive README with file descriptions
- Cross-references link related content across workflows

## Workflow Integration

### Primary Workflow Connections
- **CoreDevelopment** ↔ **SharedGuidelines**: Core development uses shared standards
- **TestingValidation** ← **CoreDevelopment**: Testing validates development patterns
- **PerformanceOptimization** ← **CoreDevelopment**: Optimization improves development outcomes
- **AppSourcePublishing** ← **All Workflows**: Publishing requires compliance across all areas

### Transition Points
1. **Development → Testing**: Move from CoreDevelopment to TestingValidation
2. **Testing → Optimization**: Use TestingValidation results to guide PerformanceOptimization
3. **All → Publishing**: Ensure AppSourcePublishing compliance throughout development

## Search Keywords

### AL Language Keywords
- AL, Application Language, Business Central, Dynamics 365
- Objects: table, page, codeunit, report, xmlport, query
- Procedures, triggers, events, subscribers
- Variables, parameters, records, fields

### Development Process Keywords
- Development workflow, testing strategy, integration patterns
- Performance optimization, AppSource publishing
- Code quality, validation, compliance
- Naming conventions, code style, error handling

### Business Central Concepts
- Extensions, apps, AppSource marketplace
- Integration, APIs, web services
- Accessibility, testability, quality assurance
- Optimization, monitoring, performance tuning

## Contributing

### Maintaining Organization
1. **Follow meaningful naming**: Use descriptive, purpose-driven file names
2. **Update cross-references**: Maintain links between related content
3. **Preserve workflow structure**: Keep content in appropriate workflow folders
4. **Maintain GitHub Copilot compatibility**: Preserve instruction file headers

### Content Guidelines
1. **Avoid duplication**: Reference SharedGuidelines for common standards
2. **Use workflow-specific focus**: Keep content relevant to workflow purpose
3. **Maintain consistent format**: Follow README templates and navigation standards
4. **Include practical examples**: Add AL code samples where appropriate

## Project Goals Achieved

✅ **Meaningful File Names**: All files have descriptive, purpose-driven names
✅ **Good Indexes**: Comprehensive navigation and workflow-based organization
✅ **No Duplication**: Single source of truth for all standards and guidelines
✅ **GitHub Copilot Integration**: All instruction files accessible and properly formatted

## Support

For questions about specific workflows or guidelines:
1. Check workflow README files for detailed guidance
2. Review SharedGuidelines for cross-cutting standards
3. Use meaningful file names to locate specific guidance
4. Follow cross-references for related content

---

**Repository Structure**: Workflow-based organization for enhanced AL development productivity and GitHub Copilot integration.

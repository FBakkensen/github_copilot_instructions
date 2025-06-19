# AL/Business Central GitHub Copilot Instructions

## Overview

This repository provides comprehensive, workflow-based AL development guidelines for Microsoft Dynamics 365 Business Central development. The instructions are organized by development workflows to create meaningful organization, good indexes, and eliminate duplicate content while maintaining GitHub Copilot accessibility.

### What This Repository Provides

- **Workflow-Based Organization**: Guidelines organized by development lifecycle phases
- **Meaningful File Names**: Descriptive, purpose-driven naming for enhanced discoverability  
- **Single Source of Truth**: Eliminated duplication with cross-references to shared standards
- **GitHub Copilot Integration**: All instruction files optimized for AI assistant accessibility
- **Comprehensive Navigation**: Multiple pathways to find relevant guidance quickly

## Quick Start Guide

### For New Users

1. **Understand the Structure**: Review the [Workflow-Based Organization](#workflow-based-organization) below
2. **Choose Your Starting Point**: Navigate to the workflow that matches your current development phase
3. **Reference Standards**: Check [SharedGuidelines](#-sharedguidelines) for cross-cutting standards that apply to all workflows
4. **Follow the Flow**: Use workflow integration guidance to transition between development phases

### For Specific Tasks

**Starting a New Project:**
1. Begin with [SharedGuidelines/Configuration/core-principles](SharedGuidelines/Configuration/core-principles.instructions.md)
2. Move to [CoreDevelopment](CoreDevelopment/) for AL fundamentals
3. Apply [SharedGuidelines/Standards](SharedGuidelines/Standards/) throughout development

**Adding Tests:**
1. Review [CoreDevelopment](CoreDevelopment/) patterns being tested
2. Follow [TestingValidation/testing-strategy](TestingValidation/testing-strategy.instructions.md)
3. Use [SharedGuidelines/Standards](SharedGuidelines/Standards/) for consistent test code

**Performance Issues:**
1. Check [PerformanceOptimization](PerformanceOptimization/) for optimization techniques
2. Reference [CoreDevelopment/object-patterns](CoreDevelopment/object-patterns.instructions.md) for efficient patterns
3. Validate with [TestingValidation](TestingValidation/) approaches

## Workflow-Based Organization

### 🏗️ CoreDevelopment
**Purpose**: AL language fundamentals and object development patterns
- [`al-development-guide.instructions.md`](CoreDevelopment/al-development-guide.instructions.md) - Comprehensive AL language guidance and development practices
- [`coding-standards.instructions.md`](CoreDevelopment/coding-standards.instructions.md) - Code structure and formatting standards
- [`object-patterns.instructions.md`](CoreDevelopment/object-patterns.instructions.md) - Table, page, codeunit, and other AL object patterns

**When to use**: Creating new AL objects, implementing business logic, following AL best practices

### 🧪 TestingValidation
**Purpose**: Testing strategies and quality assurance processes
- [`testing-strategy.instructions.md`](TestingValidation/testing-strategy.instructions.md) - Comprehensive testing methodology and frameworks
- [`test-data-patterns.instructions.md`](TestingValidation/test-data-patterns.instructions.md) - Test data generation and management
- [`quality-validation.instructions.md`](TestingValidation/quality-validation.instructions.md) - Linting, code review, and validation processes

**When to use**: Writing tests, validating code quality, ensuring compliance with standards

### 🔄 IntegrationDeployment
**Purpose**: Integration patterns and deployment strategies
- [`integration-patterns.instructions.md`](IntegrationDeployment/integration-patterns.instructions.md) - Business Central integration and API development
- [`accessibility-standards.instructions.md`](IntegrationDeployment/accessibility-standards.instructions.md) - Procedure accessibility and testability requirements

**When to use**: Integrating with external systems, deploying extensions, ensuring accessibility

### ⚡ PerformanceOptimization
**Purpose**: Performance tuning and optimization techniques
- [`optimization-guide.instructions.md`](PerformanceOptimization/optimization-guide.instructions.md) - Database performance, UI optimization, and monitoring

**When to use**: Optimizing existing code, improving performance, addressing bottlenecks

### 📦 AppSourcePublishing
**Purpose**: AppSource marketplace compliance and publishing
- [`appsource-requirements.instructions.md`](AppSourcePublishing/appsource-requirements.instructions.md) - Marketplace requirements and publishing workflow

**When to use**: Preparing extensions for AppSource, ensuring marketplace compliance

### 🔗 SharedGuidelines
**Purpose**: Cross-cutting standards that apply across all workflows

#### [Standards/](SharedGuidelines/Standards/)
- [`naming-conventions.instructions.md`](SharedGuidelines/Standards/naming-conventions.instructions.md) - Comprehensive naming rules for all AL objects
- [`code-style.instructions.md`](SharedGuidelines/Standards/code-style.instructions.md) - Code formatting and style guidelines
- [`error-handling.instructions.md`](SharedGuidelines/Standards/error-handling.instructions.md) - Error handling patterns and best practices

#### [Configuration/](SharedGuidelines/Configuration/)
- [`core-principles.instructions.md`](SharedGuidelines/Configuration/core-principles.instructions.md) - Fundamental AL development principles
- [`ai-assistant-guidelines.instructions.md`](SharedGuidelines/Configuration/ai-assistant-guidelines.instructions.md) - GitHub Copilot configuration and behavior

## Navigation Guide

### Finding Specific Guidelines

**By Development Phase:**
- Starting new project → [CoreDevelopment](CoreDevelopment/)
- Writing tests → [TestingValidation](TestingValidation/)
- Adding integrations → [IntegrationDeployment](IntegrationDeployment/)
- Fixing performance → [PerformanceOptimization](PerformanceOptimization/)
- Publishing to AppSource → [AppSourcePublishing](AppSourcePublishing/)

**By Topic:**
- Object naming → [SharedGuidelines/Standards/naming-conventions](SharedGuidelines/Standards/naming-conventions.instructions.md)
- Code formatting → [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md)
- Error handling → [SharedGuidelines/Standards/error-handling](SharedGuidelines/Standards/error-handling.instructions.md)
- Core principles → [SharedGuidelines/Configuration/core-principles](SharedGuidelines/Configuration/core-principles.instructions.md)

**By AL Object Type:**
- Tables → [CoreDevelopment/object-patterns](CoreDevelopment/object-patterns.instructions.md) + [SharedGuidelines/Standards/naming-conventions](SharedGuidelines/Standards/naming-conventions.instructions.md)
- Pages → [CoreDevelopment/al-development-guide](CoreDevelopment/al-development-guide.instructions.md) + [IntegrationDeployment/accessibility-standards](IntegrationDeployment/accessibility-standards.instructions.md)
- Codeunits → [CoreDevelopment/object-patterns](CoreDevelopment/object-patterns.instructions.md) + [TestingValidation/testing-strategy](TestingValidation/testing-strategy.instructions.md)
- Test Objects → [TestingValidation/](TestingValidation/) + [SharedGuidelines/Standards/](SharedGuidelines/Standards/)

**Quick Reference:**
- All instruction files use `.instructions.md` extension for GitHub Copilot recognition
- Each workflow folder contains comprehensive README with file descriptions
- Cross-references link related content across workflows

## Search and Discovery Guide

### How to Find Information Quickly

**By Common Development Tasks:**
- **Fixing Linter Errors**: [TestingValidation/quality-validation](TestingValidation/quality-validation.instructions.md)
- **Performance Issues**: [PerformanceOptimization/optimization-guide](PerformanceOptimization/optimization-guide.instructions.md)
- **Naming Questions**: [SharedGuidelines/Standards/naming-conventions](SharedGuidelines/Standards/naming-conventions.instructions.md)
- **Error Handling**: [SharedGuidelines/Standards/error-handling](SharedGuidelines/Standards/error-handling.instructions.md)
- **Code Style Questions**: [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md)

**By Development Context:**
- **New Feature Development**: [CoreDevelopment](CoreDevelopment/) → [TestingValidation](TestingValidation/)
- **Integration Projects**: [IntegrationDeployment](IntegrationDeployment/) + [SharedGuidelines/Standards](SharedGuidelines/Standards/)
- **AppSource Preparation**: [AppSourcePublishing](AppSourcePublishing/) + ALL previous workflows
- **Code Reviews**: [SharedGuidelines/Standards](SharedGuidelines/Standards/) + [TestingValidation/quality-validation](TestingValidation/quality-validation.instructions.md)

**Search Keywords for GitHub/IDE:**
- **AL Language**: `AL`, `Business Central`, `Dynamics 365`, `table`, `page`, `codeunit`, `report`
- **Development Process**: `testing`, `validation`, `integration`, `performance`, `optimization`
- **Quality**: `linting`, `error handling`, `naming conventions`, `code style`
- **Business Central Concepts**: `extensions`, `AppSource`, `APIs`, `accessibility`

## Master Index - Topic-Based Navigation

### AL Object Development
- **Table Creation**: [CoreDevelopment/object-patterns](CoreDevelopment/object-patterns.instructions.md#tables-and-table-extensions) | [SharedGuidelines/Standards/naming-conventions](SharedGuidelines/Standards/naming-conventions.instructions.md#object-naming)
- **Page Development**: [CoreDevelopment/object-patterns](CoreDevelopment/object-patterns.instructions.md#pages-and-page-extensions) | [CoreDevelopment/coding-standards](CoreDevelopment/coding-standards.instructions.md#tooltips)
- **Codeunit Patterns**: [CoreDevelopment/object-patterns](CoreDevelopment/object-patterns.instructions.md#codeunits) | [SharedGuidelines/Standards/error-handling](SharedGuidelines/Standards/error-handling.instructions.md)
- **Report Development**: [CoreDevelopment/object-patterns](CoreDevelopment/object-patterns.instructions.md#reports-and-report-extensions) | [CoreDevelopment/al-development-guide](CoreDevelopment/al-development-guide.instructions.md)

### Code Quality and Standards
- **Naming Conventions**: [SharedGuidelines/Standards/naming-conventions](SharedGuidelines/Standards/naming-conventions.instructions.md) | [CoreDevelopment/coding-standards](CoreDevelopment/coding-standards.instructions.md#prefix-guidelines)
- **Code Style**: [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md) | [CoreDevelopment/coding-standards](CoreDevelopment/coding-standards.instructions.md)
- **Error Handling**: [SharedGuidelines/Standards/error-handling](SharedGuidelines/Standards/error-handling.instructions.md) | [CoreDevelopment/al-development-guide](CoreDevelopment/al-development-guide.instructions.md#error-handling-patterns)
- **Linter Validation**: [TestingValidation/quality-validation](TestingValidation/quality-validation.instructions.md) | [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md#troubleshooting)

### Testing and Validation
- **Testing Strategy**: [TestingValidation/testing-strategy](TestingValidation/testing-strategy.instructions.md) | [TestingValidation/quality-validation](TestingValidation/quality-validation.instructions.md)
- **Test Data Generation**: [TestingValidation/test-data-patterns](TestingValidation/test-data-patterns.instructions.md) | [TestingValidation/testing-strategy](TestingValidation/testing-strategy.instructions.md#test-data-management)
- **Quality Validation**: [TestingValidation/quality-validation](TestingValidation/quality-validation.instructions.md) | [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md)
- **X Prefix Requirements**: [TestingValidation/test-data-patterns](TestingValidation/test-data-patterns.instructions.md#test-data-prefixing-requirements) | [TestingValidation/testing-strategy](TestingValidation/testing-strategy.instructions.md#core-testing-principles)

### AL Language Features
- **Variable Declaration**: [SharedGuidelines/Standards/naming-conventions](SharedGuidelines/Standards/naming-conventions.instructions.md#variables-and-parameters) | [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md#variable-naming-conventions)
- **Text Constants**: [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md#text-constants-and-localization) | [CoreDevelopment/coding-standards](CoreDevelopment/coding-standards.instructions.md#text-constants-and-localization)
- **Performance Patterns**: [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md#performance-considerations) | [CoreDevelopment/al-development-guide](CoreDevelopment/al-development-guide.instructions.md#performance-optimization)
- **Object Qualification**: [SharedGuidelines/Standards/code-style](SharedGuidelines/Standards/code-style.instructions.md#object-property-qualification) | [CoreDevelopment/al-development-guide](CoreDevelopment/al-development-guide.instructions.md)

### Development Workflow Map
**Phase 1**: Start with [SharedGuidelines/Configuration/core-principles](SharedGuidelines/Configuration/core-principles.instructions.md) for foundational understanding  
**Phase 2**: Apply [CoreDevelopment](CoreDevelopment/) patterns for object creation and development  
**Phase 3**: Implement [TestingValidation](TestingValidation/) for quality assurance  
**Phase 4**: Use [PerformanceOptimization](PerformanceOptimization/) for optimization  
**Phase 5**: Follow [AppSourcePublishing](AppSourcePublishing/) for marketplace compliance  
**Always**: Reference [SharedGuidelines/Standards](SharedGuidelines/Standards/) for consistent standards

## Workflow Integration

### Primary Workflow Connections
- **CoreDevelopment** ↔ **SharedGuidelines**: Core development uses shared standards as foundation
- **TestingValidation** ← **CoreDevelopment**: Testing validates development patterns and implementation
- **IntegrationDeployment** ← **CoreDevelopment**: Integration builds on core development patterns
- **PerformanceOptimization** ← **CoreDevelopment**: Optimization improves development outcomes
- **AppSourcePublishing** ← **All Workflows**: Publishing requires compliance across all areas

### Development Flow
1. **Foundation**: Start with [SharedGuidelines/Configuration/core-principles](SharedGuidelines/Configuration/core-principles.instructions.md)
2. **Development**: Use [CoreDevelopment](CoreDevelopment/) with [SharedGuidelines/Standards](SharedGuidelines/Standards/)
3. **Quality Assurance**: Apply [TestingValidation](TestingValidation/) processes
4. **Integration**: Follow [IntegrationDeployment](IntegrationDeployment/) when needed
5. **Optimization**: Use [PerformanceOptimization](PerformanceOptimization/) for performance tuning
6. **Publishing**: Complete [AppSourcePublishing](AppSourcePublishing/) for marketplace

### Transition Points
- **Development → Testing**: Move from [CoreDevelopment](CoreDevelopment/) to [TestingValidation](TestingValidation/)
- **Testing → Optimization**: Use [TestingValidation](TestingValidation/) results to guide [PerformanceOptimization](PerformanceOptimization/)
- **Integration throughout**: Apply [IntegrationDeployment](IntegrationDeployment/) patterns during development
- **Standards always**: Reference [SharedGuidelines](SharedGuidelines/) consistently across all workflows

## File Organization Benefits

### Meaningful Names Strategy
**Purpose-Driven Naming**: Files named by function, not technical structure
- `quality-validation.instructions.md` (function) vs `linter_check.instructions.md` (technical)
- `al-development-guide.instructions.md` (purpose) vs `al_code.instructions.md` (technical)

**Workflow Context**: Files grouped by when they're used in AL development lifecycle
- Development phase files in [CoreDevelopment](CoreDevelopment/)
- Testing phase files in [TestingValidation](TestingValidation/)
- Cross-cutting standards in [SharedGuidelines](SharedGuidelines/)

### Enhanced Discoverability
**Multiple Navigation Paths**: Find content through:
- Workflow-based browsing ([CoreDevelopment](CoreDevelopment/) → specific files)
- Topic-based search (error handling → [SharedGuidelines/Standards/error-handling](SharedGuidelines/Standards/error-handling.instructions.md))
- Development phase navigation (testing → [TestingValidation](TestingValidation/))

**Cross-Reference Network**: Related content linked rather than duplicated
- Single source of truth in [SharedGuidelines](SharedGuidelines/)
- Workflow-specific guidance references shared standards
- Clear integration points between workflows

## Contributing Guidelines

### Maintaining the Structure

**Adding New Content:**
1. **Identify Workflow**: Determine which business workflow the content supports
2. **Check SharedGuidelines**: Verify if content is cross-cutting or workflow-specific
3. **Avoid Duplication**: Reference existing content rather than duplicating
4. **Maintain AL Headers**: Ensure all `.instructions.md` files have proper `applyTo: '**/*.al'`

**Modifying Existing Content:**
1. **Single Source Rule**: Only update content in its primary location
2. **Update Cross-References**: Verify all references to modified content remain accurate
3. **Test GitHub Copilot**: Ensure AI can still access and apply modified content
4. **Validate Links**: Check that all internal links continue to work

### Content Quality Standards
- **GitHub Copilot Integration**: All content must support AI assistant integration
- **Meaningful Names**: File names must be purpose-driven and descriptive
- **Cross-References**: Prefer references over content duplication
- **Workflow Integrity**: Each workflow must maintain clear business purpose
- **Practical Examples**: Include AL code samples and real-world scenarios

### Workflow-Specific Guidelines
**CoreDevelopment**: Focus on AL language fundamentals and core patterns
**TestingValidation**: Emphasize quality assurance and testing strategies
**IntegrationDeployment**: Cover integration patterns and accessibility
**PerformanceOptimization**: Address performance tuning and optimization
**AppSourcePublishing**: Ensure marketplace compliance and standards
**SharedGuidelines**: Maintain cross-cutting standards that apply everywhere

## GitHub Copilot Integration Benefits

### Optimized for AI Accessibility
**Standardized File Structure**: All instruction files use `.instructions.md` extension for consistent AI recognition
**Workflow Context**: AI assistants can easily navigate from high-level workflows to specific implementation guidance
**Cross-Reference Network**: Related content linked to provide comprehensive context without duplication

### Enhanced Development Productivity
**Meaningful Organization**: AI can quickly locate relevant guidelines based on development context
**Single Source of Truth**: No conflicting guidance - clear standards referenced across workflows
**Progressive Detail**: From overview to implementation details through workflow hierarchy

### AI-Friendly Features
- **Consistent Headers**: All instruction files include proper `applyTo: '**/*.al'` metadata
- **Cross-Workflow References**: Clear navigation between related concepts
- **Practical Examples**: Code samples and implementation patterns for AI application
- **Search Optimization**: Keywords and topics integrated for enhanced discoverability

## Project Goals Achieved

✅ **Meaningful File Names**: All files have descriptive, purpose-driven names that clearly indicate their function  
✅ **Good Indexes**: Comprehensive navigation and workflow-based organization for enhanced discoverability  
✅ **No Duplication**: Single source of truth for all standards and guidelines with cross-references  
✅ **GitHub Copilot Integration**: All instruction files accessible and properly formatted for AI assistants  
✅ **Workflow Organization**: Logical business process organization matching AL development lifecycle  
✅ **Enhanced Navigation**: Multiple pathways to find information (by phase, topic, object type, task)  

## Support and Navigation

### Quick Reference Links
- 🏠 **[Main README](README.md)** - This navigation hub
- 📋 **All Workflows** - Navigate using sections above
- 🔗 **[SharedGuidelines](SharedGuidelines/)** - Cross-cutting standards
- 🎯 **[Quick Start](#quick-start-guide)** - Get started immediately

### For Questions and Issues
1. **Check workflow README files** for detailed guidance on specific development phases
2. **Review SharedGuidelines** for cross-cutting standards and common patterns
3. **Use meaningful file names** to locate specific guidance quickly
4. **Follow cross-references** for related content and comprehensive context
5. **Reference navigation guides** above for multiple discovery pathways

### Workflow Navigation
- **[CoreDevelopment](CoreDevelopment/)** - AL fundamentals and object patterns
- **[TestingValidation](TestingValidation/)** - Testing strategies and quality assurance
- **[IntegrationDeployment](IntegrationDeployment/)** - Integration and deployment guidance
- **[PerformanceOptimization](PerformanceOptimization/)** - Performance tuning and optimization
- **[AppSourcePublishing](AppSourcePublishing/)** - Marketplace compliance and publishing
- **[SharedGuidelines](SharedGuidelines/)** - Cross-cutting standards and configuration

---

**Repository Structure**: Workflow-based organization for enhanced AL development productivity and GitHub Copilot integration.
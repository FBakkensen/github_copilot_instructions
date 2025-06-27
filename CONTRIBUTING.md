# Contributing to AL/Business Central GitHub Copilot Instructions

Thank you for your interest in contributing to this project! This repository provides comprehensive AL development guidelines for Microsoft Dynamics 365 Business Central, and we welcome contributions from the community.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Getting Started](#getting-started)
- [Submitting Changes](#submitting-changes)
- [Content Guidelines](#content-guidelines)
- [Project-Specific Guidelines](#project-specific-guidelines)
- [Questions and Support](#questions-and-support)

## Code of Conduct

We are committed to providing a welcoming and inclusive environment for all contributors. By participating in this project, you agree to abide by the following principles:

- **Be respectful**: Treat all community members with respect and kindness
- **Be collaborative**: Work together constructively and help others learn
- **Be inclusive**: Welcome newcomers and foster an environment where everyone can contribute
- **Be professional**: Keep discussions focused on the project and avoid personal attacks
- **Be patient**: Remember that everyone has different experience levels and perspectives

## How to Contribute

There are many ways to contribute to this project:

- **Improve documentation**: Fix typos, clarify instructions, or add missing information
- **Add new content**: Contribute new AL development guidelines or best practices
- **Update existing content**: Keep guidelines current with latest AL/Business Central features
- **Report issues**: Identify problems or gaps in the documentation
- **Review pull requests**: Help maintain quality by reviewing contributions from others

## Getting Started

### 1. Fork the Repository

1. Navigate to the [repository on GitHub](https://github.com/FBakkensen/github_copilot_instructions)
2. Click the "Fork" button in the top-right corner
3. Clone your fork to your local machine:

```bash
git clone https://github.com/YOUR-USERNAME/github_copilot_instructions.git
cd github_copilot_instructions
```

### 2. Set Up Your Development Environment

1. Create a new branch for your changes:

```bash
git checkout -b feature/your-feature-name
```

2. Make sure you have a text editor that supports Markdown
3. Familiarize yourself with the [repository structure](README.md#workflow-based-organization)

### 3. Understand the Repository Structure

Before making changes, please review:
- **[README.md](README.md)**: Overview and navigation guide
- **[Workflow-Based Organization](README.md#workflow-based-organization)**: How content is organized
- **[Contributing Guidelines in README](README.md#contributing-guidelines)**: Technical content guidelines

## Submitting Changes

### 1. Making Changes

- Make focused, atomic changes that address a single issue or improvement
- Follow the existing file naming conventions (descriptive, purpose-driven names)
- Ensure your changes align with the project's workflow-based organization
- Test any links or references you add

### 2. Commit Guidelines

Write clear, descriptive commit messages following this format:

```
type: brief description of change

More detailed explanation if needed
- Specific changes made
- Rationale for changes
```

**Commit types:**
- `feat`: New content or features
- `fix`: Bug fixes or corrections
- `docs`: Documentation improvements
- `refactor`: Reorganizing content without changing meaning
- `style`: Formatting or style improvements

**Examples:**
```bash
git commit -m "feat: add error handling patterns for API integration"
git commit -m "fix: correct broken links in testing strategy guide"
git commit -m "docs: clarify naming conventions for page objects"
```

### 3. Submitting a Pull Request

1. Push your changes to your fork:

```bash
git push origin feature/your-feature-name
```

2. Navigate to the original repository on GitHub
3. Click "New Pull Request"
4. Select your branch and provide a clear description:

**Pull Request Template:**
```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Documentation update
- [ ] Breaking change (fix or feature that would cause existing functionality to change)

## Testing
- [ ] I have verified all links work correctly
- [ ] I have checked that new content follows the established patterns
- [ ] I have reviewed the content for spelling and grammar

## Checklist
- [ ] My changes follow the project's style guidelines
- [ ] I have performed a self-review of my own changes
- [ ] My changes align with the workflow-based organization
- [ ] I have referenced any related issues
```

## Content Guidelines

### General Requirements

1. **Quality**: Ensure content is accurate, well-written, and helpful
2. **Consistency**: Follow existing patterns and terminology
3. **Clarity**: Write for your intended audience with clear, actionable guidance
4. **Completeness**: Include necessary context and examples

### Markdown Standards

- Use proper heading hierarchy (start with `#`, then `##`, etc.)
- Include table of contents for longer documents
- Use code blocks for AL code examples with appropriate syntax highlighting
- Include meaningful alt text for any images
- Use relative links for internal references

### Content Organization

Follow the existing [workflow-based organization](README.md#workflow-based-organization):
- **CoreDevelopment**: AL fundamentals and object patterns
- **TestingValidation**: Testing strategies and quality assurance
- **IntegrationDeployment**: Integration patterns and deployment
- **PerformanceOptimization**: Performance tuning and optimization
- **AppSourcePublishing**: Marketplace compliance and publishing
- **SharedGuidelines**: Cross-cutting standards and configuration

## Project-Specific Guidelines

This repository has specific technical guidelines for AL development content. Please review the detailed guidelines in [README.md](README.md#contributing-guidelines), which cover:

### Content Structure Guidelines
- **Workflow Integration**: How content fits into development workflows
- **Cross-References**: Linking related content without duplication
- **GitHub Copilot Integration**: Ensuring AI accessibility
- **AL Headers**: Proper `applyTo: '**/*.al'` configuration

### Content Quality Standards
- **Meaningful Names**: Purpose-driven file naming
- **Single Source of Truth**: Avoid content duplication
- **Practical Examples**: Include AL code samples and scenarios
- **Workflow Integrity**: Maintain clear business purpose

## Questions and Support

### Getting Help

- **Documentation Questions**: Review the [README.md](README.md) navigation guides
- **Technical Issues**: Check existing [issues](https://github.com/FBakkensen/github_copilot_instructions/issues)
- **General Questions**: Open a new issue with the "question" label

### Before Opening an Issue

1. Search existing issues to avoid duplicates
2. Check the [README.md](README.md) for relevant guidance
3. Review the [workflow-specific documentation](README.md#workflow-based-organization)

### Issue Guidelines

When opening an issue, please include:
- Clear, descriptive title
- Detailed description of the problem or suggestion
- Steps to reproduce (for bugs)
- Expected vs. actual behavior
- Relevant file paths or sections

---

Thank you for contributing to the AL/Business Central GitHub Copilot Instructions project! Your contributions help improve AL development practices for the entire community.
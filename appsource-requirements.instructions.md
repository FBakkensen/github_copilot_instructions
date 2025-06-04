---
applyTo: '**/*.al'
---
# AppSource Requirements

This document outlines the requirements for creating AppSource-ready extensions for Business Central.

## App Identity and Metadata

1. Proper app identity in app.json:
   - Unique publisher name
   - Unique app ID
   - Descriptive app name
   - Proper version numbering
   - Accurate app description
   - Appropriate app category

2. Clear dependency management:
   - Explicitly declare all dependencies
   - Use proper version ranges for dependencies
   - Minimize dependencies when possible
   - Test with all supported versions of dependencies

## Documentation Requirements

1. Comprehensive application documentation:
   - User guides
   - Administrator guides
   - Installation instructions
   - Configuration guides
   - Troubleshooting information

2. Per-object documentation:
   - XML documentation comments for public methods
   - Clear descriptions of object purpose
   - Parameter documentation
   - Return value documentation
   - Exception documentation

## Technical Requirements

1. Implementation of telemetry:
   - Track usage patterns
   - Monitor performance
   - Log errors and exceptions
   - Implement proper telemetry privacy controls

2. Proper error handling and user feedback:
   - Actionable error messages
   - Clear user guidance
   - Proper error logging
   - Graceful degradation on failure

3. Compliance with Microsoft's technical validation requirements:
   - Pass all AppSource validation tests
   - Follow all Business Central design guidelines
   - Implement proper security measures
   - Follow performance best practices

## Localization and Accessibility

1. Multi-language support when appropriate:
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

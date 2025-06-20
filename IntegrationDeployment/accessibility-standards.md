# Accessibility Standards for AL Development

This document outlines rules for procedure accessibility in AL files to ensure proper testability, maintainability, and proper encapsulation practices in Business Central development.

## Procedure Accessibility Rules

1. **Internal Procedures**: Internal procedures in the main app should remain `internal`. They are accessible to the test app and do not need to be made `public`.
2. **Do Not Use Local Procedures**: Do not use `local` procedures, as they cannot be accessed or tested from the test app. All procedures that need to be accessed from the test app should be marked as `internal`.

## Best Practices for Testability

### Access Control Guidelines
- Use `internal` procedures instead of `local` for better testability
- Keep procedures `internal` unless they need to be exposed to other extensions
- Make procedures `public` only when they form part of the extension's public API
- Document the intended accessibility level in procedure comments

### Testing Considerations
- Design procedures with testing in mind from the start
- Ensure critical business logic is accessible to test codeunits
- Use dependency injection patterns where appropriate for external dependencies
- Consider creating test-specific interfaces for complex integrations

### Encapsulation Balance
- Maintain proper encapsulation while ensuring testability
- Group related procedures logically within codeunits
- Use clear naming conventions that indicate the intended usage scope
- Document public interfaces thoroughly for consumers

By following these accessibility standards, you ensure that your code remains testable while maintaining proper encapsulation and access control throughout your AL development workflow.

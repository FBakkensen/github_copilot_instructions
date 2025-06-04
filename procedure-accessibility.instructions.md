---
applyTo: '**/*.al'
---
# Procedure Accessibility for Testability

This document outlines rules for procedure accessibility in AL files to ensure proper testability and maintain encapsulation in the main app.

## Rules

1. **Internal Procedures**: Internal procedures in the main app should remain `internal`. They are accessible to the test app and do not need to be made `public`.
2. **Do Not Use Local Procedures**: Do not use `local` procedures, as they cannot be accessed or tested from the test app. All procedures that need to be accessed from the test app should be marked as `internal`.

By following these rules, you ensure that your code remains testable while maintaining proper encapsulation and access control.

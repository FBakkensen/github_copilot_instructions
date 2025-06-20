# AI Assistant Guidelines for AL Development

## Code Quality and Standards

1. **Always Check for Linter Errors**: Before completing any code changes, check for and fix linter errors in the affected files. Use the diagnostics tool to identify issues and ensure the code follows AL best practices.

2. **Follow AL Code Style Guidelines**: Adhere to the AL code style guidelines specified in the `al_code_style.md` file. This includes proper variable naming, code formatting, object property qualification, and string formatting.

3. **Maintain Backward Compatibility**: When modifying existing code, ensure backward compatibility unless explicitly instructed otherwise. Preserve method signatures and parameters.

4. **Document Code Changes**: Add appropriate comments to explain complex logic or business rules. Use XML documentation comments for procedures.

## Project Structure

1. **Respect Existing Architecture**: Follow the existing architectural patterns and design principles in the codebase.

2. **Use Proper Object IDs**: When creating new objects, use the appropriate ID ranges as defined in the project.

3. **Maintain Object Naming Conventions**: Follow the established naming conventions for objects, including the required prefix "NALICF".

## Implementation Guidelines

1. **Centralized Utilities**: Use centralized utility codeunits when available instead of duplicating functionality.

2. **Error Handling**: Implement proper error handling with descriptive error messages.

3. **Performance Considerations**: Write code with performance in mind, especially for operations that might be executed frequently.

4. **Testing**: Consider testability when implementing new features or modifying existing ones.

## Before Submitting Changes

1. **Review Code**: Review the code for logical errors, edge cases, and potential improvements.

2. **Check for Linter Errors**: Ensure there are no linter errors in the modified files.

3. **Verify Functionality**: Confirm that the implemented changes meet the requirements and work as expected.

4. **Document Decisions**: Document any significant decisions or trade-offs made during implementation.

By following these instructions, you'll contribute high-quality, maintainable code to the project.

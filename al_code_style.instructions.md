---
applyTo: '**/*.al'
---
# AL Code Style Guidelines

This document outlines the coding standards and best practices for AL code in this project. Following these guidelines ensures consistent, maintainable, and high-quality code.

## Variable Naming Conventions

1. **PascalCase for Object Names**: Use PascalCase for all object names (tables, pages, codeunits, etc.)
   ```al
   codeunit 50100 "Sales Order Processor"
   ```

2. **PascalCase for Variable Names**: Use PascalCase for all variable names
   ```al
   var
       Customer: Record Customer;
       SalesHeader: Record "Sales Header";
       TotalAmount: Decimal;
   ```

3. **Prefix Temporary Variables**: Use prefix 'Temp' for temporary records
   ```al
   var
       TempSalesLine: Record "Sales Line" temporary;
   ```

4. **Variable Declaration Order**: Variables should be ordered by type in the following sequence:
   - Record
   - Report
   - Codeunit
   - XmlPort
   - Page
   - Query
   - Notification
   - BigText
   - DateFormula
   - RecordId
   - RecordRef
   - FieldRef
   - FilterPageBuilder
   - Other types (Text, Integer, Decimal, etc.)

## Code Formatting and Indentation

1. **Indentation**: Use 4 spaces for indentation (not tabs)

2. **Line Length**: Keep lines under 120 characters when possible

3. **Braces**: Place opening braces on the same line as the statement
   ```al
   if Customer.Find() then begin
       // Code here
   end;
   ```

4. **BEGIN..END Usage**: Only use BEGIN..END to enclose compound statements (multiple lines)
   ```al
   // Correct
   if Customer.Find() then
       Customer.Delete();

   // Also correct (for multiple statements)
   if Customer.Find() then begin
       Customer.CalcFields("Balance (LCY)");
       Customer.Delete();
   end;
   ```

5. **IF-ELSE Structure**: Each 'if' keyword should start a new line
   ```al
   if Condition1 then
       Statement1
   else if Condition2 then
       Statement2
   else
       Statement3;
   ```

6. **CASE Statement**: Use CASE instead of nested IF-THEN-ELSE when comparing the same variable against multiple values
   ```al
   // Instead of this:
   if Type = Type::Item then
       ProcessItem()
   else if Type = Type::Resource then
       ProcessResource()
   else
       ProcessOther();

   // Use this:
   case Type of
       Type::Item:
           ProcessItem();
       Type::Resource:
           ProcessResource();
       else
           ProcessOther();
   end;
   ```

## Object Property Qualification

1. **Use "this" Qualification**: Always use "this" to qualify object properties when accessing them from within the same object
   ```al
   // In a table or page method
   procedure SetStatus(NewStatus: Enum "Status")
   begin
       this.Status := NewStatus;
       this.Modify();
   end;
   ```

2. **Explicit Record References**: Always use explicit record references when accessing fields
   ```al
   // Correct
   Customer.Name := 'CRONUS';

   // Incorrect
   Name := 'CRONUS';
   ```

## String Formatting

1. **Text Constants for String Formatting**: Use text constants for string formatting instead of hardcoded strings
   ```al
   // Define at the top of the object
   var
       CustomerCreatedMsg: Label 'Customer %1 has been created.';

   // Use in code
   Message(CustomerCreatedMsg, Customer."No.");
   ```

2. **String Concatenation**: Use string formatting instead of concatenation
   ```al
   // Instead of this:
   Message('Customer ' + Customer."No." + ' has been created.');

   // Use this:
   Message(CustomerCreatedMsg, Customer."No.");
   ```

3. **Placeholders**: Use numbered placeholders (%1, %2, etc.) in labels
   ```al
   ErrorMsg: Label 'Cannot delete %1 %2 because it has %3 entries.';
   ```

## Error Handling

1. **Descriptive Error Messages**: Provide clear, actionable error messages
   ```al
   if not Customer.Find() then
       Error(CustomerNotFoundErr, CustomerNo);
   ```

2. **Error Constants**: Define error messages as constants
   ```al
   CustomerNotFoundErr: Label 'Customer %1 does not exist.';
   ```

## Comments

1. **Procedure Comments**: Document the purpose of procedures, parameters, and return values
   ```al
   /// <summary>
   /// Calculates the total amount for a sales document.
   /// </summary>
   /// <param name="DocumentType">The type of the sales document.</param>
   /// <param name="DocumentNo">The number of the sales document.</param>
   /// <returns>The total amount of the sales document.</returns>
   procedure CalculateTotalAmount(DocumentType: Enum "Sales Document Type"; DocumentNo: Code[20]): Decimal
   ```

2. **Code Comments**: Add comments to explain complex logic or business rules

## Removing Unused Variables

1. **Remove Unused Variables**: Delete variables that are declared but not used in the code
   ```al
   // If TempRecord is never used, remove it
   var
       Customer: Record Customer;
       // TempRecord: Record "Temp Record";  // Unused - should be removed
   ```

## Performance Considerations

1. **Use FindSet() with Repeat-Until**: For looping through records
   ```al
   if SalesLine.FindSet() then
       repeat
           // Process each record
       until SalesLine.Next() = 0;
   ```

2. **Use SetRange/SetFilter Before Find**: Limit record sets before processing
   ```al
   Customer.SetRange("Country/Region Code", 'US');
   if Customer.FindSet() then
   ```

By following these guidelines, you'll create more maintainable, readable, and efficient AL code.

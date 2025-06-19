---
applyTo: '**/*.al'
---
# AppSource Publishing Requirements and Workflow Guide

This comprehensive guide outlines requirements, processes, and best practices for successfully publishing AL extensions to Microsoft AppSource marketplace for Business Central.

## App Identity and Metadata Requirements

### app.json Configuration
```json
{
    "id": "unique-guid-here",
    "name": "Descriptive App Name",
    "publisher": "YourCompanyName",
    "version": "1.0.0.0",
    "brief": "Short description under 100 characters",
    "description": "Detailed app description explaining value proposition",
    "privacyStatement": "https://yourcompany.com/privacy",
    "EULA": "https://yourcompany.com/eula",
    "help": "https://yourcompany.com/help",
    "url": "https://yourcompany.com",
    "logo": "app-logo.png",
    "dependencies": [
        {
            "id": "63ca2fa4-4f03-4f2b-a480-172fef340d3f",
            "publisher": "Microsoft",
            "name": "System Application",
            "version": "26.0.0.0"
        }
    ],
    "application": "26.0.0.0",
    "platform": "26.0.0.0"
}
```

### Essential Metadata Elements
1. **Proper app identity**:
   - Unique publisher name following Microsoft guidelines
   - Unique app ID (GUID) that will never change
   - Descriptive app name that clearly indicates functionality
   - Proper version numbering following semantic versioning
   - Accurate app description with clear value proposition
   - Appropriate app category selection

2. **Clear dependency management**:
   - Explicitly declare all dependencies with specific versions
   - Use proper version ranges for dependencies (avoid wildcards)
   - Minimize dependencies when possible to reduce conflicts
   - Test compatibility with all supported versions of dependencies
   - Document any third-party library dependencies

## AppSource Publishing Workflow

### Pre-Submission Phase
1. **Development Completion**
   - Complete all functionality according to specifications
   - Implement all required AppSource technical requirements
   - Complete comprehensive testing across all supported Business Central versions

2. **Validation Testing**
   - Run AppSource validation tools locally
   - Perform compliance testing using Microsoft's validation framework
   - Test app installation, upgrade, and uninstallation processes
   - Validate all user scenarios and edge cases

3. **Documentation Preparation**
   - Complete all required documentation (see Documentation Requirements section)
   - Prepare marketing materials and screenshots
   - Create video demonstrations if applicable

### Submission Process
1. **Partner Center Preparation**
   - Set up Microsoft Partner Center account
   - Complete publisher verification process
   - Prepare all required legal and business documentation

2. **App Package Submission**
   - Upload validated app package (.app file)
   - Complete AppSource listing information
   - Submit for Microsoft technical validation

3. **Review and Certification**
   - Address any technical validation feedback
   - Complete business validation requirements
   - Respond to Microsoft reviewer comments promptly

## Documentation Requirements

### Comprehensive Application Documentation
1. **User guides** with step-by-step instructions for all features
2. **Administrator guides** covering installation, configuration, and maintenance
3. **Installation instructions** with system requirements and setup procedures
4. **Configuration guides** for all customizable features and integrations
5. **Troubleshooting information** with common issues and solutions

### Per-Object Documentation Standards
```al
/// <summary>
/// Calculates customer credit limit based on payment history and risk assessment
/// </summary>
/// <param name="CustomerNo">Customer number for credit limit calculation</param>
/// <param name="AssessmentPeriod">Period for historical payment analysis</param>
/// <returns>Recommended credit limit amount in local currency</returns>
/// <exception cref="InvalidCustomerError">Thrown when customer number is invalid</exception>
procedure CalculateCreditLimit(CustomerNo: Code[20]; AssessmentPeriod: DateFormula): Decimal
```

- XML documentation comments for all public methods
- Clear descriptions of object purpose and business value
- Complete parameter documentation with types and constraints
- Return value documentation with expected formats
- Exception documentation for all possible error conditions

## Technical Validation Requirements

### Implementation of Telemetry
```al
procedure LogFeatureUsage(FeatureName: Text; UsageContext: Text)
var
    TelemetryMgt: Codeunit "Telemetry Management";
begin
    TelemetryMgt.LogMessage('Feature Usage', StrSubstNo('Feature: %1, Context: %2', FeatureName, UsageContext));
end;
```

1. **Track usage patterns** to understand feature adoption and user behavior
2. **Monitor performance** of critical operations and identify bottlenecks
3. **Log errors and exceptions** with sufficient context for debugging
4. **Implement proper telemetry privacy controls** and user consent management

### Error Handling and User Feedback
```al
procedure HandleApiError(ErrorCode: Text; ErrorMessage: Text)
begin
    // Log technical details for debugging
    LogError(ErrorCode, ErrorMessage);

    // Provide user-friendly message with actionable guidance
    Error(UserFriendlyErrorMsg, GetActionableGuidance(ErrorCode));
end;
```

1. **Actionable error messages** that help users understand and resolve issues
2. **Clear user guidance** with next steps and recovery options
3. **Proper error logging** with sufficient context for support and debugging
4. **Graceful degradation on failure** to maintain application stability

### Microsoft Technical Validation Compliance
1. **Pass all AppSource validation tests** including automated and manual reviews
2. **Follow all Business Central design guidelines** for UI/UX consistency
3. **Implement proper security measures** including data protection and access control
4. **Follow performance best practices** to ensure scalable operation

## Validation Patterns and Compliance Checklists

### Pre-Submission Validation Checklist
- [ ] App compiles without errors or warnings on all target BC versions
- [ ] All objects follow AL naming conventions and coding standards
- [ ] All user-facing text uses label system for localization
- [ ] Telemetry implementation follows Microsoft guidelines
- [ ] Error handling provides actionable user guidance
- [ ] All public APIs are properly documented
- [ ] App passes Microsoft's automated validation tools
- [ ] Installation and upgrade processes work correctly
- [ ] App uninstalls cleanly without leaving artifacts

### Code Quality Standards for AppSource
```al
// Good: Proper error handling with user guidance
procedure ProcessPayment(Amount: Decimal)
begin
    if Amount <= 0 then
        Error(InvalidAmountErr, Amount);

    if not ValidatePaymentMethod() then
        Error(PaymentMethodErr, GetPaymentSetupGuidance());

    // Process payment with proper exception handling
end;

// Good: Comprehensive telemetry
procedure TrackCustomerInteraction(CustomerNo: Code[20]; InteractionType: Enum "Interaction Type")
begin
    Session.LogMessage('Customer Interaction',
        StrSubstNo('Customer: %1, Type: %2', CustomerNo, InteractionType),
        Verbosity::Normal, DataClassification::CustomerContent);
end;
```

1. **Robust error handling** with meaningful messages and recovery guidance
2. **Comprehensive telemetry** tracking feature usage and performance
3. **Proper data classification** for all data handling operations
4. **Security best practices** including input validation and secure communications
5. **Performance optimization** following AL development best practices

## Localization and Accessibility Standards

### Multi-language Support Implementation
```al
// Label definitions in .xlf files
label
    WelcomeMsg: Label 'Welcome to %1. Click here to get started.', Comment = '%1 = App Name';
    ErrorMsg: Label 'An error occurred while processing your request. Please try again.';

// Usage in AL code
procedure ShowWelcomeMessage()
begin
    Message(WelcomeMsg, ApplicationName);
end;
```

1. **Use label system** for all user-facing text without exceptions
2. **Implement proper translation workflow** with professional translators
3. **Test with all supported languages** including right-to-left languages
4. **Consider cultural differences** in design, colors, and user interactions

### Accessibility Compliance Requirements
1. **Follow WCAG 2.1 AA guidelines** for web accessibility
2. **Test with screen readers** to ensure content is properly announced
3. **Implement proper keyboard navigation** for all interactive elements
4. **Use appropriate color contrast** meeting accessibility standards
5. **Provide alternative text** for all images and visual elements

## Upgrade and Maintenance Strategy

### Proper Upgrade Code Implementation
```al
codeunit 50000 "App Upgrade Management"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        if NavApp.GetCurrentModuleInfo(ModuleInfo) then
            case ModuleInfo.DataVersion.Major of
                1:
                    UpgradeFromVersion1();
                2:
                    UpgradeFromVersion2();
            end;
    end;

    local procedure UpgradeFromVersion1()
    begin
        // Handle data migration from version 1.x
        MigrateCustomerData();
        UpdateFieldStructures();
    end;
}
```

1. **Implement upgrade codeunits** for all version transitions
2. **Handle data schema changes gracefully** with proper migration logic
3. **Provide clear upgrade documentation** with backup recommendations
4. **Test upgrade scenarios thoroughly** across all supported versions

### Maintenance and Support Plan
1. **Regular updates and bug fixes** following Microsoft's release schedule
2. **Security patch process** with expedited timeline for critical issues
3. **Customer support channels** with clear escalation procedures
4. **Feedback mechanism** for feature requests and issue reporting

## AppSource Submission Checklist

### Technical Preparation
- [ ] All AL objects follow Microsoft naming conventions
- [ ] App.json contains all required metadata and proper dependencies
- [ ] Telemetry implementation captures all required events
- [ ] Error handling provides actionable user guidance
- [ ] All documentation is complete and accurate
- [ ] App passes all Microsoft validation tools

### Business Preparation
- [ ] Partner Center account is verified and in good standing
- [ ] Legal documentation (EULA, Privacy Policy) is complete
- [ ] Marketing materials and screenshots are ready
- [ ] Pricing model is defined and documented
- [ ] Support processes are established and documented

### Validation Results
- [ ] App installs successfully on clean Business Central environments
- [ ] All features work as documented across supported BC versions
- [ ] Upgrade scenarios function correctly from previous versions
- [ ] App uninstalls completely without leaving database artifacts
- [ ] Performance meets Microsoft's benchmarks for similar applications

By following this comprehensive guide, AL developers can ensure their extensions meet all AppSource requirements and have the best chance of successful marketplace approval and customer adoption.

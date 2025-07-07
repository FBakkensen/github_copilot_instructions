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

### Comprehensive AppSource Code Quality Examples

```al
// Complete AppSource-compliant table example
table 50100 "ABC Customer Rating"
{
    Caption = 'Customer Rating';
    DataClassification = CustomerContent;
    LookupPageId = "ABC Customer Rating List";
    DrillDownPageId = "ABC Customer Rating List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                TestField("No.");
                if "No." <> xRec."No." then
                    ValidateNumberSequence();
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
            NotBlank = true;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if "Customer No." <> '' then begin
                    Customer.Get("Customer No.");
                    "Customer Name" := Customer.Name;
                end else
                    "Customer Name" := '';
            end;
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Rating Score"; Integer)
        {
            Caption = 'Rating Score';
            DataClassification = CustomerContent;
            MinValue = 1;
            MaxValue = 5;
            NotBlank = true;

            trigger OnValidate()
            begin
                if ("Rating Score" < 1) or ("Rating Score" > 5) then
                    Error(InvalidRatingScoreErr);
            end;
        }
        field(5; "Rating Date"; Date)
        {
            Caption = 'Rating Date';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Rating Date" > Today then
                    Error(FutureDateErr);
            end;
        }
        field(6; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }       
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key("Customer No."; "Customer No.", "Rating Date")
        {
            // Performance key for customer-based queries
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Customer No.", "Customer Name", "Rating Score") { }
        fieldgroup(Brick; "No.", "Customer Name", "Rating Score", "Rating Date") { }
    }

    trigger OnInsert()
    begin
        if "No." = '' then
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");        

        if "Rating Date" = 0D then
            "Rating Date" := Today;
    end;

    trigger OnModify()
    begin
        TestField("No.");
        TestField("Customer No.");
    end;

    trigger OnDelete()
    begin
        CheckDeletionRights();
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvalidRatingScoreErr: Label 'Rating score must be between 1 and 5.';
        FutureDateErr: Label 'Rating date cannot be in the future.';
        DeletionNotAllowedErr: Label 'You do not have permission to delete this rating.';

    local procedure ValidateNumberSequence()
    var
        ABCSetup: Record "ABC Setup";
    begin
        ABCSetup.Get();
        ABCSetup.TestField("Rating No. Series");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        ABCSetup: Record "ABC Setup";
    begin
        ABCSetup.Get();
        exit(ABCSetup."Rating No. Series");
    end;

    local procedure CheckDeletionRights()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
            Error(DeletionNotAllowedErr);

        if not UserSetup."ABC Delete Ratings" then
            Error(DeletionNotAllowedErr);
    end;

    procedure GetRatingStyleExpression(): Text
    begin
        case "Rating Score" of
            1, 2:
                exit('Unfavorable');
            3:
                exit('Ambiguous');
            4, 5:
                exit('Favorable');
            else
                exit('Standard');
        end;
    end;
}

// AppSource-compliant page with proper accessibility
page 50100 "ABC Customer Rating Card"
{
    Caption = 'Customer Rating Card';
    PageType = Card;
    SourceTable = "ABC Customer Rating";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer rating.';
                    ShowMandatory = true;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number for this rating.';
                    ShowMandatory = true;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the customer.';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Rating Score"; Rec."Rating Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rating score from 1 (poor) to 5 (excellent).';
                    ShowMandatory = true;
                    StyleExpr = RatingStyleExpr;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        UpdateRatingStyle();
                    end;
                }
                field("Rating Date"; Rec."Rating Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the rating was given.';
                    ShowMandatory = true;
                    Importance = Promoted;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional comments about the rating.';
                    MultiLine = true;
                }
            }
        }
        area(FactBoxes)
        {
            part(CustomerDetailsFactBox; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Customer No.");
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SubmitRating)
            {
                Caption = 'Submit Rating';
                ToolTip = 'Submit the rating for processing.';
                Image = SendTo;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RatingMgt: Codeunit "ABC Customer Rating Mgt";
                begin
                    if RatingMgt.ValidateCustomerRating(Rec) then begin
                        RatingMgt.ProcessCustomerRating(Rec);
                        CurrPage.Update(false);
                        Message(RatingSubmittedMsg);
                    end;
                end;
            }
            action(CopyRating)
            {
                Caption = 'Copy Rating';
                ToolTip = 'Create a copy of this rating.';
                Image = Copy;
                ApplicationArea = All;

                trigger OnAction()
                var
                    NewRating: Record "ABC Customer Rating";
                    RatingCard: Page "ABC Customer Rating Card";
                begin
                    NewRating.TransferFields(Rec, false);
                    NewRating."No." := '';
                    NewRating."Rating Date" := Today;
                    NewRating.Insert(true);

                    RatingCard.SetRecord(NewRating);
                    RatingCard.RunModal();
                end;
            }
        }
        area(Navigation)
        {
            action(Customer)
            {
                Caption = 'Customer';
                ToolTip = 'View or edit the customer information.';
                Image = Customer;
                ApplicationArea = All;
                RunObject = page "Customer Card";
                RunPageLink = "No." = field("Customer No.");
            }
            action(CustomerRatings)
            {
                Caption = 'All Customer Ratings';
                ToolTip = 'View all ratings for this customer.';
                Image = List;
                ApplicationArea = All;
                RunObject = page "ABC Customer Rating List";
                RunPageLink = "Customer No." = field("Customer No.");
            }
        }
        area(Reporting)
        {
            action(PrintRating)
            {
                Caption = 'Print Rating';
                ToolTip = 'Print the customer rating document.';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"ABC Customer Rating Document", true, true, Rec);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(SubmitRating_Promoted; SubmitRating) { }
                actionref(CopyRating_Promoted; CopyRating) { }
            }
            group(Category_Navigate)
            {
                Caption = 'Navigate';
                actionref(Customer_Promoted; Customer) { }
                actionref(CustomerRatings_Promoted; CustomerRatings) { }
            }
            group(Category_Report)
            {
                Caption = 'Report';
                actionref(PrintRating_Promoted; PrintRating) { }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateRatingStyle();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateRatingStyle();
    end;

    var
        RatingStyleExpr: Text;
        RatingSubmittedMsg: Label 'The rating has been submitted successfully.';

    local procedure UpdateRatingStyle()
    begin
        RatingStyleExpr := Rec.GetRatingStyleExpression();
    end;
}

// AppSource-compliant Setup table with proper validation
table 50101 "ABC Setup"
{
    Caption = 'ABC Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Rating No. Series"; Code[20])
        {
            Caption = 'Rating No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if "Rating No. Series" <> '' then
                    NoSeriesMgt.TestManual("Rating No. Series");
            end;
        }
        field(3; "Default Rating Category"; Enum "ABC Rating Category")
        {
            Caption = 'Default Rating Category';
            DataClassification = CustomerContent;
        }
        field(4; "Auto-Process Ratings"; Boolean)
        {
            Caption = 'Auto-Process Ratings';
            DataClassification = CustomerContent;
        }
        field(5; "Email Notifications"; Boolean)
        {
            Caption = 'Email Notifications';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure GetRecordOnce()
    begin
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}
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

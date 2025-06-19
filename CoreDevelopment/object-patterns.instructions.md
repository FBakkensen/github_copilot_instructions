---
applyTo: '**/*.al'
---
# Object-Specific Guidelines

This document outlines specific guidelines for different object types in Business Central AL code.

## Table of Contents

1. [Tables and Table Extensions](#tables-and-table-extensions)
2. [Pages and Page Extensions](#pages-and-page-extensions)
3. [Codeunits](#codeunits)
4. [Reports and Report Extensions](#reports-and-report-extensions)
5. [XMLPorts](#xmlports)
6. [Queries](#queries)
7. [Search Keywords](#search-keywords)
8. [Cross-References](#cross-references)

## Tables and Table Extensions

### Guidelines
- All fields must include a tooltip
- Field numbers in tables must start with the number defined in app.json
- New fields must use the first available number in the range defined in app.json
- Tooltips in fields always start with 'Specifies '
- Fields on tables must have a Dataclassification property set to `CustomerContent`
- Identifiers on fields on tables should not have a prefix
- Identifiers on fields on tableextensions must have a prefix
- Use appropriate field types for the data they will contain
- Implement proper validation for fields
- Use FlowFields and FlowFilters appropriately

### Complete Table Creation Example

```al
table 50100 "ABC Customer Rating"
{
    Caption = 'Customer Rating';
    DataClassification = CustomerContent;
    LookupPageId = "ABC Customer Rating List";
    DrillDownPageId = "ABC Customer Rating List";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Tooltip = 'Specifies the number of the customer for this rating.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Customer No." <> xRec."Customer No." then
                    ValidateCustomerExists();
            end;
        }
        field(2; "Rating Date"; Date)
        {
            Caption = 'Rating Date';
            Tooltip = 'Specifies the date when the rating was assigned.';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Rating Date" > Today then
                    Error('Rating date cannot be in the future.');
            end;
        }
        field(3; "Rating Score"; Integer)
        {
            Caption = 'Rating Score';
            Tooltip = 'Specifies the rating score from 1 to 5.';
            DataClassification = CustomerContent;
            MinValue = 1;
            MaxValue = 5;
        }
        field(4; "Rating Category"; Enum "ABC Rating Category")
        {
            Caption = 'Rating Category';
            Tooltip = 'Specifies the category of the rating (Service, Quality, Delivery).';
            DataClassification = CustomerContent;
        }
        field(5; Comments; Text[250])
        {
            Caption = 'Comments';
            Tooltip = 'Specifies additional comments about the rating.';
            DataClassification = CustomerContent;
        }
        field(10; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Tooltip = 'Specifies the name of the customer.';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(11; "Average Rating"; Decimal)
        {
            Caption = 'Average Rating';
            Tooltip = 'Specifies the average rating score for this customer.';
            FieldClass = FlowField;
            CalcFormula = average("ABC Customer Rating"."Rating Score" where("Customer No." = field("Customer No.")));
            DecimalPlaces = 1 : 2;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Customer No.", "Rating Date", "Rating Category")
        {
            Clustered = true;
        }
        key(RatingScore; "Rating Score")
        {
            // For performance when filtering by score
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer No.", "Rating Date", "Rating Score", "Rating Category") { }
        fieldgroup(Brick; "Customer No.", "Customer Name", "Rating Score", "Rating Date") { }
    }

    trigger OnInsert()
    begin
        if "Rating Date" = 0D then
            "Rating Date" := Today;
    end;

    trigger OnModify()
    begin
        TestField("Customer No.");
        TestField("Rating Date");
    end;

    local procedure ValidateCustomerExists()
    var
        Customer: Record Customer;
    begin
        if not Customer.Get("Customer No.") then
            Error('Customer %1 does not exist.', "Customer No.");
    end;
}
```

### Table Extension Example

```al
tableextension 50101 "ABC Customer Extension" extends Customer
{
    fields
    {
        field(50100; "ABC Preferred Contact Method"; Code[20])
        {
            Caption = 'Preferred Contact Method';
            Tooltip = 'Specifies the preferred method of contacting this customer.';
            DataClassification = CustomerContent;
            TableRelation = "ABC Contact Method";
        }
        field(50101; "ABC Customer Category"; Enum "ABC Customer Category")
        {
            Caption = 'Customer Category';
            Tooltip = 'Specifies the business category of this customer.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "ABC Customer Category" <> xRec."ABC Customer Category" then
                    UpdateCategoryDependentFields();
            end;
        }
        field(50102; "ABC Last Contact Date"; Date)
        {
            Caption = 'Last Contact Date';
            Tooltip = 'Specifies the date of the last contact with this customer.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50103; "ABC Total Ratings"; Integer)
        {
            Caption = 'Total Ratings';
            Tooltip = 'Specifies the total number of ratings for this customer.';
            FieldClass = FlowField;
            CalcFormula = count("ABC Customer Rating" where("Customer No." = field("No.")));
            Editable = false;
        }
    }

    keys
    {
        key(CustomerCategory; "ABC Customer Category") { }
    }

    local procedure UpdateCategoryDependentFields()
    begin
        // Update related fields based on customer category
        case "ABC Customer Category" of
            "ABC Customer Category"::Premium:
                begin
                    if "ABC Preferred Contact Method" = '' then
                        "ABC Preferred Contact Method" := 'PHONE';
                end;
            "ABC Customer Category"::Standard:
                begin
                    if "ABC Preferred Contact Method" = '' then
                        "ABC Preferred Contact Method" := 'EMAIL';
                end;
        end;
    end;
}

## Pages and Page Extensions

### Guidelines
- No implicit Rec is allowed
- The layout must be defined before the actions
- Identifiers of fields and actions must not be prefixed
- The properties `Promoted` and `PromotedCategory` must not be used for actions, instead use the actionref syntax
- The identifier for a promoted actionref must have a suffix of `_Promoted`
- Tooltips should be on table fields not on the page fields
- Fields must have an ApplicationArea property set to `All`
- Follow the standard Business Central page layout patterns
- Group related fields together
- Use appropriate FastTabs for organizing content
- Implement proper field validation

### Complete Card Page Example

```al
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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rating Date"; Rec."Rating Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Rating Score"; Rec."Rating Score")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Rating Category"; Rec."Rating Category")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                field("Average Rating"; Rec."Average Rating")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
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
            action(CalculateAverageRating)
            {
                Caption = 'Calculate Average Rating';
                Image = Calculate;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomerRatingMgt: Codeunit "ABC Customer Rating Mgt";
                begin
                    CustomerRatingMgt.CalculateAverageRating(Rec."Customer No.");
                    CurrPage.Update(false);
                end;
            }
            action(ViewAllRatings)
            {
                Caption = 'View All Customer Ratings';
                Image = List;
                ApplicationArea = All;
                RunObject = page "ABC Customer Rating List";
                RunPageLink = "Customer No." = field("Customer No.");
            }
        }
        area(Navigation)
        {
            action(Customer)
            {
                Caption = 'Customer';
                Image = Customer;
                ApplicationArea = All;
                RunObject = page "Customer Card";
                RunPageLink = "No." = field("Customer No.");
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(CalculateAverageRating_Promoted; CalculateAverageRating) { }
                actionref(ViewAllRatings_Promoted; ViewAllRatings) { }
            }
            group(Category_Navigate)
            {
                Caption = 'Navigate';
                actionref(Customer_Promoted; Customer) { }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Customer Name", "Average Rating");
    end;
}
```

### Complete List Page Example

```al
page 50101 "ABC Customer Rating List"
{
    Caption = 'Customer Ratings';
    PageType = List;
    SourceTable = "ABC Customer Rating";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "ABC Customer Rating Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Rating Date"; Rec."Rating Date")
                {
                    ApplicationArea = All;
                }
                field("Rating Score"; Rec."Rating Score")
                {
                    ApplicationArea = All;
                    StyleExpr = RatingScoreStyle;
                }
                field("Rating Category"; Rec."Rating Category")
                {
                    ApplicationArea = All;
                }
                field("Average Rating"; Rec."Average Rating")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(CustomerRatingStatistics; "ABC Customer Rating Statistics")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No." = field("Customer No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewRating)
            {
                Caption = 'New Rating';
                Image = New;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomerRating: Record "ABC Customer Rating";
                    CustomerRatingCard: Page "ABC Customer Rating Card";
                begin
                    CustomerRating.Init();
                    CustomerRating."Rating Date" := Today;
                    CustomerRatingCard.SetRecord(CustomerRating);
                    CustomerRatingCard.RunModal();
                end;
            }
            action(ExportToExcel)
            {
                Caption = 'Export to Excel';
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustomerRating: Record "ABC Customer Rating";
                begin
                    CustomerRating.Copy(Rec);
                    CustomerRating.SetCurrentKey("Customer No.", "Rating Date");
                    if CustomerRating.FindFirst() then
                        Report.RunModal(Report::"ABC Customer Ratings Export", true, false, CustomerRating);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_New)
            {
                Caption = 'New';
                actionref(NewRating_Promoted; NewRating) { }
            }
            group(Category_Report)
            {
                Caption = 'Report';
                actionref(ExportToExcel_Promoted; ExportToExcel) { }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Customer Name", "Average Rating");
        SetRatingScoreStyle();
    end;

    var
        RatingScoreStyle: Text;

    local procedure SetRatingScoreStyle()
    begin
        case Rec."Rating Score" of
            1, 2:
                RatingScoreStyle := 'Unfavorable';
            3:
                RatingScoreStyle := 'Ambiguous';
            4, 5:
                RatingScoreStyle := 'Favorable';
            else
                RatingScoreStyle := 'Standard';
        end;
    end;
}
```

### Page Extension Example

```al
pageextension 50100 "ABC Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addafter("Address & Contact")
        {
            group("ABC Rating Information")
            {
                Caption = 'Rating Information';
                field("ABC Customer Category"; Rec."ABC Customer Category")
                {
                    ApplicationArea = All;
                }
                field("ABC Preferred Contact Method"; Rec."ABC Preferred Contact Method")
                {
                    ApplicationArea = All;
                }
                field("ABC Last Contact Date"; Rec."ABC Last Contact Date")
                {
                    ApplicationArea = All;
                }
                field("ABC Total Ratings"; Rec."ABC Total Ratings")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "ABC Customer Rating List";
                }
            }
        }
    }

    actions
    {
        addafter("&Customer")
        {
            group("ABC Rating Actions")
            {
                Caption = 'Ratings';
                action("ABC Customer Ratings")
                {
                    Caption = 'Customer Ratings';
                    Image = Rates;
                    ApplicationArea = All;
                    RunObject = page "ABC Customer Rating List";
                    RunPageLink = "Customer No." = field("No.");
                }
                action("ABC New Rating")
                {
                    Caption = 'New Rating';
                    Image = New;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CustomerRating: Record "ABC Customer Rating";
                        CustomerRatingCard: Page "ABC Customer Rating Card";
                    begin
                        CustomerRating.Init();
                        CustomerRating."Customer No." := Rec."No.";
                        CustomerRating."Rating Date" := Today;
                        CustomerRatingCard.SetRecord(CustomerRating);
                        CustomerRatingCard.RunModal();
                    end;
                }
            }
        }
        addafter(Customer_Promoted)
        {
            group("ABC Rating_Promoted")
            {
                Caption = 'Ratings';
                actionref("ABC Customer Ratings_Promoted"; "ABC Customer Ratings") { }
                actionref("ABC New Rating_Promoted"; "ABC New Rating") { }
            }
        }
    }
}

## Codeunits

### Guidelines
- Procedures must only be marked with `[Scope('OnPrem')]` if this is explicitly stated
- Procedures must follow the Single Responsibility Principle (SRP)
- Check for IsGuiAllowed() before using any GUI functions
- For major functionality create a codeunit with the name of the functionality
- For small functionality create a codeunit with the name of the functionality and the suffix `Mgt`

### Complete Management Codeunit Example

```al
codeunit 50100 "ABC Customer Rating Mgt"
{
    // Management codeunit for customer rating operations

    procedure CalculateAverageRating(CustomerNo: Code[20]): Decimal
    var
        CustomerRating: Record "ABC Customer Rating";
        TotalScore: Decimal;
        RatingCount: Integer;
    begin
        CustomerRating.SetRange("Customer No.", CustomerNo);
        if CustomerRating.FindSet() then begin
            repeat
                TotalScore += CustomerRating."Rating Score";
                RatingCount += 1;
            until CustomerRating.Next() = 0;

            if RatingCount > 0 then
                exit(Round(TotalScore / RatingCount, 0.1));
        end;
        exit(0);
    end;

    procedure GetHighestRatingCustomers(var TempCustomer: Record Customer temporary; MinRating: Decimal)
    var
        Customer: Record Customer;
        CustomerRating: Record "ABC Customer Rating";
        AverageRating: Decimal;
    begin
        TempCustomer.Reset();
        TempCustomer.DeleteAll();

        Customer.SetLoadFields("No.", Name, "Phone No.", "E-Mail");
        if Customer.FindSet() then
            repeat
                AverageRating := CalculateAverageRating(Customer."No.");
                if AverageRating >= MinRating then begin
                    TempCustomer.TransferFields(Customer);
                    TempCustomer.Insert();
                end;
            until Customer.Next() = 0;
    end;

    procedure SendRatingNotification(CustomerNo: Code[20]; RatingScore: Integer)
    var
        Customer: Record Customer;
        NotificationMgt: Codeunit "Notification Management";
        NotificationText: Text;
    begin
        if not Customer.Get(CustomerNo) then
            exit;

        case RatingScore of
            1, 2:
                NotificationText := StrSubstNo('Low rating (%1) received for customer %2 - %3', RatingScore, CustomerNo, Customer.Name);
            5:
                NotificationText := StrSubstNo('Excellent rating (%1) received for customer %2 - %3', RatingScore, CustomerNo, Customer.Name);
        end;

        if NotificationText <> '' then
            if IsGuiAllowed() then
                NotificationMgt.SendNotification(NotificationText, Customer.RecordId);
    end;

    procedure ValidateRatingData(var CustomerRating: Record "ABC Customer Rating"): Boolean
    var
        Customer: Record Customer;
        ErrorMessages: Text;
    begin
        // Comprehensive validation of rating data
        if CustomerRating."Customer No." = '' then
            ErrorMessages += 'Customer No. is required.\';

        if CustomerRating."Rating Date" = 0D then
            ErrorMessages += 'Rating Date is required.\';

        if CustomerRating."Rating Date" > Today then
            ErrorMessages += 'Rating Date cannot be in the future.\';

        if (CustomerRating."Rating Score" < 1) or (CustomerRating."Rating Score" > 5) then
            ErrorMessages += 'Rating Score must be between 1 and 5.\';

        if CustomerRating."Customer No." <> '' then
            if not Customer.Get(CustomerRating."Customer No.") then
                ErrorMessages += StrSubstNo('Customer %1 does not exist.\', CustomerRating."Customer No.");

        if ErrorMessages <> '' then begin
            Error(ErrorMessages);
            exit(false);
        end;

        exit(true);
    end;

    procedure GetRatingStatistics(CustomerNo: Code[20]; var Statistics: Record "ABC Rating Statistics" temporary)
    var
        CustomerRating: Record "ABC Customer Rating";
        RatingCategory: Enum "ABC Rating Category";
    begin
        Statistics.Reset();
        Statistics.DeleteAll();

        CustomerRating.SetRange("Customer No.", CustomerNo);
        if CustomerRating.FindSet() then begin
            repeat
                Statistics.Reset();
                Statistics.SetRange("Rating Category", CustomerRating."Rating Category");
                if Statistics.FindFirst() then begin
                    Statistics."Total Ratings" += 1;
                    Statistics."Total Score" += CustomerRating."Rating Score";
                    Statistics."Average Score" := Statistics."Total Score" / Statistics."Total Ratings";
                    Statistics.Modify();
                end else begin
                    Statistics.Init();
                    Statistics."Customer No." := CustomerNo;
                    Statistics."Rating Category" := CustomerRating."Rating Category";
                    Statistics."Total Ratings" := 1;
                    Statistics."Total Score" := CustomerRating."Rating Score";
                    Statistics."Average Score" := CustomerRating."Rating Score";
                    Statistics.Insert();
                end;
            until CustomerRating.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"ABC Customer Rating", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCustomerRating(var Rec: Record "ABC Customer Rating")
    begin
        // Automatically send notifications for extreme ratings
        if Rec."Rating Score" in [1, 2, 5] then
            SendRatingNotification(Rec."Customer No.", Rec."Rating Score");
    end;
}
```

### Complete Major Functionality Codeunit Example

```al
codeunit 50101 "ABC Customer Rating Workflow"
{
    // Major functionality codeunit with event pattern

    procedure ProcessRatingWorkflow(var CustomerRating: Record "ABC Customer Rating")
    var
        Handled: Boolean;
    begin
        OnBeforeProcessRatingWorkflow(CustomerRating, Handled);
        DoProcessRatingWorkflow(CustomerRating, Handled);
        OnAfterProcessRatingWorkflow(CustomerRating);
    end;

    local procedure DoProcessRatingWorkflow(var CustomerRating: Record "ABC Customer Rating"; var Handled: Boolean)
    var
        CustomerRatingMgt: Codeunit "ABC Customer Rating Mgt";
        Customer: Record Customer;
        ApprovalRequired: Boolean;
    begin
        if Handled then
            exit;

        // Validate the rating data
        CustomerRatingMgt.ValidateRatingData(CustomerRating);

        // Check if approval is required for this rating
        ApprovalRequired := IsApprovalRequired(CustomerRating);

        if ApprovalRequired then begin
            RequestApprovalForRating(CustomerRating);
            CustomerRating.Status := CustomerRating.Status::"Pending Approval";
        end else begin
            CustomerRating.Status := CustomerRating.Status::Approved;
            FinalizeRating(CustomerRating);
        end;

        Handled := true;
    end;

    local procedure IsApprovalRequired(CustomerRating: Record "ABC Customer Rating"): Boolean
    var
        RatingSetup: Record "ABC Rating Setup";
    begin
        if not RatingSetup.Get() then
            exit(false);

        // Require approval for extremely low ratings
        if CustomerRating."Rating Score" <= RatingSetup."Approval Required Below Score" then
            exit(true);

        // Require approval for high-value customers
        if IsHighValueCustomer(CustomerRating."Customer No.") then
            exit(true);

        exit(false);
    end;

    local procedure IsHighValueCustomer(CustomerNo: Code[20]): Boolean
    var
        Customer: Record Customer;
        RatingSetup: Record "ABC Rating Setup";
    begin
        if not Customer.Get(CustomerNo) then
            exit(false);

        if not RatingSetup.Get() then
            exit(false);

        Customer.CalcFields("Balance (LCY)");
        exit(Customer."Balance (LCY)" >= RatingSetup."High Value Customer Threshold");
    end;

    local procedure RequestApprovalForRating(var CustomerRating: Record "ABC Customer Rating")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        if IsGuiAllowed() then
            Message('Rating requires approval due to business rules.');
        
        // Integrate with standard approval workflow if needed
        // WorkflowManagement.HandleEvent(...)
    end;

    local procedure FinalizeRating(var CustomerRating: Record "ABC Customer Rating")
    var
        CustomerRatingMgt: Codeunit "ABC Customer Rating Mgt";
    begin
        CustomerRating."Processed Date" := Today;
        CustomerRating."Processed Time" := Time;
        CustomerRating.Modify(true);

        // Update customer's last contact date
        UpdateCustomerLastContact(CustomerRating."Customer No.");

        // Send notifications if needed
        CustomerRatingMgt.SendRatingNotification(CustomerRating."Customer No.", CustomerRating."Rating Score");
    end;

    local procedure UpdateCustomerLastContact(CustomerNo: Code[20])
    var
        Customer: Record Customer;
    begin
        if Customer.Get(CustomerNo) then begin
            Customer."ABC Last Contact Date" := Today;
            Customer.Modify(true);
        end;
    end;

    [BusinessEvent(false)]
    local procedure OnBeforeProcessRatingWorkflow(var CustomerRating: Record "ABC Customer Rating"; var Handled: Boolean)
    begin
        // Allow other extensions to handle the workflow
    end;

    [BusinessEvent(false)]
    local procedure OnAfterProcessRatingWorkflow(var CustomerRating: Record "ABC Customer Rating")
    begin
        // Allow other extensions to perform additional actions
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterFinalizeRating(CustomerRating: Record "ABC Customer Rating")
    begin
        // Integration event for external systems
    end;
}
```

### API Codeunit Example

```al
codeunit 50102 "ABC Customer Rating API"
{
    // API helper codeunit for external integration

    procedure CreateRatingFromAPI(CustomerNo: Code[20]; RatingScore: Integer; RatingCategory: Text; Comments: Text): Boolean
    var
        CustomerRating: Record "ABC Customer Rating";
        CustomerRatingWorkflow: Codeunit "ABC Customer Rating Workflow";
        RatingCategoryEnum: Enum "ABC Rating Category";
    begin
        // Initialize the rating record
        CustomerRating.Init();
        CustomerRating."Customer No." := CustomerNo;
        CustomerRating."Rating Date" := Today;
        CustomerRating."Rating Score" := RatingScore;
        CustomerRating.Comments := CopyStr(Comments, 1, MaxStrLen(CustomerRating.Comments));

        // Convert text to enum
        if not Evaluate(RatingCategoryEnum, RatingCategory) then
            Error('Invalid rating category: %1', RatingCategory);
        CustomerRating."Rating Category" := RatingCategoryEnum;

        // Insert and process through workflow
        CustomerRating.Insert(true);
        CustomerRatingWorkflow.ProcessRatingWorkflow(CustomerRating);

        exit(true);
    end;

    procedure GetCustomerRatingsAsJson(CustomerNo: Code[20]): Text
    var
        CustomerRating: Record "ABC Customer Rating";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        RatingJson: JsonObject;
    begin
        CustomerRating.SetRange("Customer No.", CustomerNo);
        if CustomerRating.FindSet() then
            repeat
                Clear(RatingJson);
                RatingJson.Add('customerNo', CustomerRating."Customer No.");
                RatingJson.Add('ratingDate', CustomerRating."Rating Date");
                RatingJson.Add('ratingScore', CustomerRating."Rating Score");
                RatingJson.Add('ratingCategory', Format(CustomerRating."Rating Category"));
                RatingJson.Add('comments', CustomerRating.Comments);
                JsonArray.Add(RatingJson);
            until CustomerRating.Next() = 0;

        JsonObject.Add('customerRatings', JsonArray);
        exit(Format(JsonObject));
    end;

    procedure GetRatingStatisticsAsJson(CustomerNo: Code[20]): Text
    var
        CustomerRatingMgt: Codeunit "ABC Customer Rating Mgt";
        Statistics: Record "ABC Rating Statistics" temporary;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        StatJson: JsonObject;
        AverageRating: Decimal;
    begin
        CustomerRatingMgt.GetRatingStatistics(CustomerNo, Statistics);
        AverageRating := CustomerRatingMgt.CalculateAverageRating(CustomerNo);

        JsonObject.Add('customerNo', CustomerNo);
        JsonObject.Add('overallAverageRating', AverageRating);

        if Statistics.FindSet() then
            repeat
                Clear(StatJson);
                StatJson.Add('ratingCategory', Format(Statistics."Rating Category"));
                StatJson.Add('totalRatings', Statistics."Total Ratings");
                StatJson.Add('averageScore', Statistics."Average Score");
                JsonArray.Add(StatJson);
            until Statistics.Next() = 0;

        JsonObject.Add('categoryStatistics', JsonArray);
        exit(Format(JsonObject));
    end;
}

## Reports and Report Extensions

### Guidelines
- Use appropriate data items and columns
- Implement proper filtering options
- Use request pages for user input
- Follow standard Business Central report layouts
- Implement proper error handling
- Use processing-only reports for data manipulation without output
- Optimize report performance for large datasets

### Complete Report Example

```al
report 50100 "ABC Customer Rating Report"
{
    Caption = 'Customer Rating Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;
    UseRequestPage = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", Name, "Customer Posting Group";
            column(Customer_No; "No.")
            {
                IncludeCaption = true;
            }
            column(Customer_Name; Name)
            {
                IncludeCaption = true;
            }
            column(Customer_Phone; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(Customer_Email; "E-Mail")
            {
                IncludeCaption = true;
            }
            column(Customer_Category; "ABC Customer Category")
            {
                IncludeCaption = true;
            }
            column(Customer_LastContactDate; "ABC Last Contact Date")
            {
                IncludeCaption = true;
            }
            column(Customer_TotalRatings; TotalRatings)
            {
            }
            column(Customer_AverageRating; AverageRating)
            {
            }

            dataitem("ABC Customer Rating"; "ABC Customer Rating")
            {
                DataItemLink = "Customer No." = field("No.");
                column(Rating_Date; "Rating Date")
                {
                    IncludeCaption = true;
                }
                column(Rating_Score; "Rating Score")
                {
                    IncludeCaption = true;
                }
                column(Rating_Category; "Rating Category")
                {
                    IncludeCaption = true;
                }
                column(Rating_Comments; Comments)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    RatingCount += 1;
                    TotalScore += "Rating Score";
                end;
            }

            trigger OnAfterGetRecord()
            var
                CustomerRatingMgt: Codeunit "ABC Customer Rating Mgt";
            begin
                CalcFields("ABC Total Ratings");
                TotalRatings := "ABC Total Ratings";
                AverageRating := CustomerRatingMgt.CalculateAverageRating("No.");

                // Initialize counters for this customer
                RatingCount := 0;
                TotalScore := 0;
            end;

            trigger OnPreDataItem()
            begin
                if CompanyName <> '' then
                    CompanyInformation.Get();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(MinimumRatingScore; MinimumRatingScore)
                    {
                        Caption = 'Minimum Rating Score';
                        ApplicationArea = All;
                        MinValue = 1;
                        MaxValue = 5;
                        Tooltip = 'Specifies the minimum rating score to include in the report.';
                    }
                    field(IncludeRatingDetails; IncludeRatingDetails)
                    {
                        Caption = 'Include Rating Details';
                        ApplicationArea = All;
                        Tooltip = 'Specifies whether to include individual rating details for each customer.';
                    }
                    group(DateFilter)
                    {
                        Caption = 'Date Filter';
                        field(DateFilterFrom; DateFilterFrom)
                        {
                            Caption = 'From Date';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the start date for the rating date filter.';
                        }
                        field(DateFilterTo; DateFilterTo)
                        {
                            Caption = 'To Date';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the end date for the rating date filter.';
                        }
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if DateFilterFrom = 0D then
                DateFilterFrom := CalcDate('<-1Y>', Today);
            if DateFilterTo = 0D then
                DateFilterTo := Today;
        end;
    }

    rendering
    {
        layout("ABC Customer Rating Report")
        {
            Type = RDLC;
            LayoutFile = './Layouts/ABCCustomerRatingReport.rdlc';
        }
    }

    labels
    {
        ReportTitle = 'Customer Rating Report';
        CompanyName = 'Company Name';
        PrintDate = 'Print Date';
        CustomerNo = 'Customer No.';
        CustomerName = 'Customer Name';
        TotalRatingsLabel = 'Total Ratings';
        AverageRatingLabel = 'Average Rating';
    }

    trigger OnInitReport()
    begin
        MinimumRatingScore := 1;
        IncludeRatingDetails := true;
    end;

    trigger OnPreReport()
    begin
        CustomerFilter := Customer.GetFilters;
        if (DateFilterFrom <> 0D) or (DateFilterTo <> 0D) then begin
            Customer.SetFilter("ABC Customer Rating"."Rating Date", '%1..%2', DateFilterFrom, DateFilterTo);
        end;

        if MinimumRatingScore > 1 then
            Customer.SetFilter("ABC Customer Rating"."Rating Score", '>=%1', MinimumRatingScore);
    end;

    var
        CompanyInformation: Record "Company Information";
        MinimumRatingScore: Integer;
        IncludeRatingDetails: Boolean;
        DateFilterFrom: Date;
        DateFilterTo: Date;
        CustomerFilter: Text;
        TotalRatings: Integer;
        AverageRating: Decimal;
        RatingCount: Integer;
        TotalScore: Integer;
}
```

### Processing-Only Report Example

```al
report 50101 "ABC Update Customer Categories"
{
    Caption = 'Update Customer Categories';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Customer Posting Group";

            trigger OnAfterGetRecord()
            var
                CustomerRatingMgt: Codeunit "ABC Customer Rating Mgt";
                AverageRating: Decimal;
                NewCategory: Enum "ABC Customer Category";
            begin
                AverageRating := CustomerRatingMgt.CalculateAverageRating("No.");

                // Determine new category based on average rating
                case true of
                    AverageRating >= 4.5:
                        NewCategory := "ABC Customer Category"::Premium;
                    AverageRating >= 3.5:
                        NewCategory := "ABC Customer Category"::Standard;
                    AverageRating >= 2.0:
                        NewCategory := "ABC Customer Category"::Basic;
                    else
                        NewCategory := "ABC Customer Category"::Review;
                end;

                if "ABC Customer Category" <> NewCategory then begin
                    if not PreviewMode then begin
                        "ABC Customer Category" := NewCategory;
                        Modify(true);
                        CustomersUpdated += 1;
                    end else
                        CustomersToUpdate += 1;
                end;

                CustomersProcessed += 1;
                Window.Update(1, Round(CustomersProcessed / TotalCustomers * 10000, 1));
                Window.Update(2, "No.");
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                
                if PreviewMode then
                    Message('Preview completed. %1 customers would be updated.', CustomersToUpdate)
                else
                    Message('Process completed. %1 customers updated out of %2 processed.', CustomersUpdated, CustomersProcessed);
            end;

            trigger OnPreDataItem()
            begin
                TotalCustomers := Count;
                CustomersProcessed := 0;
                CustomersUpdated := 0;
                CustomersToUpdate := 0;

                Window.Open(
                    'Processing Customers...\' +
                    'Progress: #1########## %\' +
                    'Current Customer: #2##########');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PreviewMode; PreviewMode)
                    {
                        Caption = 'Preview Mode';
                        ApplicationArea = All;
                        Tooltip = 'Specifies whether to run in preview mode without making changes.';
                    }
                    group(CategoryRules)
                    {
                        Caption = 'Category Assignment Rules';
                        field(PremiumThreshold; PremiumThreshold)
                        {
                            Caption = 'Premium Threshold';
                            ApplicationArea = All;
                            DecimalPlaces = 1 : 2;
                            MinValue = 1;
                            MaxValue = 5;
                            Tooltip = 'Specifies the minimum average rating for Premium category.';
                        }
                        field(StandardThreshold; StandardThreshold)
                        {
                            Caption = 'Standard Threshold';
                            ApplicationArea = All;
                            DecimalPlaces = 1 : 2;
                            MinValue = 1;
                            MaxValue = 5;
                            Tooltip = 'Specifies the minimum average rating for Standard category.';
                        }
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            PreviewMode := true;
            PremiumThreshold := 4.5;
            StandardThreshold := 3.5;
        end;
    }

    var
        Window: Dialog;
        PreviewMode: Boolean;
        PremiumThreshold: Decimal;
        StandardThreshold: Decimal;
        TotalCustomers: Integer;
        CustomersProcessed: Integer;
        CustomersUpdated: Integer;
        CustomersToUpdate: Integer;
}

## XMLPorts

- Use proper element and attribute naming
- Implement proper validation for imported data
- Handle errors gracefully
- Document the expected XML structure
- Implement proper encoding and character handling
- Consider performance for large XML files

## Queries

- Use appropriate filters and sorting
- Optimize for performance
- Document the purpose and usage of the query
- Consider using queries for complex data retrieval operations
- Implement proper security filtering

## Search Keywords

### AL Object Types
**Tables**: Table creation, field design, data classification, tooltip requirements, table extensions
**Pages**: Page layout, actions, factboxes, card pages, list pages, page extensions
**Codeunits**: Business logic, procedures, functions, event handling, utility patterns

### Object Development Patterns
**Data Design**: Field types, validation, FlowFields, keys, relationships, data integrity
**User Interface**: Page structure, controls, actions, navigation, user experience design
**Business Logic**: Codeunit architecture, procedure design, parameter handling, error management

### Business Central Features
**Extension Model**: Table extensions, page extensions, object numbering, prefix requirements
**Integration**: Event publishing, event subscription, API development, external system connectivity
**Quality Standards**: Data classification, tooltip requirements, validation patterns, security considerations

## Cross-References

### Related SharedGuidelines
- **Naming Conventions**: `SharedGuidelines/Standards/naming-conventions.instructions.md` - Object and field naming patterns
- **Code Style**: `SharedGuidelines/Standards/code-style.instructions.md` - Formatting and tooltip standards
- **Error Handling**: `SharedGuidelines/Standards/error-handling.instructions.md` - Validation and error patterns

### Related CoreDevelopment Files
- **AL Development Guide**: `CoreDevelopment/al-development-guide.instructions.md` - General development principles
- **Coding Standards**: `CoreDevelopment/coding-standards.instructions.md` - Basic coding patterns and numbering

### Workflow Applications
- **TestingValidation**: Object-specific testing patterns and validation approaches
- **PerformanceOptimization**: Object design considerations for optimal performance
- **AppSourcePublishing**: Object pattern compliance for marketplace requirements

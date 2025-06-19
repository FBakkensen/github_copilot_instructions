// Table Template for Business Central AL Development
// Copy this template and replace placeholders with your specific values
// Following SharedGuidelines naming conventions and standards

table [ObjectID] "[Prefix] [EntityName]"
{
    Caption = '[EntityName]';
    DataClassification = CustomerContent;  // or ToBeClassified based on data sensitivity
    LookupPageId = "[Prefix] [EntityName] List";
    DrillDownPageId = "[Prefix] [EntityName] List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Tooltip = 'Specifies the number of the [entity].';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                // Add validation logic here
                TestField("No.");
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            Tooltip = 'Specifies the description of the [entity].';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Tooltip = 'Specifies when the [entity] was created.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Tooltip = 'Specifies who created the [entity].';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            Editable = false;
        }
        field(5; Status; Enum "[Prefix] [EntityName] Status")
        {
            Caption = 'Status';
            Tooltip = 'Specifies the status of the [entity].';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                case Status of
                    Status::Active:
                        ValidateActivation();
                    Status::Inactive:
                        ValidateInactivation();
                end;
            end;
        }
        // Add additional fields as needed following the same pattern
        
        // FlowField example for calculated data
        field(10; "Related Records Count"; Integer)
        {
            Caption = 'Related Records Count';
            Tooltip = 'Specifies the number of related records for this [entity].';
            FieldClass = FlowField;
            CalcFormula = count("[Related Table]" where("[Key Field]" = field("No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Description; Description)
        {
            // Secondary key for sorting and filtering
        }
        key(Status; Status, "Created Date")
        {
            // Composite key for status-based queries
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Status) { }
        fieldgroup(Brick; "No.", Description, Status, "Created Date") { }
    }

    trigger OnInsert()
    begin
        if "No." = '' then
            NoSeriesMgt.InitSeries('[NoSeriesCode]', xRec."No. Series", 0D, "No.", "No. Series");
        
        "Created Date" := Today;
        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        
        if Status = Status::" " then
            Status := Status::Active;
    end;

    trigger OnModify()
    begin
        TestField("No.");
        // Add modification validation logic
    end;

    trigger OnDelete()
    begin
        // Check for related records before deletion
        CheckRelatedRecords();
    end;

    trigger OnRename()
    begin
        Error('You cannot rename a %1.', TableCaption);
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure ValidateActivation()
    begin
        // Add validation logic for activation
        TestField(Description);
    end;

    local procedure ValidateInactivation()
    begin
        // Add validation logic for inactivation
        if HasRelatedRecords() then
            Error('Cannot inactivate %1 with related records.', "No.");
    end;

    local procedure HasRelatedRecords(): Boolean
    var
        RelatedTable: Record "[Related Table]";
    begin
        RelatedTable.SetRange("[Key Field]", "No.");
        exit(not RelatedTable.IsEmpty);
    end;

    local procedure CheckRelatedRecords()
    begin
        if HasRelatedRecords() then
            Error('Cannot delete %1 with related records.', "No.");
    end;

    procedure GetStatusStyleExpr(): Text
    begin
        case Status of
            Status::Active:
                exit('Favorable');
            Status::Inactive:
                exit('Unfavorable');
            else
                exit('Standard');
        end;
    end;
}

// Enum template for status field
enum [ObjectID] "[Prefix] [EntityName] Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; Inactive)
    {
        Caption = 'Inactive';
    }
}
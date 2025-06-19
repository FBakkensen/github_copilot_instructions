// Page Template for Business Central AL Development
// Copy this template and replace placeholders with your specific values
// Following SharedGuidelines naming conventions and page layout standards

page [ObjectID] "[Prefix] [EntityName] Card"
{
    Caption = '[EntityName] Card';
    PageType = Card;
    SourceTable = "[Prefix] [EntityName]";
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
                    ShowMandatory = true;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    StyleExpr = StatusStyleExpr;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // Add additional detail fields as needed
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                field("Related Records Count"; Rec."Related Records Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDownPageId = "[Related Records Page]";
                }
            }
        }
        area(FactBoxes)
        {
            part(RelatedRecordsFactBox; "[Prefix] Related Records FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "[Key Field]" = field("No.");
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
            action(Activate)
            {
                Caption = 'Activate';
                Image = Approve;
                ApplicationArea = All;
                Enabled = Rec.Status <> Rec.Status::Active;

                trigger OnAction()
                begin
                    Rec.Validate(Status, Rec.Status::Active);
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(Inactivate)
            {
                Caption = 'Inactivate';
                Image = Cancel;
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::Active;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to inactivate this %1?', false, Rec.TableCaption) then begin
                        Rec.Validate(Status, Rec.Status::Inactive);
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action(Copy)
            {
                Caption = 'Copy';
                Image = Copy;
                ApplicationArea = All;

                trigger OnAction()
                var
                    NewRecord: Record "[Prefix] [EntityName]";
                    [EntityName]Card: Page "[Prefix] [EntityName] Card";
                begin
                    NewRecord.TransferFields(Rec, false);
                    NewRecord."No." := '';
                    NewRecord.Insert(true);
                    [EntityName]Card.SetRecord(NewRecord);
                    [EntityName]Card.RunModal();
                end;
            }
        }
        area(Navigation)
        {
            action(RelatedRecords)
            {
                Caption = 'Related Records';
                Image = List;
                ApplicationArea = All;
                RunObject = page "[Related Records Page]";
                RunPageLink = "[Key Field]" = field("No.");
            }
            action(History)
            {
                Caption = 'History';
                Image = History;
                ApplicationArea = All;
                // Link to change log or audit trail if available
            }
        }
        area(Reporting)
        {
            action(PrintRecord)
            {
                Caption = 'Print';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"[Prefix] [EntityName] Document", true, true, Rec);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(Activate_Promoted; Activate) { }
                actionref(Inactivate_Promoted; Inactivate) { }
                actionref(Copy_Promoted; Copy) { }
            }
            group(Category_Navigate)
            {
                Caption = 'Navigate';
                actionref(RelatedRecords_Promoted; RelatedRecords) { }
                actionref(History_Promoted; History) { }
            }
            group(Category_Report)
            {
                Caption = 'Report';
                actionref(PrintRecord_Promoted; PrintRecord) { }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Related Records Count");
        SetStatusStyle();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Initialize new record with default values
        SetStatusStyle();
    end;

    var
        StatusStyleExpr: Text;

    local procedure SetStatusStyle()
    begin
        StatusStyleExpr := Rec.GetStatusStyleExpr();
    end;
}

// List Page Template
page [ObjectID] "[Prefix] [EntityName] List"
{
    Caption = '[EntityName] List';
    PageType = List;
    SourceTable = "[Prefix] [EntityName]";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "[Prefix] [EntityName] Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyleExpr;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Related Records Count"; Rec."Related Records Count")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "[Related Records Page]";
                }
            }
        }
        area(FactBoxes)
        {
            part(RelatedRecordsFactBox; "[Prefix] Related Records FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "[Key Field]" = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(New)
            {
                Caption = 'New';
                Image = New;
                ApplicationArea = All;
                RunObject = page "[Prefix] [EntityName] Card";
                RunPageMode = Create;
            }
            action(BulkActivate)
            {
                Caption = 'Bulk Activate';
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SelectedRecord: Record "[Prefix] [EntityName]";
                begin
                    CurrPage.SetSelectionFilter(SelectedRecord);
                    if SelectedRecord.FindSet() then begin
                        if Confirm('Activate %1 selected records?', false, SelectedRecord.Count) then
                            repeat
                                SelectedRecord.Status := SelectedRecord.Status::Active;
                                SelectedRecord.Modify(true);
                            until SelectedRecord.Next() = 0;
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
        area(Reporting)
        {
            action(PrintList)
            {
                Caption = 'Print List';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SelectedRecord: Record "[Prefix] [EntityName]";
                begin
                    CurrPage.SetSelectionFilter(SelectedRecord);
                    Report.RunModal(Report::"[Prefix] [EntityName] List", true, true, SelectedRecord);
                end;
            }
            action(ExportToExcel)
            {
                Caption = 'Export to Excel';
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SelectedRecord: Record "[Prefix] [EntityName]";
                begin
                    CurrPage.SetSelectionFilter(SelectedRecord);
                    Report.RunModal(Report::"[Prefix] [EntityName] Export", true, false, SelectedRecord);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_New)
            {
                Caption = 'New';
                actionref(New_Promoted; New) { }
            }
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(BulkActivate_Promoted; BulkActivate) { }
            }
            group(Category_Report)
            {
                Caption = 'Report';
                actionref(PrintList_Promoted; PrintList) { }
                actionref(ExportToExcel_Promoted; ExportToExcel) { }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Related Records Count");
        SetStatusStyle();
    end;

    var
        StatusStyleExpr: Text;

    local procedure SetStatusStyle()
    begin
        StatusStyleExpr := Rec.GetStatusStyleExpr();
    end;
}
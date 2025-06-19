// Codeunit Template for Business Central AL Development
// Copy this template and replace placeholders with your specific values
// Following SharedGuidelines standards for business logic and event patterns

codeunit [ObjectID] "[Prefix] [EntityName] Mgt"
{
    // Management codeunit for [EntityName] operations
    // Use this template for small to medium functionality

    procedure Create[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; [KeyParameters]: Text): Boolean
    var
        Handled: Boolean;
    begin
        OnBeforeCreate[EntityName]([EntityName], [KeyParameters], Handled);
        DoCreate[EntityName]([EntityName], [KeyParameters], Handled);
        OnAfterCreate[EntityName]([EntityName]);
        exit(Handled);
    end;

    local procedure DoCreate[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; [KeyParameters]: Text; var Handled: Boolean)
    begin
        if Handled then
            exit;

        [EntityName].Init();
        [EntityName]."No." := GetNextNumber();
        [EntityName].Description := [KeyParameters];
        [EntityName].Insert(true);

        Handled := true;
    end;

    procedure Validate[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"): Boolean
    var
        ErrorMessages: Text;
    begin
        // Comprehensive validation
        if [EntityName]."No." = '' then
            ErrorMessages += 'No. is required.\';

        if [EntityName].Description = '' then
            ErrorMessages += 'Description is required.\';

        // Add specific business validations
        if not IsValid[EntityName]([EntityName]) then
            ErrorMessages += 'Business validation failed.\';

        if ErrorMessages <> '' then begin
            Error(ErrorMessages);
            exit(false);
        end;

        exit(true);
    end;

    procedure Update[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; UpdateData: Record "[Prefix] [EntityName]"): Boolean
    var
        Handled: Boolean;
    begin
        OnBeforeUpdate[EntityName]([EntityName], UpdateData, Handled);
        DoUpdate[EntityName]([EntityName], UpdateData, Handled);
        OnAfterUpdate[EntityName]([EntityName]);
        exit(Handled);
    end;

    local procedure DoUpdate[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; UpdateData: Record "[Prefix] [EntityName]"; var Handled: Boolean)
    begin
        if Handled then
            exit;

        if Validate[EntityName](UpdateData) then begin
            [EntityName].Description := UpdateData.Description;
            [EntityName].Status := UpdateData.Status;
            [EntityName].Modify(true);
            Handled := true;
        end;
    end;

    procedure Delete[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"): Boolean
    var
        Handled: Boolean;
    begin
        OnBeforeDelete[EntityName]([EntityName], Handled);
        DoDelete[EntityName]([EntityName], Handled);
        OnAfterDelete[EntityName]([EntityName]);
        exit(Handled);
    end;

    local procedure DoDelete[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; var Handled: Boolean)
    begin
        if Handled then
            exit;

        if CanDelete[EntityName]([EntityName]) then begin
            [EntityName].Delete(true);
            Handled := true;
        end else
            Error('Cannot delete %1 due to related records.', [EntityName]."No.");
    end;

    procedure Get[EntityName]Statistics([EntityName]No: Code[20]; var Statistics: Record "[Prefix] [EntityName] Statistics" temporary)
    begin
        // Calculate and populate statistics
        Statistics.Init();
        Statistics."Entity No." := [EntityName]No;
        Statistics."Total Records" := Count[EntityName]Records([EntityName]No);
        Statistics."Last Modified Date" := GetLast[EntityName]ModificationDate([EntityName]No);
        Statistics.Insert();
    end;

    procedure Process[EntityName]Batch(var [EntityName]: Record "[Prefix] [EntityName]")
    var
        ProcessedCount: Integer;
        ProgressDialog: Dialog;
    begin
        ProgressDialog.Open('Processing [EntityName] records...\Progress: #1######');
        
        if [EntityName].FindSet() then
            repeat
                Process[EntityName]Record([EntityName]);
                ProcessedCount += 1;
                ProgressDialog.Update(1, Round(ProcessedCount / [EntityName].Count * 10000, 1));
            until [EntityName].Next() = 0;
        
        ProgressDialog.Close();
        Message('Processed %1 records.', ProcessedCount);
    end;

    local procedure Process[EntityName]Record(var [EntityName]: Record "[Prefix] [EntityName]")
    begin
        // Individual record processing logic
        [EntityName].CalcFields("[FlowField]");
        // Add specific processing logic here
        [EntityName].Modify();
    end;

    local procedure GetNextNumber(): Code[20]
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        [EntityName]Setup: Record "[Prefix] [EntityName] Setup";
    begin
        [EntityName]Setup.Get();
        [EntityName]Setup.TestField("No. Series");
        exit(NoSeriesMgt.GetNextNo([EntityName]Setup."No. Series", 0D, true));
    end;

    local procedure IsValid[EntityName]([EntityName]: Record "[Prefix] [EntityName]"): Boolean
    begin
        // Add business-specific validation logic
        if [EntityName].Status = [EntityName].Status::" " then
            exit(false);
        
        // Add more validation rules as needed
        exit(true);
    end;

    local procedure CanDelete[EntityName]([EntityName]: Record "[Prefix] [EntityName]"): Boolean
    var
        RelatedRecord: Record "[Related Table]";
    begin
        RelatedRecord.SetRange("[Key Field]", [EntityName]."No.");
        exit(RelatedRecord.IsEmpty);
    end;

    local procedure Count[EntityName]Records([EntityName]No: Code[20]): Integer
    var
        RelatedRecord: Record "[Related Table]";
    begin
        RelatedRecord.SetRange("[Key Field]", [EntityName]No);
        exit(RelatedRecord.Count);
    end;

    local procedure GetLast[EntityName]ModificationDate([EntityName]No: Code[20]): DateTime
    var
        [EntityName]: Record "[Prefix] [EntityName]";
    begin
        if [EntityName].Get([EntityName]No) then
            exit([EntityName].SystemModifiedAt);
        exit(0DT);
    end;

    // Event publishers for extensibility
    [BusinessEvent(false)]
    local procedure OnBeforeCreate[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; [KeyParameters]: Text; var Handled: Boolean)
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnAfterCreate[EntityName](var [EntityName]: Record "[Prefix] [EntityName]")
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnBeforeUpdate[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; UpdateData: Record "[Prefix] [EntityName]"; var Handled: Boolean)
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnAfterUpdate[EntityName](var [EntityName]: Record "[Prefix] [EntityName]")
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnBeforeDelete[EntityName](var [EntityName]: Record "[Prefix] [EntityName]"; var Handled: Boolean)
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnAfterDelete[EntityName](var [EntityName]: Record "[Prefix] [EntityName]")
    begin
    end;

    // Event subscribers for standard table events
    [EventSubscriber(ObjectType::Table, Database::"[Prefix] [EntityName]", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsert[EntityName](var Rec: Record "[Prefix] [EntityName]")
    begin
        // Handle post-insert operations
        if IsGuiAllowed() then
            Message('[EntityName] %1 has been created successfully.', Rec."No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"[Prefix] [EntityName]", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModify[EntityName](var Rec: Record "[Prefix] [EntityName]")
    begin
        // Handle post-modify operations
        UpdateRelatedRecords(Rec);
    end;

    local procedure UpdateRelatedRecords([EntityName]: Record "[Prefix] [EntityName]")
    var
        RelatedRecord: Record "[Related Table]";
    begin
        RelatedRecord.SetRange("[Key Field]", [EntityName]."No.");
        if RelatedRecord.FindSet() then
            repeat
                // Update related records as needed
                RelatedRecord."[Update Field]" := [EntityName]."[Source Field]";
                RelatedRecord.Modify();
            until RelatedRecord.Next() = 0;
    end;
}

// Major Functionality Codeunit Template
codeunit [ObjectID] "[Prefix] [EntityName] Workflow"
{
    // Major functionality codeunit with comprehensive workflow patterns
    // Use this template for complex business processes

    procedure Execute[EntityName]Workflow(var [EntityName]: Record "[Prefix] [EntityName]")
    var
        Handled: Boolean;
    begin
        OnBeforeExecute[EntityName]Workflow([EntityName], Handled);
        DoExecute[EntityName]Workflow([EntityName], Handled);
        OnAfterExecute[EntityName]Workflow([EntityName]);
    end;

    local procedure DoExecute[EntityName]Workflow(var [EntityName]: Record "[Prefix] [EntityName]"; var Handled: Boolean)
    var
        [EntityName]Mgt: Codeunit "[Prefix] [EntityName] Mgt";
        WorkflowStage: Integer;
    begin
        if Handled then
            exit;

        // Multi-stage workflow processing
        WorkflowStage := 1;
        ValidateWorkflowPreconditions([EntityName], WorkflowStage);

        WorkflowStage := 2;
        ProcessBusinessLogic([EntityName], WorkflowStage);

        WorkflowStage := 3;
        FinalizeWorkflow([EntityName], WorkflowStage);

        Handled := true;
    end;

    local procedure ValidateWorkflowPreconditions(var [EntityName]: Record "[Prefix] [EntityName]"; WorkflowStage: Integer)
    var
        [EntityName]Mgt: Codeunit "[Prefix] [EntityName] Mgt";
    begin
        UpdateWorkflowProgress([EntityName], WorkflowStage, 'Validating preconditions...');
        
        if not [EntityName]Mgt.Validate[EntityName]([EntityName]) then
            Error('Workflow validation failed at stage %1.', WorkflowStage);
    end;

    local procedure ProcessBusinessLogic(var [EntityName]: Record "[Prefix] [EntityName]"; WorkflowStage: Integer)
    begin
        UpdateWorkflowProgress([EntityName], WorkflowStage, 'Processing business logic...');
        
        // Add complex business logic here
        case [EntityName].Status of
            [EntityName].Status::Active:
                ProcessActiveEntity([EntityName]);
            [EntityName].Status::Inactive:
                ProcessInactiveEntity([EntityName]);
        end;
    end;

    local procedure FinalizeWorkflow(var [EntityName]: Record "[Prefix] [EntityName]"; WorkflowStage: Integer)
    begin
        UpdateWorkflowProgress([EntityName], WorkflowStage, 'Finalizing workflow...');
        
        [EntityName]."Last Processed Date" := Today;
        [EntityName].Modify(true);
        
        SendWorkflowNotification([EntityName]);
    end;

    local procedure ProcessActiveEntity(var [EntityName]: Record "[Prefix] [EntityName]")
    begin
        // Processing logic for active entities
    end;

    local procedure ProcessInactiveEntity(var [EntityName]: Record "[Prefix] [EntityName]")
    begin
        // Processing logic for inactive entities
    end;

    local procedure UpdateWorkflowProgress([EntityName]: Record "[Prefix] [EntityName]"; Stage: Integer; Message: Text)
    begin
        if IsGuiAllowed() then
            Window.Update(1, StrSubstNo('Stage %1: %2', Stage, Message));
    end;

    local procedure SendWorkflowNotification([EntityName]: Record "[Prefix] [EntityName]")
    begin
        if IsGuiAllowed() then
            Message('Workflow completed successfully for %1.', [EntityName]."No.");
    end;

    var
        Window: Dialog;

    [BusinessEvent(false)]
    local procedure OnBeforeExecute[EntityName]Workflow(var [EntityName]: Record "[Prefix] [EntityName]"; var Handled: Boolean)
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnAfterExecute[EntityName]Workflow(var [EntityName]: Record "[Prefix] [EntityName]")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterWorkflowCompleted([EntityName]: Record "[Prefix] [EntityName]")
    begin
    end;
}
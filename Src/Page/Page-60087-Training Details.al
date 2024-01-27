page 60087 "Training Details"
{
    PageType = Document;
    SourceTable = 60057;
    SourceTableView = WHERE(Status = FILTER(Declared | Started));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Course Name"; rec."Course Name")
                {
                    ApplicationArea = all;
                }
                field("Need  for Training"; rec."Need  for Training")
                {
                    ApplicationArea = all;
                }
                field("Initiating Dept"; rec."Initiating Dept")
                {
                    ApplicationArea = all;
                }
                field("Date of Creation"; rec."Date of Creation")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;
                    Editable = "Starting DateEditable";
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                }
            }
            part(part1; 60061)
            {
                SubPageLink = "Training Header No." = FIELD("No.");
            }
            group(Details)
            {
                Caption = 'Details';
                field(Agency; rec.Agency)
                {
                    ApplicationArea = all;
                }
                field("Agency Name"; rec."Agency Name")
                {
                    ApplicationArea = all;
                }
                field("Training Subject"; rec."Training Subject")
                {
                    ApplicationArea = all;
                }
                field("Training Facility"; rec."Training Facility")
                {
                    ApplicationArea = all;
                }
                field("Training Premises"; rec."Training Premises")
                {
                    ApplicationArea = all;
                }
                field("Training Type"; rec."Training Type")
                {
                    ApplicationArea = all;
                }
                field("No. of Employees"; rec."No. of Employees")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Actual Start Date"; rec."Actual Start Date")
                {
                    ApplicationArea = all;
                }
                field("Actual Closed Date"; rec."Actual Closed Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Training)
            {
                Caption = 'Training';
                action(Start)
                {
                    Caption = 'Start';

                    trigger OnAction()
                    begin
                        IF rec."Starting Date" > TODAY THEN
                            ERROR('Training should not start before %1', rec."Starting Date");
                        IF rec.Status = rec.Status::Declared THEN BEGIN
                            rec.Status := rec.Status::Started;
                            rec."Actual Start Date" := TODAY;
                            rec.MODIFY;

                        END
                        ELSE
                            IF rec.Status = rec.Status::Started THEN
                                ERROR('This Training already been started');
                    end;
                }
                action(Close)
                {
                    Caption = 'Close';

                    trigger OnAction()
                    begin
                        IF rec."Ending Date" > TODAY THEN
                            ERROR('Training should not be closed before %1', rec."Ending Date");

                        IF rec.Status = rec.Status::Started THEN BEGIN
                            rec.Status := rec.Status::Closed;
                            rec."Actual Closed Date" := TODAY;
                            rec.MODIFY;
                        END
                        ELSE
                            IF rec.Status = rec.Status::Declared THEN
                                ERROR('This document yet not been started');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF rec.Status = rec.Status::Started THEN
            "Starting DateEditable" := FALSE
        ELSE
            "Starting DateEditable" := TRUE;
    end;

    trigger OnInit()
    begin
        "Starting DateEditable" := TRUE;
    end;

    var
        [InDataSet]
        "Starting DateEditable": Boolean;
}


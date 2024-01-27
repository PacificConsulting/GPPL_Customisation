page 60095 "Interview Details History"
{
    PageType = Document;
    SourceTable = 60059;
    SourceTableView = WHERE(Status = CONST(Finished));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field("Interview Call Date"; rec."Interview Call Date")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Finished Date"; rec."Finished Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            part(part1; 60091)
            {
                SubPageLink = "Document No." = FIELD("Document No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Inter&view")
            {
                Caption = 'Inter&view';
                action("&End Interview")
                {
                    Caption = '&End Interview';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF rec.Status = rec.Status::Running THEN BEGIN
                            rec.Status := rec.Status::Finished;
                            rec."Finished Date" := TODAY;
                            rec.MODIFY;
                            CurrPage.EDITABLE := FALSE;
                        END;
                        MESSAGE('Interview has been finished');
                    end;
                }
                action("&Reopen Interview")
                {
                    Caption = '&Reopen Interview';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF rec.Status = rec.Status::Finished THEN BEGIN
                            rec.Status := rec.Status::Running;
                            rec.MODIFY;
                            CurrPage.EDITABLE := TRUE;
                        END;
                        MESSAGE('Interview has been Reopened');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF rec.Status = rec.Status::Running THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;
}


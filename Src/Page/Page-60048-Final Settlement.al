page 60048 "Final Settlement"
{
    PageType = Document;
    SourceTable = 60050;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF rec."Employee No." = '' THEN
                            rec."Employee Name" := '';
                    end;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Attended Days"; rec."Attended Days")
                {
                    ApplicationArea = all;
                }
                field(Month; rec.Month)
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
                field("Date of Leaving"; rec."Date of Leaving")
                {
                    ApplicationArea = all;
                }
            }
            part(SettleLine; 60049)
            {
                SubPageLink = "Employee No." = FIELD("Employee No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Batch Name"; rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //JournalTemplate.SETRANGE("Form ID",80091);
                        JournalTemplate.RESET;
                        JournalTemplate.SETRANGE(Name, 'PAYROLL');
                        IF JournalTemplate.FIND('-') THEN
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        IF PAGE.RUNMODAL(251, JournalBatch) = ACTION::LookupOK THEN BEGIN
                            rec."Journal Batch Name" := JournalBatch.Name;
                            rec."Journal Template Name" := JournalBatch."Journal Template Name";
                            rec."Posting Date" := WORKDATE;
                        END;

                        JournalBatch.SETRANGE(Name, rec."Journal Batch Name");
                        IF JournalBatch.FIND('-') THEN
                            NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                        IF NoSeries.FIND('-') THEN
                            rec."Document No." := NoSeriesMgt.GetNextNo(NoSeries.Code, WORKDATE, TRUE);

                        FinalSettleLine.SETRANGE("Employee No.", rec."Employee No.");
                        FinalSettleLine.SETRANGE(Month, rec.Month);
                        FinalSettleLine.SETRANGE(Year, rec.Year);
                        IF FinalSettleLine.FIND('-') THEN
                            REPEAT
                                FinalSettleLine."Journal Template Name" := rec."Journal Template Name";
                                FinalSettleLine."Journal Batch Name" := rec."Journal Batch Name";
                                FinalSettleLine."Posting Date" := rec."Posting Date";
                                FinalSettleLine."Document No." := rec."Document No.";
                                FinalSettleLine.MODIFY;
                            UNTIL FinalSettleLine.NEXT = 0;
                    end;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
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
            group("&Line")
            {
                Caption = '&Line';
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    action("Dimensions-Multiple")
                    {
                        ApplicationArea = ALL;
                        Caption = 'Dimensions-Multiple';
                        //RunObject = Page 80115;
                    }
                }
            }
        }
        area(processing)
        {
            action("P&ost")
            {
                ApplicationArea = ALL;
                Caption = 'P&ost';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*FinalSettleLine.SETRANGE("Employee No.","Employee No.");
                    FinalSettleLine.SETRANGE(Month,Month);
                    FinalSettleLine.SETRANGE(Year,Year);
                    IF FinalSettleLine.FIND('-') THEN BEGIN
                      REPEAT
                        FinalPosting.ProcessPosting(FinalSettleLine);
                      UNTIL FinalSettleLine.NEXT = 0;
                      FinalPosting.DeleteDim(FinalSettleLine);
                    END;
                    */
                    //UD 19th DEC
                    IF CONFIRM(Text001) THEN BEGIN
                        //UD 13th Dec to stop multiple times posting
                        FinalSettleLine.SETRANGE("Employee No.", rec."Employee No.");
                        FinalSettleLine.SETRANGE(Posted, TRUE);
                        IF FinalSettleLine.FIND('-') THEN
                            ERROR(Text000);
                        //UD 13th Dec to stop multiple times posting
                        FinalPosting.ProcessPosting(Rec);
                    END;
                    //UD 19th DEC

                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Get Pay &Elements")
                {
                    Caption = 'Get Pay &Elements';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.GetPayElements;
                    end;
                }
                action("Calculate &Amount")
                {
                    Caption = 'Calculate &Amount';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.CalculateSalary;
                    end;
                }
            }
        }
    }

    var
        FinalSettleLine: Record 60051;
        "------Postings-------": Integer;
        NoSeries: Record 308;
        JournalTemplate: Record 80;
        JournalBatch: Record 232;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FinalPosting: Codeunit 60011;
        Text000: Label 'Records are already Posted';
        Text001: Label 'Do you want to Post ';
        RecRef: RecordRef;
}


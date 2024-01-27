page 60045 "Pay Revision Document"
{
    PageType = Document;
    SourceTable = 60048;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Id."; rec."Id.")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("New Grade"; rec."New Grade")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Effective Date"; rec."Effective Date")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
            }
            part(RevisionLine; 60046)
            {
                SubPageLink = "Header No." = FIELD("Id."),
                              Type = FIELD(Type),
                              "No." = FIELD("No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Batch Name"; rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        PayRevisionLine: Record 60049;
                    begin
                        //JournalTemplate.SETRANGE("Form ID",80081);
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

                        PayRevisionLine.SETRANGE("Header No.", rec."Id.");
                        PayRevisionLine.SETRANGE(Type, rec.Type);
                        PayRevisionLine.SETRANGE("No.", rec."No.");
                        IF PayRevisionLine.FIND('-') THEN
                            REPEAT
                                PayRevisionLine."Journal Template Name" := rec."Journal Template Name";
                                PayRevisionLine."Journal Batch Name" := rec."Journal Batch Name";
                                PayRevisionLine."Posting Date" := rec."Posting Date";
                                PayRevisionLine."Document No." := rec."Document No.";
                                PayRevisionLine.MODIFY;
                            UNTIL PayRevisionLine.NEXT = 0;
                    end;
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Update)
            {
                Caption = 'Update';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    /*
                    PayRevisionLine.SETRANGE("Header No.","Id.");
                    PayRevisionLine.SETRANGE(Type,Type);
                    PayRevisionLine.SETRANGE("No.","No.");
                    IF PayRevisionLine.FIND('-') THEN
                      REPEAT
                        PayElement.INIT;
                        IF Emp.GET("No.") THEN;
                        PayElement."Employee Code" := "No.";
                        PayElement."Effective Start Date" := PayRevisionLine."Effective Date";
                        PayElement."Pay Element Code" := PayRevisionLine."Pay Element";
                        PayElement."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                        PayElement."Computation Type" := PayRevisionLine."Revised Computation Type";
                        PayElement."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                        PayElement."Add/Deduct" := PayRevisionLine."Add/Deduct";
                        PayElement."Pay Cadre" := Emp."Pay Cadre";
                        PayElement.INSERT;
                        //PayRevisionLine.TESTFIELD("Document No.");
                        //PayRevisionLine.TESTFIELD("Posting Date");
                        //PayRevisionLine.TESTFIELD("Journal Batch Name");
                      UNTIL PayRevisionLine.NEXT = 0;
                    */

                    rec.PostPayRevision(Rec);

                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = false;
                action("Calculate &Arrears")
                {
                    Caption = 'Calculate &Arrears';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF rec.Status = rec.Status::Open THEN BEGIN
                            rec.PostPayRevision(Rec);
                            rec.CalculateArrearAmount(Rec);
                            rec.UpdateArrearAmount(Rec);
                            rec.UpdateESIArrearAmount(Rec);
                            rec.UpdatePFArrearAmount(Rec);
                            rec.Status := rec.Status::Released;
                            rec.MODIFY;
                        END;
                    end;
                }
                action("Grade &Transfer")
                {
                    Caption = 'Grade &Transfer';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.TESTFIELD(rec.Type, rec.Type::Employee);
                        rec.TESTFIELD(rec."No.");
                        GradeTransfer.INIT;
                        GradeTransfer."Document No." := rec."Id.";
                        GradeTransfer."Employee No." := rec."No.";
                        GradeTransfer."Employee Name" := rec."Employee Name";
                        GradeTransfer.Grade := rec.Grade;
                        GradeTransfer.SETRANGE("Document No.", rec."Id.");
                        GradeTransfer.SETRANGE("Employee No.", rec."No.");
                        GradeTransfer.SETRANGE(Grade, rec.Grade);
                        IF NOT GradeTransfer.FIND('-') THEN
                            GradeTransfer.INSERT;

                        GradeTransfer.SETRANGE("Document No.", rec."Id.");
                        GradeTransfer.SETRANGE("Employee No.", rec."No.");
                        GradeTransfer.SETRANGE(Grade, rec.Grade);
                        IF GradeTransfer.FIND('-') THEN
                            PAGE.RUN(60053, GradeTransfer);
                    end;
                }
            }
            action("P&ost")
            {
                ApplicationArea = all;
                Caption = 'P&ost';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*PayRevisionLine.SETRANGE("Header No.","Id.");
                    PayRevisionLine.SETRANGE(Type,Type);
                    PayRevisionLine.SETRANGE("No.","No.");
                    IF PayRevisionLine.FIND('-') THEN BEGIN
                      REPEAT
                        ArrearPosting.ProcessPosting(PayRevisionLine);
                      UNTIL PayRevisionLine.NEXT = 0;
                      ArrearPosting.DeleteDim(PayRevisionLine);
                    END;
                    MESSAGE('updated');
                    */
                    ArrearPosting.ProcessPosting(Rec);
                    MESSAGE('updated');
                    //ArrearPosting.DeleteDim(rec);

                end;
            }
        }
    }

    var
        GradeTransfer: Record 60054;
        PayRevisionLine: Record 60049;
        "------Postings-------": Integer;
        NoSeries: Record 308;
        JournalTemplate: Record 80;
        JournalBatch: Record 232;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ArrearPosting: Codeunit 60010;
        RecRef: RecordRef;
        PayElement: Record 60025;
        Emp: Record 60019;

    local procedure TypeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure NoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}


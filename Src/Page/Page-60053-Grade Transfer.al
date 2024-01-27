page 60053 "Grade Transfer"
{
    PageType = Card;
    SourceTable = 60054;
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
                    Editable = true;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Grade; rec.Grade)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("New Grade"; rec."New Grade")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = ALL;
                trigger OnAction()
                begin
                    rec.TESTFIELD("New Grade");

                    rec.InsertGradePayElements(Rec);

                    PayCadrePayElements.RESET;
                    IF PayCadrePayElements.FIND('-') THEN
                        REPEAT
                            PayCadrePayElements.Processed := FALSE;
                            PayCadrePayElements.MODIFY;
                        UNTIL PayCadrePayElements.NEXT = 0;

                    GradeTransfer.RESET;
                    IF GradeTransfer.FIND('-') THEN
                        GradeTransfer.DELETEALL;
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        PayCadrePayElements: Record 60026;
        GradeTransfer: Record 60054;
        RecRef: RecordRef;
}


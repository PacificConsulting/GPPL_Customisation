page 60015 "Pay Cadre Pay Elements"
{
    PageType = List;
    SourceTable = 60026;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Effective Start Date"; rec."Effective Start Date")
                {
                    ApplicationArea = all;
                }
                field("Pay Element Code"; rec."Pay Element Code")
                {
                    ApplicationArea = all;
                }
                field("Fixed/Percent"; rec."Fixed/Percent")
                {
                    ApplicationArea = all;
                }
                field("Amount / Percent"; rec."Amount / Percent")
                {
                    ApplicationArea = all;
                }
                field("Computation Type"; rec."Computation Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        PayCadrePayElements.SETRANGE("Pay Cadre Code", rec."Pay Cadre Code");
        IF PayCadrePayElements.FIND('-') THEN
            REPEAT
                IF PayCadrePayElements."Fixed/Percent" = rec."Fixed/Percent"::Percent THEN
                    PayCadrePayElements.TESTFIELD("Computation Type");
            UNTIL PayCadrePayElements.NEXT = 0
    end;

    var
        PayCadrePayElements: Record 60026;
        RecRef: RecordRef;
}


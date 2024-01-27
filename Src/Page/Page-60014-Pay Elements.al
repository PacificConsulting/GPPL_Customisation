page 60014 "Pay Elements"
{
    // Date: 15-Dec-05

    PageType = List;
    SourceTable = 60025;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Effective Start Date"; Rec."Effective Start Date")
                {
                    ApplicationArea = all;
                }
                field("Add/Deduct"; Rec."Add/Deduct")
                {
                    ApplicationArea = all;
                }
                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    ApplicationArea = all;
                }
                field("Fixed/Percent"; Rec."Fixed/Percent")
                {
                    ApplicationArea = all;
                }
                field("Amount / Percent"; Rec."Amount / Percent")
                {
                    ApplicationArea = all;
                }
                field("Computation Type"; Rec."Computation Type")
                {
                    ApplicationArea = all;
                }
                field("Pay Cadre"; Rec."Pay Cadre")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        PayElement.SETRANGE("Employee Code", Rec."Employee Code");
        IF PayElement.FIND('-') THEN
            REPEAT
                IF PayElement."Fixed/Percent" = Rec."Fixed/Percent"::Percent THEN
                    PayElement.TESTFIELD("Computation Type");
            UNTIL PayElement.NEXT = 0
    end;

    var
        PayElement: Record 60025;
        TempPayelement: Record 60025 temporary;
        RecRef: RecordRef;
}


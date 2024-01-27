page 60097 "Pay Elements for Dashboard"
{
    // Date: 15-Dec-05

    Editable = false;
    PageType = List;
    SourceTable = 60025;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                }
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
                field("Add/Deduct"; rec."Add/Deduct")
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
                field("Pay Cadre"; rec."Pay Cadre")
                {
                    Editable = false;
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
        PayElement.SETRANGE("Employee Code", rec."Employee Code");
        IF PayElement.FIND('-') THEN
            REPEAT
                IF PayElement."Fixed/Percent" = rec."Fixed/Percent"::Percent THEN
                    PayElement.TESTFIELD("Computation Type");
            UNTIL PayElement.NEXT = 0
    end;

    var
        PayElement: Record 60025;
        TempPayelement: Record 60025 temporary;
        RecRef: RecordRef;
}


page 60046 "Pay Revision Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 60049;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Pay Element"; rec."Pay Element")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Fixed / Percent"; rec."Fixed / Percent")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount / Percent"; rec."Amount / Percent")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Computation Type"; rec."Computation Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Effective Date"; rec."Effective Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Revised Fixed / Percent"; rec."Revised Fixed / Percent")
                {
                    ApplicationArea = all;
                }
                field("Revised Amount / Percent"; rec."Revised Amount / Percent")
                {
                    ApplicationArea = all;
                }
                field("Revised Computation Type"; rec."Revised Computation Type")
                {
                    ApplicationArea = all;
                }
                field("Arrear Amount"; rec."Arrear Amount")
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

    var
        RecRef: RecordRef;

    //  [Scope('Internal')]
    procedure ShowDimensions()
    begin
        ShowDimensions;
    end;
}


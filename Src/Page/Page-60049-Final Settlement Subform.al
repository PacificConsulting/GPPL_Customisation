page 60049 "Final Settlement Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 60051;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Pay Element Code"; rec."Pay Element Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field(Salary; rec.Salary)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        RecRef: RecordRef;

    // [Scope('Internal')]
    procedure _ShowDimensions()
    begin
        rec.ShowDimensions;
    end;

    // [Scope('Internal')]
    procedure ShowDimensions()
    begin
        rec.ShowDimensions;
    end;
}


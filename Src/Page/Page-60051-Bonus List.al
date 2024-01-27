page 60051 "Bonus List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60052;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Id; rec.Id)
                {
                    ApplicationArea = all;
                }
                field("Effective Date"; rec."Effective Date")
                {
                    ApplicationArea = all;
                }
                field("Bonus%"; rec."Bonus%")
                {
                    ApplicationArea = all;
                }
                field("Ex-gratia%"; rec."Ex-gratia%")
                {
                    ApplicationArea = all;
                }
                field("Min.Bonus sable Salary"; rec."Min.Bonus sable Salary")
                {
                    ApplicationArea = all;
                }
                field("Bonus Amount"; rec."Bonus Amount")
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
}


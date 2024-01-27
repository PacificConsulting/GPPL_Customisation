page 60039 "ESI List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60043;
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
                field("Employer %"; rec."Employer %")
                {
                    ApplicationArea = all;
                }
                field("Employee %"; rec."Employee %")
                {
                    ApplicationArea = all;
                }
                field("Rounding Amount"; rec."Rounding Amount")
                {
                    ApplicationArea = all;
                }
                field("Rounding Method"; rec."Rounding Method")
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


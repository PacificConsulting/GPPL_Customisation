page 60028 "Other Pay Elements"
{
    PageType = List;
    SourceTable = 60034;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Pay Element code"; rec."Pay Element code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Add/Deduct"; rec."Add/Deduct")
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
}


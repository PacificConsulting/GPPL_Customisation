page 50044 "Location Mapping"
{
    PageType = List;
    SourceTable = 50029;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Area1; rec.Area)
                {
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("User Type"; rec."User Type")
                {
                    ApplicationArea = all;
                }
                field(Customer; rec.Customer)
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}


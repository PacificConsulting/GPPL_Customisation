page 50131 "Dispatch Location Card"
{
    PageType = Card;
    SourceTable = 50042;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Address 1"; rec."Address 1")
                {
                    ApplicationArea = all;
                }
                field("Address 2"; rec."Address 2")
                {
                    ApplicationArea = all;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("State Code"; rec."State Code")
                {
                    ApplicationArea = all;
                }
                field(Country; rec.Country)
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


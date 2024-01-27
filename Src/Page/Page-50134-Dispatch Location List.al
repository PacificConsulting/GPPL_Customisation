page 50134 "Dispatch Location List"
{
    CardPageID = "Dispatch Location List";
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = 50042;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field("State Code"; rec."State Code")
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


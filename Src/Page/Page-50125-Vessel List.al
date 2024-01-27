page 50125 "Vessel List"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50052;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vessel Code"; rec."Vessel Code")
                {
                    ApplicationArea = all;
                }
                field("Vessel Name"; rec."Vessel Name")
                {
                    ApplicationArea = all;
                }
                field("IMO No."; rec."IMO No.")
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


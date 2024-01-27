page 50129 "Group Master List"
{
    // 
    // Date        Version      Remarks
    // .....................................................................................
    // 16May2018   RB-N         New for Group Master List

    Caption = 'Group Master List';
    PageType = List;
    SourceTable = 50047;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Group Code"; rec."Group Code")
                {
                    ApplicationArea = all;
                }
                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = all;
                }
                field("Insurance Limit"; rec."Insurance Limit")
                {
                    ApplicationArea = all;
                }
                field("Management Limit"; rec."Management Limit")
                {
                    ApplicationArea = all;
                }
                field("Temporary Limit"; rec."Temporary Limit")
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


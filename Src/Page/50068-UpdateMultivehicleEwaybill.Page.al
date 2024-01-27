page 50068 "Update Multivehicle E-way bill"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50043;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("EWB No."; rec."EWB No.")
                {
                    ApplicationArea = all;
                }
                field("Group No."; rec."Group No.")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Trans Doc No."; rec."Trans Doc No.")
                {
                    ApplicationArea = all;
                }
                field("Trans Doc Date"; rec."Trans Doc Date")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Veh Added Date"; rec."Veh Added Date")
                {
                    ApplicationArea = all;
                }
                field("New Vehicle No."; rec."New Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                }
                field("From Place"; rec."From Place")
                {
                    ApplicationArea = all;
                }
                field("Old Vehicle No."; rec."Old Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Old Tran No."; rec."Old Tran No.")
                {
                    ApplicationArea = all;
                }
                field("New Tran No."; rec."New Tran No.")
                {
                    ApplicationArea = all;
                }
                field("From State"; rec."From State")
                {
                    ApplicationArea = all;
                }
                field("Reason Rem"; rec."Reason Rem")
                {
                    ApplicationArea = all;
                }
                field("To State"; rec."To State")
                {
                    ApplicationArea = all;
                }
                field("To Place"; rec."To Place")
                {
                    ApplicationArea = all;
                }
                field("Tr Mode"; rec."Tr Mode")
                {
                    ApplicationArea = all;
                }
                field("Total Qty"; rec."Total Qty")
                {
                    ApplicationArea = all;
                }
                field("Unit Code"; rec."Unit Code")
                {
                    ApplicationArea = all;
                }
                field("EWB Creation date"; rec."EWB Creation date")
                {
                    ApplicationArea = all;
                }
                field("Created By User"; rec."Created By User")
                {
                    ApplicationArea = all;
                }
                field("VH Valid Upto"; rec."VH Valid Upto")
                {
                    ApplicationArea = all;
                }
                field("VH Updated Date"; rec."VH Updated Date")
                {
                    ApplicationArea = all;
                }
                field("Created Date"; rec."Created Date")
                {
                    ApplicationArea = all;
                }
                field("EWB Valid Upto"; rec."EWB Valid Upto")
                {
                    ApplicationArea = all;
                }
                field("EWB Updated Date"; rec."EWB Updated Date")
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


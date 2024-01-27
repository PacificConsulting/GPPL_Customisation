page 60019 "leave approval sub form"
{
    PageType = ListPart;
    SourceTable = 60032;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Apply; Rec.Apply)
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Leave Code"; Rec."Leave Duration")
                {
                    ApplicationArea = all;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field("No.of Days"; Rec."No.of Days")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reason for Leave"; Rec."Reason for Leave")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Sanctioned; Rec.Sanctioned)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date of Sanction"; Rec."Date of Sanction")
                {
                    ApplicationArea = all;
                }
                field("Date of Cancellation"; Rec."Date of Cancellation")
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
}


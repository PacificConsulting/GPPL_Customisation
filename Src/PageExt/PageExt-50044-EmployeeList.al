pageextension 50044 EmployeeListExtCstm extends "Employee List"
{
    layout
    {
        addafter("E-Mail")
        {
            field("Bank Account No."; Rec."Bank Account No.")
            {
                ApplicationArea = all;
            }
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = all;
            }
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
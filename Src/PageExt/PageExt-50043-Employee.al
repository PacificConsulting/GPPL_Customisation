pageextension 50043 EmployeecardExtCstm extends "Employee Card"
{
    layout
    {
        addafter("Bank Account No.")
        {
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
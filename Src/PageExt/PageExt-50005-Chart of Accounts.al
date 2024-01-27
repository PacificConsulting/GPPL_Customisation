pageextension 50005 ChartofAccountsExt extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Search Name"; Rec."Search Name")
            {
                ApplicationArea = all;
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = all;
            }
            field("Debit/Credit"; Rec."Debit/Credit")
            {
                ApplicationArea = all;
            }
            // field("Credit Amount"; Rec."Credit Amount")
            // {
            //     ApplicationArea = all;
            // }
            // field("Net Change"; Rec."Net Change")
            // {
            //     ApplicationArea = all;
            // }
            // field(Balance; Rec.Balance)
            // {
            //     ApplicationArea = all;
            // }
            // field("Balance at Date"; Rec."Balance at Date")
            // {
            //     ApplicationArea = all;
            // }
            field("Last Date Modified"; Rec."Last Date Modified")
            {
                ApplicationArea = all;
            }
            // field("Cost Type No."; Rec."Cost Type No.")
            // {
            //     ApplicationArea = all;
            // }
            // field("Debit Amount"; Rec."Debit Amount")
            // {
            //     ApplicationArea = all;
            // }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Trial Balance")
        {
            action("Trail Balance GST")
            {
                Caption = 'Trail Balance GST';
                //RunObject = Report 50182;
                Image = Report;
            }
        }
    }

    var
        myInt: Integer;
}
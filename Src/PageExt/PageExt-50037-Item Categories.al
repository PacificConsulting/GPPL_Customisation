pageextension 50037 "Item CategoriesExtCstm" extends "Item Categories"
{
    layout
    {
        addafter(Description)
        {
            field("Def. Excise Posting Group"; Rec."Def. Excise Posting Group")
            {
                ApplicationArea = all;
            }
            field("Administration Overhead"; Rec."Administration Overhead")
            {
                ApplicationArea = all;
            }
            field("Selling Distribution Overhead"; Rec."Selling Distribution Overhead")
            {
                ApplicationArea = all;
            }
            field(Depreciation; Rec.Depreciation)
            {
                ApplicationArea = all;
            }
            field("Finance Cost"; Rec."Finance Cost")
            {
                ApplicationArea = all;
            }
            field("Corporate Tax"; Rec."Corporate Tax")
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
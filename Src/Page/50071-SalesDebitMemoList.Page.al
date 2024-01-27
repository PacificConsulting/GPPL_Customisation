page 50071 "Sales Debit Memo List"
{
    Caption = 'Sales Orders';
    //CardPageID = "Sales Debit Memo";
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            "Debit Memo" = CONST(true));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Bill Of Export No."; rec."Bill Of Export No.")
                {
                    ApplicationArea = all;
                }
                field("Bill Of Export Date"; rec."Bill Of Export Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
            }
        }
    }
}


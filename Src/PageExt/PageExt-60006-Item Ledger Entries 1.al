pageextension 60006 item_Led_Ext extends "Item Ledger Entries"
{
    //Permissions = TableData 32 = rimd;
    layout
    {
        addafter("Document Line No.")
        {
            field("Expire Date"; Rec."Expire Date")
            {
                ApplicationArea = all;
            }
            // field("Source No."; Rec."Source No.")
            // {
            //     ApplicationArea = all;
            // }
            /* field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = all;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = all;

            } */
            field("Item Category Code"; Rec."Item Category Code")
            {

                ApplicationArea = all;
            }
        }
        addafter("Shipped Qty. Not Returned")
        {
            field("Density Factor"; rec."Density Factor")
            {
                ApplicationArea = all;
            }
        }
        addafter("Expiration Date")
        {
            // field("Dimension Set ID"; Rec."Dimension Set ID")
            // {
            //     ApplicationArea = all;
            // }
            // field("Unit of Measure Code"; Rec."Unit of Measure Code")
            // {
            //     ApplicationArea = all;
            // }
        }
        modify("Expiration Date")
        {
            Visible = true;
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ItmDesc := '';
        ItemRec.GET(Rec."Item No.");
        ItemUOM.GET(ItemRec."No.", ItemRec."Sales Unit of Measure");
        Rec."Quantity in Sales UOM" := Rec.Quantity / ItemUOM."Qty. per Unit of Measure";
        ItmDesc := ItemRec.Description;
    end;

    var
        myInt: Integer;
        ItemUOM: Record 5404;
        ItemRec: Record 27;
        ItmDesc: Text;
}


// MY PC 08 01 2024
pageextension 50072 "PurchaseOrderListExt" extends "Purchase Order List"
{
    layout
    {
        addafter("No.")
        {
            field("Blanket Order No."; rec."Blanket Order No.")
            {
                ApplicationArea = all;
            }

            field("Order Creation Date"; rec."Order Creation Date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        addafter(Print)
        {

            action("Purchase Order - &Regular")
            {
                ApplicationArea = ALL;
                Image = Change;
                trigger OnAction()
                var
                    PurchLine: Record "Purchase Line";
                    OrderAddress: Record 224;
                    vendor: Record 23;
                begin

                    //EBT STIVAN ---(1307012)-----------------------------------------------------START
                    IF rec."Order Address Code" <> '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    OrderAddress.GET(rec."Buy-from Vendor No.", rec."Order Address Code");
                                    IF (OrderAddress."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;

                    IF rec."Order Address Code" = '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" = 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    Vendor.GET(rec."Buy-from Vendor No.");
                                    IF (Vendor."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;
                    //EBT STIVAN ---(13072012)-------------------------------------------------------END

                    //  DocPrint.PrintPurchHeader(Rec); // MY PC 08 01 2024
                END;


            }
        }

    }




    var
        myInt: Integer;
}
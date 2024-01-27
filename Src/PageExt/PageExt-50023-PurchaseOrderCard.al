pageextension 50023 PurchaOrdeCardExtCstm extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here

        addafter("No. of Archived Versions")  // MY PC 08 01 2024
        {
            field("Full Name"; rec."Full Name")
            {
                ApplicationArea = all;
            }

            field("Gross Weight"; rec."Gross Weight")
            {
                ApplicationArea = all;
            }

            field("Vendor Quantity"; rec."Vendor Quantity")
            {
                ApplicationArea = all;
            }
            field("Blanket Order No."; rec."Blanket Order No.")
            {
                ApplicationArea = all;
            }
            field("Freight Charges"; rec."Freight Charges")
            {
                ApplicationArea = all;
            }
            field("Vendor TIN No."; rec."Vendor TIN No.")
            {
                ApplicationArea = all;
            }

            group(Other)
            {
                Enabled = false;

                field("Freight Type"; rec."Freight Type")
                {
                    ApplicationArea = all;
                }
                field("Exp. TPT Cost"; rec."Exp. TPT Cost")
                {
                    ApplicationArea = all;
                }

                field("Work Order"; rec."Work Order")
                {
                    ApplicationArea = all;
                }

            }


        }
        addafter("Pay-to Contact")
        {
            field(Remarks; rec.Remarks)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                RecVendor: Record Vendor;
                PH: Record "Purchase Header";
                PL: Record "Purchase Line";
                EBTPurchaseLine: Record "Purchase Line";
                Qty2Receive: Decimal;

            begin
                RecVendor.RESET;
                IF RecVendor.GET(Rec."Buy-from Vendor No.") THEN BEGIN
                    IF RecVendor."IRN Applicable" THEN
                        MESSAGE('IRN is applicable for vendor=%1', Rec."Buy-from Vendor Name");
                END;

                /// MY PC 08 01 2024

                IF rec."Document Type" = rec."Document Type"::Order THEN BEGIN
                    PH.RESET;
                    PH.SETRANGE(PH."No.", rec."No.");
                    PH.SETFILTER(PH."Density Factor", '%1', 0);
                    IF PH.FINDFIRST THEN BEGIN
                        IF PH."Density Factor" <> 0 THEN BEGIN
                            PL.RESET;
                            PL.SETRANGE(PL."Document No.", rec."No.");
                            PL.SETRANGE(PL.Type, PL.Type::Item);
                            PL.SETRANGE(PL."Unit Cost Update", FALSE);
                            IF PL.FINDSET THEN BEGIN
                                ERROR('Please Update the Unit Cost');
                            END;
                        END;
                    END;
                END;

                //EBT STIVAN ---(22/02/2013)--- Error message POP, if Density Factor is not Blank at Header Level and
                //                              Unit Cost Update Field is not updated at Line Level-------------------------END

                //EBT STIVAN---(22/02/2013)---Error Message Pop Up,If Vendor Qty*Density Factor 
                IF rec."Density Factor" <> 0 THEN BEGIN
                    Qty2Receive := ROUND((rec."Vendor Quantity" * rec."Density Factor"), 1.0, '=');
                    EBTPurchaseLine.RESET;
                    EBTPurchaseLine.SETRANGE(EBTPurchaseLine."Document Type", EBTPurchaseLine."Document Type"::Order);
                    EBTPurchaseLine.SETRANGE(EBTPurchaseLine."Document No.", rec."No.");
                    EBTPurchaseLine.SETRANGE(EBTPurchaseLine.Type, EBTPurchaseLine.Type::Item);
                    IF EBTPurchaseLine.FINDFIRST THEN BEGIN
                        IF Qty2Receive < EBTPurchaseLine."Qty. to Receive" THEN
                            ERROR('Qty to Receive should not be greater then %1..', Qty2Receive);
                    END;
                END;
                //EBT STIVAN---(22/02/2013)---Error Message Pop Up,If Vendor Qty*Density Factor 

                //Post(CODEUNIT::"Purch.-Post (Yes/No)"); // MY PC 08 01 2024
            END;

        }

        // MY PC 08 01 2024
        modify("&Print")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
                PurchLine: Record "Purchase Line";
                OrderAddress: Record 224;
                Vendor: Record 23;
            begin
                //EBT STIVAN ---(1307012)-----------------------------------------------------START
                // IF rec."Order Address Code" <> '' THEN BEGIN
                //     PurchLine.RESET;
                //     PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                //     IF PurchLine.FINDSET THEN
                //         IF (PurchLine."Tax Amount" <> 0) AND (rec."Form Code" <> 'C') THEN BEGIN
                //             IF rec."Vendor TIN No." = '' THEN BEGIN
                //                 OrderAddress.GET(rec."Buy-from Vendor No.", rec."Order Address Code");
                //                 IF (OrderAddress."L.S.T. No." = '') THEN
                //                     ERROR('TIN No. is Blank');
                //                 //MESSAGE('TIN No. is Blank');
                //             END;
                //         END;
                // END;

                // IF rec."Order Address Code" = '' THEN BEGIN
                //     PurchLine.RESET;
                //     PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                //     IF PurchLine.FINDSET THEN
                //         IF (PurchLine."Tax Amount" <> 0) AND (rec."Form Code" <> 'C') THEN BEGIN
                //             IF rec."Vendor TIN No." = '' THEN BEGIN
                //                 Vendor.GET(rec."Buy-from Vendor No.");
                //                 IF (Vendor."L.S.T. No." = '') THEN
                //                     ERROR('TIN No. is Blank');
                //                 //MESSAGE('TIN No. is Blank');
                //             END;
                //         END;
                // END;
                //EBT STIVAN ---(13072012)-------------------------------------------------------END
            end;
        }
        addafter("&Print")
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

        addafter(Reopen) /// MY PC 09 01 2024
        {
            action("Close PO")
            {
                ApplicationArea = ALL;
                Image = Change;
                trigger OnAction()
                var
                begin
                    //EBT/ORDERCLOSE/0001
                    IF CONFIRM('Do you want to close the Purchase Order?', TRUE) THEN BEGIN
                        rec.Closed := TRUE;
                        rec."Closing Date" := TODAY;
                        rec.MODIFY;
                    END
                    //EBT/ORDERCLOSE/0001
                end;
            }


            /// MY PC 09 01 2024
            action("Update Unit Cost")
            {
                ApplicationArea = ALL;
                Image = Change;
                trigger OnAction()
                var
                    PurchLine: Record "Purchase Line";
                    UnitPrice: Decimal;
                begin

                    PurchLine.RESET;
                    PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                    PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::Item);
                    IF PurchLine.FINDFIRST THEN BEGIN
                        IF PurchLine."Unit Cost Update" = FALSE THEN BEGIN
                            //IF PurchLine."Density Factor Applicable" THEN
                            //BEGIN
                            IF rec."Density Factor" = 0 THEN
                                ERROR('You need to put the Density factor in Warehouse Receipt %1', rec."No.");
                            IF rec."Vendor Quantity" = 0 THEN
                                ERROR('You need to put the Vendor Quantity in Warehouse Receipt %1', rec."No.");
                            IF rec."Gross Weight" = 0 THEN
                                ERROR('You need to put the Gross Weight in Warehouse Receipt %1', rec."No.");
                            IF rec."Tare Weight" = 0 THEN
                                ERROR('You need to put the Tare Weight in Warehouse Receipt %1', rec."No.");
                            UnitPrice := (PurchLine."Direct Unit Cost" * (rec."Vendor Quantity" / rec."Net Weight"));
                            PurchLine."Modify Through WH" := TRUE;
                            PurchLine.VALIDATE(PurchLine."Direct Unit Cost", UnitPrice);
                            PurchLine.VALIDATE(PurchLine."Qty. to Receive", rec."Net Weight");
                            PurchLine."Unit Cost Update" := TRUE;
                            PurchLine."Density Factor" := rec."Density Factor";  //EBT STIVAN (220213) - To Update Fields
                            PurchLine."Vendor Quantity" := rec."Vendor Quantity"; //EBT STIVAN (220213) - To Update Fields
                            PurchLine."Vendor Unit of Measure" := PurchLine."Unit of Measure Code"; //EBT STIVAN (220213) - To Update Fields
                            PurchLine.MODIFY;
                            //END;
                        END;
                    END;
                    //EBT/PO Dens Func/0001
                END;
            }
        }

    }


    var
        myInt: Integer;


}
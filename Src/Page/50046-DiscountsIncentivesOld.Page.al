page 50046 "Discounts & Incentives Old"
{
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50020;
    SourceTableView = WHERE("To Location Name" = CONST('false'));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(contro01)
            {
                field("Expected TPT Cost"; rec."Expected TPT Cost")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Invoice No."; rec."Invoice No.")
                {
                    applicationarea = all;
                    Editable = false;
                    Enabled = true;
                }
                field("Invoice Date"; rec."Invoice Date")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("LR No."; rec."LR No.")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("LR Date"; rec."LR Date")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Open; rec.Open)
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Applied; rec.Applied)
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("From Location Name"; rec."From Location Name")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Destination; rec.Destination)
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Vendor Code"; rec."Vendor Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    applicationarea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    applicationarea = all;
                }
                field("Shipping Agent Name"; rec."Shipping Agent Name")
                {
                    applicationarea = all;
                }
                field("TPT Invoice No."; rec."TPT Invoice No.")
                {
                    applicationarea = all;
                }
                field("TPT Invoice Date"; rec."TPT Invoice Date")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("TPT Type"; rec."TPT Type")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Bill Amount"; rec."Bill Amount")
                {
                    applicationarea = all;
                }
                field("To Location Name"; rec."To Location Name")
                {
                    applicationarea = all;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Freight Type"; rec."Freight Type")
                {
                    applicationarea = all;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unction")
            {
                Caption = 'F&unction';
                action("Su&bmit")
                {
                    Caption = 'Su&bmit';

                    trigger OnAction()
                    begin
                        /*
                        //CurrForm.SETSELECTIONFILTER(Discounts);
                        Discounts.RESET;
                        Discounts.SETRANGE(Discounts."Expected TPT Cost","Expected TPT Cost");
                        Discounts.SETRANGE("To Location Name",TRUE);
                        IF Discounts.FINDSET THEN
                        REPEAT
                          Discounts.Quantity := Discounts."Vendor Name" * Discounts."From Location Name";
                          Discounts.Rate := Discounts."Shipping Agent Code" * Discounts."From Location Name";
                          Discounts."Passed Amount" := Discounts."Shipping Agent Name" * Discounts."From Location Name";
                          Discounts."To Location Code" := Discounts."TPT Invoice No." * Discounts."From Location Name";
                          Discounts."TPT Invoice Date" := Discounts."Vendor Name" + Discounts."Shipping Agent Code"
                                                                 + Discounts."Shipping Agent Name" + Discounts."TPT Invoice No.";
                          Discounts."TPT Type" := Discounts."TPT Invoice Date" * Discounts."Vehicle No.";
                          Discounts.MODIFY;
                        UNTIL Discounts.NEXT = 0;
                        MESSAGE('Submitted Successfully');
                        */

                    end;
                }
                action("Create &Credit Memo")
                {
                    Caption = 'Create &Credit Memo';

                    trigger OnAction()
                    begin
                        /*
                        TotalAmount := 0;
                        TotalAVPDisc := 0;
                        TotalSpotDisc := 0;
                        TotalSplMgmDisc := 0;
                        TotalPriceDiff := 0;
                        Discounts.RESET;
                        Discounts.SETRANGE("Expected TPT Cost","Expected TPT Cost");
                        Discounts.SETRANGE("To Location Name",TRUE);
                        Discounts.SETRANGE("Bill Amount",TRUE);
                        IF Discounts.FINDSET THEN
                        REPEAT
                          TotalAVPDisc += Discounts.Quantity;
                          TotalSpotDisc += Discounts.Rate;
                          TotalSplMgmDisc += Discounts."Passed Amount";
                          TotalPriceDiff += Discounts."To Location Code";
                          TotalAmount += Discounts."TPT Type";
                        UNTIL Discounts.NEXT = 0;
                        SalesSetup.GET;
                        IF SalesSetup."AVP Discount Account" = '' THEN
                           ERROR('You must specify the AVP Discount Account No. in Sales & Receivable Setup');
                        IF SalesSetup."Spot Discount Account" = '' THEN
                           ERROR('You must specify the Spot Discount Account No. in Sales & Receivable Setup');
                        IF SalesSetup."Special Mgm Account" = '' THEN
                           ERROR('You must specify the Special Mgm Discount Account No. in Sales & Receivable Setup');
                        IF SalesSetup."Price Difference Account" = '' THEN
                           ERROR('You must specify the Price Diiference Discount Account No. in Sales & Receivable Setup');
                        
                        IF TotalAmount <> 0 THEN
                        BEGIN
                          SalesHeader.INIT;
                          SalesHeader."Document Type" := SalesHeader."Document Type" :: "Credit Memo";
                          SalesHeader."No." := '';
                          SalesHeader.INSERT(TRUE);
                          SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.",Discounts."Expected TPT Cost");
                          SalesHeader.VALIDATE(SalesHeader."Posting Date",TODAY);
                          SalesHeader."Dicounts/Incentive" := TRUE;
                          SalesHeader.MODIFY;
                          LineNo := 10000;
                          IF TotalAVPDisc <> 0 THEN
                          BEGIN
                          SalesLine.INIT;
                          SalesLine."Document Type" := SalesHeader."Document Type";
                          SalesLine."Document No." := SalesHeader."No.";
                          SalesLine."Line No." := LineNo;
                          LineNo += SalesLine."Line No.";
                          SalesLine.INSERT(TRUE);
                          SalesLine.VALIDATE(SalesLine."Sell-to Customer No.",Discounts."Expected TPT Cost");
                          SalesLine.VALIDATE(SalesLine.Type,SalesLine.Type::"G/L Account");
                          SalesLine.VALIDATE(SalesLine."No.",SalesSetup."AVP Discount Account");
                          SalesLine.VALIDATE(SalesLine.Quantity,1);
                          SalesLine.VALIDATE(SalesLine."Unit Price",TotalAVPDisc);
                          SalesLine.MODIFY;
                          END;
                          IF TotalSpotDisc <> 0 THEN
                          BEGIN
                          SalesLine.INIT;
                          SalesLine."Document Type" := SalesHeader."Document Type";
                          SalesLine."Document No." := SalesHeader."No.";
                          SalesLine."Line No." := LineNo;
                          LineNo += SalesLine."Line No.";
                          SalesLine.INSERT(TRUE);
                          SalesLine.VALIDATE(SalesLine."Sell-to Customer No.",Discounts."Expected TPT Cost");
                          SalesLine.VALIDATE(SalesLine.Type,SalesLine.Type::"G/L Account");
                          SalesLine.VALIDATE(SalesLine."No.",SalesSetup."Spot Discount Account");
                          SalesLine.VALIDATE(SalesLine.Quantity,1);
                          SalesLine.VALIDATE(SalesLine."Unit Price",TotalSpotDisc);
                          SalesLine.MODIFY;
                          END;
                          IF TotalSplMgmDisc <> 0 THEN
                          BEGIN
                          SalesLine.INIT;
                          SalesLine."Document Type" := SalesHeader."Document Type";
                          SalesLine."Document No." := SalesHeader."No.";
                          SalesLine."Line No." := LineNo;
                          LineNo += SalesLine."Line No.";
                          SalesLine.INSERT(TRUE);
                          SalesLine.VALIDATE(SalesLine."Sell-to Customer No.",Discounts."Expected TPT Cost");
                          SalesLine.VALIDATE(SalesLine.Type,SalesLine.Type::"G/L Account");
                          SalesLine.VALIDATE(SalesLine."No.",SalesSetup."Special Mgm Account");
                          SalesLine.VALIDATE(SalesLine.Quantity,1);
                          SalesLine.VALIDATE(SalesLine."Unit Price",TotalSplMgmDisc);
                          SalesLine.MODIFY;
                          END;
                          IF TotalPriceDiff <> 0 THEN
                          BEGIN
                          SalesLine.INIT;
                          SalesLine."Document Type" := SalesHeader."Document Type";
                          SalesLine."Document No." := SalesHeader."No.";
                          SalesLine."Line No." := LineNo;
                          LineNo += SalesLine."Line No.";
                          SalesLine.INSERT(TRUE);
                          SalesLine.VALIDATE(SalesLine."Sell-to Customer No.",Discounts."Expected TPT Cost");
                          SalesLine.VALIDATE(SalesLine.Type,SalesLine.Type::"G/L Account");
                          SalesLine.VALIDATE(SalesLine."No.",SalesSetup."Price Difference Account");
                          SalesLine.VALIDATE(SalesLine.Quantity,1);
                          SalesLine.VALIDATE(SalesLine."Unit Price",TotalPriceDiff);
                          SalesLine.MODIFY;
                          END;
                          Discounts."Freight Type" := SalesHeader."No.";
                          Discounts.MODIFY;
                          MESSAGE('Credit Memo No. %1 has been created successfully',SalesHeader."No.");
                        END
                        ELSE
                           ERROR('There is nothing to create');
                        */

                    end;
                }
            }
        }
    }

    var
        Discounts: Record 50020;
        TotalAmount: Decimal;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        SalesSetup: Record 311;
        TotalAVPDisc: Decimal;
        TotalSpotDisc: Decimal;
        TotalSplMgmDisc: Decimal;
        TotalPriceDiff: Decimal;
        LineNo: Integer;
}


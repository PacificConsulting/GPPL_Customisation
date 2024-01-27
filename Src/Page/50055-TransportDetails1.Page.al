page 50055 "Transport Details - 1"
{
    // //RSPL-CAS-07072-F8V7M3     Nikhil    Code added to fetch document date of Purchase Order
    // 
    // Date          Version        Remarks
    // -------------------------------------------------------------------------
    // 02Jan2019     RB-N           Transport Entries Validation

    PageType = List;
    SourceTable = 50020;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(group1)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field(Applied; rec.Applied)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        AppliedOnPush;
                    end;
                }
                field("Applied Document No."; rec."Applied Document No.")
                {
                    ApplicationArea = all;
                }
                field("Applied Date"; rec."Applied Date")
                {
                    ApplicationArea = all;
                }
                field("Invoice No."; rec."Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Invoice Date"; rec."Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("LR No."; rec."LR No.")
                {
                    ApplicationArea = all;
                }
                field("LR Date"; rec."LR Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = all;
                }
                field("From Location Name"; rec."From Location Name")
                {
                    ApplicationArea = all;
                }
                field(Destination; rec.Destination)
                {
                    ApplicationArea = all;
                }
                field("Vendor Code"; rec."Vendor Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Name"; rec."Shipping Agent Name")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice No."; rec."TPT Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice Date"; rec."TPT Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("TPT Type"; rec."TPT Type")
                {
                    ApplicationArea = all;
                }
                field("Expected TPT Cost"; rec."Expected TPT Cost")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Passed Amount"; rec."Passed Amount")
                {
                    ApplicationArea = all;
                }
                field("Bill Amount"; rec."Bill Amount")
                {
                    ApplicationArea = all;
                }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = all;
                }
                field("To Location Name"; rec."To Location Name")
                {
                    ApplicationArea = all;
                }
                field("Local LR Date"; rec."Local LR Date")
                {
                    ApplicationArea = all;
                }
                field("Local Vehicle No."; rec."Local Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Local Shipment Agent Code"; rec."Local Shipment Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Local Shipment Agent Name"; rec."Local Shipment Agent Name")
                {
                    ApplicationArea = all;
                }
                field("Local LR No."; rec."Local LR No.")
                {
                    ApplicationArea = all;
                }
                field("Freight Type"; rec."Freight Type")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Caption = 'Division';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.FILTERGROUP(2);
        recPH.RESET;
        recPH.SETRANGE(recPH."No.", PurchDocNo);
        IF recPH.FINDFIRST THEN BEGIN
            rec.SETRANGE("Vendor Code", recPH."Buy-from Vendor No.");
            rec.SETRANGE(Posted, FALSE);
            rec.SETRANGE("Cancelled Invoice", FALSE);

            //>>02Jan2019
            IF GLNoNew <> '' THEN BEGIN
                IF GLNoNew = '75001020' THEN BEGIN
                    rec.SETRANGE(Type, rec.Type::Transfer);
                END;
                IF GLNoNew = '75001022' THEN BEGIN
                    rec.SETFILTER(Type, '<>%1', rec.Type::Transfer);
                END;
                IF GLNoNew = '75001025' THEN BEGIN
                    rec.SETFILTER(Type, '<>%1', rec.Type::Transfer);
                    rec.SETFILTER("Invoice No.", 'EI*');
                END;
                IF GLNoNew = '75001023' THEN BEGIN
                    rec.SETFILTER(Type, '<>%1', rec.Type::Transfer);
                    rec.SETFILTER("Invoice No.", 'EI*');
                END;

            END;
            //<<02Jan2019
        END;
        rec.FILTERGROUP(0);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //IF CloseAction = ACTION::LookupOK THEN
        IF CloseAction = ACTION::OK THEN //10Aug2017
            LookupOKOnPush;
    end;

    var
        PurchDocNo: Code[20];
        recPurchLine: Record 39;
        recPH: Record 38;
        recTransportDetails: Record 50020;
        TotalAmount: Decimal;
        TotalPassedAmount: Decimal;
        TotalBillAmount: Decimal;
        recPurchHeader: Record 38;
        GLNoNew: Code[20];

    //  [Scope('Internal')]
    procedure GetDocNo(DocNo: Code[20]; GLNo: Code[20])
    begin
        PurchDocNo := DocNo;
        //>>02Jan2019
        IF GLNo <> '' THEN
            GLNoNew := GLNo;
        //<<02Jan2019
    end;

    local procedure AppliedOnPush()
    begin
        //RSPL-CAS-07072-F8V7M3
        IF rec.Applied = TRUE THEN BEGIN
            recPurchHeader.SETRANGE(recPurchHeader."No.", PurchDocNo);
            recPurchHeader.SETRANGE("Document Type", recPurchHeader."Document Type"::Invoice);
            IF recPurchHeader.FINDFIRST THEN BEGIN
                rec."Applied Document No." := PurchDocNo;
                rec."Applied Date" := recPurchHeader."Posting Date";
                rec.MODIFY;
            END;
        END;
        //RSPL-CAS-07072-F8V7M3
        IF rec.Applied = FALSE THEN BEGIN
            rec."Applied Document No." := '';
            rec."Applied Date" := 0D;
            rec.MODIFY;
        END;
    end;

    local procedure LookupOKOnPush()
    begin
        CurrPage.CLOSE;
        //TotalAmount := 0;
        TotalPassedAmount := 0;
        TotalBillAmount := 0;
        recTransportDetails.RESET;
        recTransportDetails.SETRANGE(recTransportDetails.Applied, TRUE);
        recTransportDetails.SETRANGE(recTransportDetails."Applied Document No.", PurchDocNo);
        IF recTransportDetails.FINDFIRST THEN
            REPEAT
                //TotalAmount := TotalAmount + recTransportDetails."Bill Amount";
                TotalPassedAmount := TotalPassedAmount + recTransportDetails."Total Amount";  //EBT Deepika aaded 220514
                TotalBillAmount := TotalBillAmount + recTransportDetails."Bill Amount";
            UNTIL recTransportDetails.NEXT = 0;
        //MESSAGE('Total Amount %1',TotalAmount);
        MESSAGE('(Total Passed Amount - %1.) and (Total Bill Amount - %2.)', TotalPassedAmount, TotalBillAmount);
    end;
}


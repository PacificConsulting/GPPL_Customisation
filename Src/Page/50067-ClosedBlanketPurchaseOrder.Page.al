page 50067 "Closed Blanket Purchase Order"
{
    // //RSPL060814--Sourav Dey--Did the customization for the validation required for Landed cost during visit on 06082014
    // //RSPL-Sourav020415       Customization was for auto archive the document during the time of release

    Caption = 'Closed Blanket Purchase Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"),
                            Closed = FILTER(true));
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = "Buy-from Vendor No.Editable";

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; rec."Buy-from Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Address"; rec."Buy-from Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Address 2"; rec."Buy-from Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Buy-from Post Code/City';
                    Editable = false;
                }
                field("Buy-from City"; rec."Buy-from City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Editable = "Buy-from ContactEditable";
                }
                // field(Structure; rec.Structure)
                // {
                //     ApplicationArea = all;
                //     Editable = StructureEditable;
                // }
                field(Closed; rec.Closed)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Closing Date"; rec."Closing Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Editable = "Order DateEditable";
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = "Document DateEditable";
                }
                field("Vendor Order No."; rec."Vendor Order No.")
                {
                    ApplicationArea = all;
                    Editable = "Vendor Order No.Editable";
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                    Editable = "Vendor Shipment No.Editable";
                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Editable = "Order Address CodeEditable";
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = all;
                    Editable = "Purchaser CodeEditable";

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = "Responsibility CenterEditable";
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                    Editable = "Assigned User IDEditable";
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
            }
            part(PurchLines; 510)
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = "Pay-to Vendor No.Editable";

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; rec."Pay-to Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Address"; rec."Pay-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Address 2"; rec."Pay-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Post Code"; rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Pay-to Post Code/City';
                    Editable = false;
                }
                field("Pay-to City"; rec."Pay-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Editable = "Pay-to ContactEditable";
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = ShortcutDimension1CodeEditable;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = ShortcutDimension2CodeEditable;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Editable = "Payment Terms CodeEditable";
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    Editable = "Due DateEditable";
                }
                field("Payment Discount %"; rec."Payment Discount %")
                {
                    ApplicationArea = all;
                    Editable = "Payment Discount %Editable";
                }
                field("Pmt. Discount Date"; rec."Pmt. Discount Date")
                {
                    ApplicationArea = all;
                    Editable = "Pmt. Discount DateEditable";
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = all;
                    Editable = "Payment Method CodeEditable";
                }
                field("On Hold"; rec."On Hold")
                {
                    ApplicationArea = all;
                    Editable = "On HoldEditable";
                }
                field("Prices Including VAT"; rec."Prices Including VAT")
                {
                    ApplicationArea = all;
                    Editable = "Prices Including VATEditable";

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Address"; rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Address 2"; rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                }
                field("Ship-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Transit Document"; rec."Transit Document")
                // {
                //     ApplicationArea = all;
                //     Editable = "Transit DocumentEditable";
                // }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = "Location CodeEditable";
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    Editable = "Shipping Agent CodeEditable";
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                    Editable = "Shipment Method CodeEditable";
                }
                field("Promised Receipt Date"; rec."Promised Receipt Date")
                {
                    ApplicationArea = all;
                    Caption = 'Expected Delivery Date';
                    Editable = "Promised Receipt DateEditable";
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Editable = "Currency CodeEditable";

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = all;
                    Editable = "Transaction TypeEditable";
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = all;
                    Editable = TransactionSpecificationEditab;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                    Editable = "Transport MethodEditable";
                }
                field("Entry Point"; rec."Entry Point")
                {
                    ApplicationArea = all;
                    Editable = "Entry PointEditable";
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = all;
                    Editable = AreaEditable;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                // field("Service Type (Rev. Chrg.)"; rec."Service Type (Rev. Chrg.)")
                // {
                //     ApplicationArea = all;
                //     Editable = "GTA Service TypeEditable";
                // }
                // field("Consignment Note No."; rec."Consignment Note No.")
                // {
                //     ApplicationArea = all;
                //     Editable = "Consignment Note No.Editable";
                // }
                // field("Declaration Form (GTA)"; rec."Declaration Form (GTA)")
                // {
                //     ApplicationArea = all;
                //     Editable = "Declaration Form (GTA)Editable";
                // }
                // field("Input Service Distribution"; rec."Input Service Distribution")
                // {
                //     ApplicationArea = all;
                //     Editable = InputServiceDistributionEditab;
                // }
                field("Freight Charges"; rec."Freight Charges")
                {
                    ApplicationArea = all;
                    Editable = "Freight ChargesEditable";
                }
                // field("C Form"; rec."C Form")
                // {
                //     ApplicationArea = all;
                //     Editable = "C FormEditable";
                // }
                // field("Form Code"; rec."Form Code")
                // {
                //     ApplicationArea = all;
                //     Editable = "Form CodeEditable";
                // }
                // field("Form No."; rec."Form No.")
                // {
                //     ApplicationArea = all;
                //     Editable = "Form No.Editable";
                // }
                // field("LC No.";rec. "LC No.")
                // {
                //     ApplicationArea = all;
                //     Editable = "LC No.Editable";
                // }
                field(Trading; rec.Trading)
                {
                    ApplicationArea = all;
                    Editable = TradingEditable;
                }
                field("Vendor TIN No."; rec."Vendor TIN No.")
                {
                    Editable = "Vendor TIN No.Editable";
                }
                group("Manufacturer Detail")
                {
                    Caption = 'Manufacturer Detail';
                    // field("Manufacturer E.C.C. No.";  rec."Manufacturer E.C.C. No.")
                    // {
                    //     ApplicationArea = all;
                    //     Editable = ManufacturerECCNoEditable;
                    // }
                    // field("Manufacturer Name"; rec."Manufacturer Name")
                    // {
                    //     ApplicationArea = all;
                    //     Editable = "Manufacturer NameEditable";
                    // }
                    // field("Manufacturer Address"; rec."Manufacturer Address")
                    // {
                    //     ApplicationArea = all;
                    //     Editable = "Manufacturer AddressEditable";
                    // }
                }
            }
            group(Application)
            {
                Caption = 'Application';
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Editable = "Applies-to Doc. TypeEditable";
                }
                field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    Editable = "Applies-to Doc. No.Editable";
                }
                field("Applies-to ID"; rec."Applies-to ID")
                {
                    ApplicationArea = all;
                    Editable = "Applies-to IDEditable";
                }
                field("Paid Amount"; rec."Paid Amount")
                {
                    ApplicationArea = all;
                    Editable = "Paid AmountEditable";
                }
                field("Paid Cheque No."; rec."Paid Cheque No.")
                {
                    ApplicationArea = all;
                    Editable = "Paid Cheque No.Editable";
                }
                field("Paid Cheque Date"; rec."Paid Cheque Date")
                {
                    ApplicationArea = all;
                    Editable = "Paid Cheque DateEditable";
                }
            }
            group(Other)
            {
                Caption = 'Other';
                field("Freight Type"; rec."Freight Type")
                {
                    ApplicationArea = all;
                }
                field("Exp. TPT Cost"; rec."Exp. TPT Cost")
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
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        /*
                        CalcInvDiscForHeader;
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CalcInvDiscForHeader;
                            COMMIT;
                        END;
                        IF Rec.Structure <> '' THEN BEGIN
                            PurchLine.CalculateStructures(Rec);
                            PurchLine.AdjustStructureAmounts(Rec);
                            PurchLine.UpdatePurchLines(Rec);
                            PurchLine.CalculateTDS(Rec);
                        END ELSE BEGIN
                            PurchLine.CalculateTDS(Rec);
                        END;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                        */
                    end;
                }
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = CONST("Blanket Order"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("St&ructure")
                {
                    ApplicationArea = all;
                    Caption = 'St&ructure';
                    // RunObject = Page 16305;
                    //                 RunPageLink = Type=CONST(Purchase),
                    //               "Document Type"=FIELD("Document Type"),
                    //               "Document No."=FIELD("No.");
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Copy Document")
                {
                    ApplicationArea = all;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                separator(sep1)
                {
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //RSPL060814
                        recPurchLine.RESET;
                        recPurchLine.SETRANGE(recPurchLine."Document No.", Rec."No.");
                        recPurchLine.SETRANGE(recPurchLine.Type, recPurchLine.Type::Item);
                        IF recPurchLine.FINDSET THEN
                            REPEAT
                                recItem.GET(recPurchLine."No.");
                                IF recItem."Item Category Code" = 'CAT08' THEN
                                    recPurchLine.TESTFIELD(recPurchLine."Landed Cost");
                            UNTIL recPurchLine.NEXT = 0;
                        //RSPL

                        // IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
                        //     ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator(sep2)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        //RSPL060814
                        recPurchLine.RESET;
                        recPurchLine.SETRANGE(recPurchLine."Document No.", Rec."No.");
                        recPurchLine.SETRANGE(recPurchLine.Type, recPurchLine.Type::Item);
                        IF recPurchLine.FINDSET THEN
                            REPEAT
                                recItem.GET(recPurchLine."No.");
                                IF recItem."Item Category Code" = 'CAT08' THEN
                                    recPurchLine.TESTFIELD(recPurchLine."Landed Cost");
                            UNTIL recPurchLine.NEXT = 0;
                        //RSPL
                        //RSPL-Sourav020415
                        cduArchveMgmt.StorePurchDocument(Rec, FALSE);
                        //RSPL-Sourav020415

                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }

                action("Calc&ulate Structure Values")
                {
                    ApplicationArea = all;
                    Caption = 'Calc&ulate Structure Values';

                    trigger OnAction()
                    begin
                        //     PurchLine.CalculateStructures(Rec);
                        //     PurchLine.AdjustStructureAmounts(Rec);
                        //     PurchLine.UpdatePurchLines(Rec);
                    end;
                }
            }
            action("Make &Order")
            {
                ApplicationArea = all;
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeader: Record 36;
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    /*  //RSPL-TC
                    //EBT STIVAN ---(08102012)--- A new Role has been created,as per the role the MAKE Order will be done ----START
                    Memberof.RESET;
                    Memberof.SETRANGE(Memberof."User ID",USERID);
                    Memberof.SETRANGE(Memberof."Role ID",'MAKE PURCH. ORDER');
                    IF NOT(Memberof.FINDFIRST) THEN
                    ERROR('You do not have permission to Make Purchase Order');
                    //EBT STIVAN ---(08102012)--- A new Role has been created,as per the role the MAKE Order will be done ------END
                    */
                    //RSPL060814
                    recPurchLine.RESET;
                    recPurchLine.SETRANGE(recPurchLine."Document No.", Rec."No.");
                    recPurchLine.SETRANGE(recPurchLine.Type, recPurchLine.Type::Item);
                    IF recPurchLine.FINDSET THEN
                        REPEAT
                            recItem.GET(recPurchLine."No.");
                            IF recItem."Item Category Code" = 'CAT08' THEN
                                recPurchLine.TESTFIELD(recPurchLine."Landed Cost");
                        UNTIL recPurchLine.NEXT = 0;
                    //RSPL
                    //RSPL-Sourav020415
                    //TESTFIELD(Status,Status::Released);
                    //RSPL-Sourav020415

                    IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                        CODEUNIT.RUN(CODEUNIT::"Blnkt Purch Ord. to Ord. (Y/N)", Rec);

                end;
            }
            group("&Print1")
            {
                Caption = '&Print';
                action("Purchase Order - &Regular")
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Order - &Regular';
                    Image = Print;

                    trigger OnAction()
                    begin
                        IF Rec."Payment Terms Code" = '' THEN
                            ERROR('Payment Terms Code is Blank');

                        //EBT STIVAN ---(1307012)-----------------------------------------------------START
                        IF Rec."Order Address Code" <> '' THEN BEGIN
                            PurchLine.RESET;
                            PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                            IF PurchLine.FINDSET THEN
                                IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                    IF Rec."Vendor TIN No." = '' THEN BEGIN
                                        OrderAddress.GET(Rec."Buy-from Vendor No.", Rec."Order Address Code");
                                        IF (OrderAddress."L.S.T. No." = '') THEN
                                            ERROR('TIN No. is Blank');
                                        //MESSAGE('TIN No. is Blank');
                                    END;
                                END;
                        END;

                        IF Rec."Order Address Code" = '' THEN BEGIN
                            PurchLine.RESET;
                            PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                            IF PurchLine.FINDSET THEN
                                IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                    IF Rec."Vendor TIN No." = '' THEN BEGIN
                                        Vendor.GET(Rec."Buy-from Vendor No.");
                                        IF (Vendor."L.S.T. No." = '') THEN
                                            ERROR('TIN No. is Blank');
                                        //MESSAGE('TIN No. is Blank');
                                    END;
                                END;
                        END;
                        //EBT STIVAN ---(13072012)-------------------------------------------------------END

                        DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Purchase Order - &Import1")
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Order - &Import';
                    Visible = false;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(50054, TRUE, FALSE, Rec)
                    end;
                }
                action("Purchase Order - R&egular Detailed")
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Order - R&egular Detailed';
                    Image = Print;

                    trigger OnAction()
                    begin
                        RecPurchheader.RESET;
                        RecPurchheader := Rec;
                        RecPurchheader.SETRECFILTER;
                        REPORT.RUNMODAL(50087, TRUE, FALSE, RecPurchheader);
                    end;
                }
                action("Purchase Order - &Import")
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Order - &Import';
                    Image = Print;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);//RSPLSUM 02Feb21
                        REPORT.RUNMODAL(50054, TRUE, FALSE, Rec);
                    end;
                }
                action("Purchase Order - GST")
                {
                    ApplicationArea = all;
                    Image = Print;

                    trigger OnAction()
                    var
                        PH: Record 38;
                    begin
                        //>>17Nov2017
                        PH.RESET;
                        PH.SETRANGE("Document Type", Rec."Document Type");
                        PH.SETRANGE("No.", Rec."No.");
                        IF PH.FINDFIRST THEN
                            REPORT.RUNMODAL(50020, TRUE, TRUE, PH);

                        //<<17Nov2017
                    end;
                }
                action("Purchase Order- GST LOGO")
                {
                    ApplicationArea = all;
                    Image = Print;

                    trigger OnAction()
                    var
                        PH: Record 38;
                        Ord05: Record 224;
                        Ven05: Record 23;
                    begin
                        //>>17Nov2017
                        PH.RESET;
                        PH.SETRANGE("Document Type", Rec."Document Type");
                        PH.SETRANGE("No.", Rec."No.");
                        IF PH.FINDFIRST THEN
                            REPORT.RUNMODAL(50170, TRUE, TRUE, PH);

                        //<<17Nov2017
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    begin
        /* //RSPL-TC
        //EBT STIVAN ---(29012013)--- A new Role has been created,as per the role the Blanket Order Form will get Editable ----START
        Memberof.RESET;
        Memberof.SETRANGE(Memberof."User ID",USERID);
        Memberof.SETRANGE(Memberof."Role ID",'BLANKET PURCH. ORDER');
        IF (Memberof.FINDFIRST) THEN */
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'BLANKET PURCH. ORDER');
        IF AccessControl.FINDFIRST THEN //RSPL-TC -
        BEGIN
            "Buy-from Vendor No.Editable" := TRUE;
            StructureEditable := TRUE;
            "Buy-from ContactEditable" := TRUE;
            "Order DateEditable" := TRUE;
            "Document DateEditable" := TRUE;
            "Vendor Order No.Editable" := TRUE;
            "Vendor Shipment No.Editable" := TRUE;
            "Order Address CodeEditable" := TRUE;
            "Purchaser CodeEditable" := TRUE;
            "Responsibility CenterEditable" := TRUE;
            "Assigned User IDEditable" := TRUE;
            "Pay-to Vendor No.Editable" := TRUE;
            "Pay-to ContactEditable" := TRUE;
            ShortcutDimension1CodeEditable := TRUE;
            ShortcutDimension2CodeEditable := TRUE;
            "Payment Terms CodeEditable" := TRUE;
            "Due DateEditable" := TRUE;
            "Payment Discount %Editable" := TRUE;
            "Pmt. Discount DateEditable" := TRUE;
            "Payment Method CodeEditable" := TRUE;
            "On HoldEditable" := TRUE;
            "Prices Including VATEditable" := TRUE;
            "Location CodeEditable" := TRUE;
            "Shipping Agent CodeEditable" := TRUE;
            "Shipment Method CodeEditable" := TRUE;
            "Promised Receipt DateEditable" := TRUE;
            "Transit DocumentEditable" := TRUE;
            "Currency CodeEditable" := TRUE;
            "Transaction TypeEditable" := TRUE;
            TransactionSpecificationEditab := TRUE;
            "Transport MethodEditable" := TRUE;
            "Entry PointEditable" := TRUE;
            AreaEditable := TRUE;
            "GTA Service TypeEditable" := TRUE;
            "Consignment Note No.Editable" := TRUE;
            "Declaration Form (GTA)Editable" := TRUE;
            InputServiceDistributionEditab := TRUE;
            ManufacturerECCNoEditable := TRUE;
            "Manufacturer NameEditable" := TRUE;
            "Manufacturer AddressEditable" := TRUE;
            "Freight ChargesEditable" := TRUE;
            "C FormEditable" := TRUE;
            "Form CodeEditable" := TRUE;
            "Form No.Editable" := TRUE;
            "LC No.Editable" := TRUE;
            TradingEditable := TRUE;
            "Vendor TIN No.Editable" := TRUE;
            "Applies-to Doc. TypeEditable" := TRUE;
            "Applies-to Doc. No.Editable" := TRUE;
            "Applies-to IDEditable" := TRUE;
            "Paid AmountEditable" := TRUE;
            "Paid Cheque No.Editable" := TRUE;
            "Paid Cheque DateEditable" := TRUE;
        END;
        //EBT STIVAN ---(29012013)--- A new Role has been created,as per the role the Blanket Order Form will get Editable ------END


        //EBT STIVAN ---(03042013)--- As per Role,the Closed Field on Blanket Order Form will get Editable ----START
        /*
        Memberof.RESET;
        Memberof.SETRANGE(Memberof."User ID",USERID);
        Memberof.SETFILTER(Memberof."Role ID",'%1','POSHORTCLOSE');
        IF Memberof.FINDFIRST THEN */
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'POSHORTCLOSE');//25July2017
        //AccessControl.SETRANGE("Role ID",'%1','POSHORTCLOSE');
        IF AccessControl.FINDFIRST THEN //RSPL-TC -
        BEGIN
            ClosedEditable := TRUE;
        END;
        //EBT STIVAN ---(03042013)--- As per Role,the Closed Field on Blanket Order Form will get Editable ------END

        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            rec.FILTERGROUP(0);
        END;

        /* // Commented by milan
        // EBT MILAN 240114 ADDED TO Show only User Location----------------------START
        CSOmapping.RESET;
        CSOmapping.SETRANGE(CSOmapping.Type,CSOmapping.Type::Location);
        CSOmapping.SETRANGE(CSOmapping."User Id",UPPERCASE(USERID));
        IF CSOmapping.FINDFIRST THEN
        BEGIN
           FILTERGROUP(2);
           SETRANGE("Location Code",CSOmapping.Value);
           FILTERGROUP(0);
        END;
        // EBT MILAN 240114 ADDED TO Show only User Location------------------------END
        */

    end;

    var
        CurrentPurchLine: Record 39;
        PurchLine: Record 39;
        PurchRcptLine: Record 121;
        PurchInvLine: Record 123;
        ReturnShptLine: Record 6651;
        PurchCrMemoLine: Record 125;
        CopyPurchDoc: Report 492;
        DocPrint: Codeunit 229;
        PurchSetup: Record 312;
        UserMgt: Codeunit 5700;
        OrderAddress: Record 224;
        Vendor: Record 23;
        CSOmapping: Record 50006;
        RecPurchheader: Record 38;
        recPurchLine: Record 39;
        recItem: Record 27;
        cduArchveMgmt: Codeunit 5063;
        // [InDataSet]

        "Buy-from Vendor No.Editable": Boolean;
        // [InDataSet]
        StructureEditable: Boolean;
        // [InDataSet]
        "Buy-from ContactEditable": Boolean;
        // [InDataSet]
        "Order DateEditable": Boolean;
        // [InDataSet]
        "Document DateEditable": Boolean;
        // [InDataSet]
        "Vendor Order No.Editable": Boolean;
        // [InDataSet]
        "Vendor Shipment No.Editable": Boolean;
        // [InDataSet]
        "Order Address CodeEditable": Boolean;
        // [InDataSet]
        "Purchaser CodeEditable": Boolean;
        // [InDataSet]
        "Responsibility CenterEditable": Boolean;
        // [InDataSet]
        "Assigned User IDEditable": Boolean;
        // [InDataSet]
        "Pay-to Vendor No.Editable": Boolean;
        // [InDataSet]
        "Pay-to ContactEditable": Boolean;
        // [InDataSet]
        ShortcutDimension1CodeEditable: Boolean;
        // [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        // [InDataSet]
        "Payment Terms CodeEditable": Boolean;
        // [InDataSet]
        "Due DateEditable": Boolean;
        // [InDataSet]
        "Payment Discount %Editable": Boolean;
        // [InDataSet]
        "Pmt. Discount DateEditable": Boolean;
        // [InDataSet]
        "Payment Method CodeEditable": Boolean;
        // [InDataSet]
        "On HoldEditable": Boolean;
        // [InDataSet]
        "Prices Including VATEditable": Boolean;
        // [InDataSet]
        "Location CodeEditable": Boolean;
        // [InDataSet]
        "Shipping Agent CodeEditable": Boolean;
        // [InDataSet]
        "Shipment Method CodeEditable": Boolean;
        // [InDataSet]
        "Promised Receipt DateEditable": Boolean;
        // [InDataSet]
        "Transit DocumentEditable": Boolean;
        // [InDataSet]
        "Currency CodeEditable": Boolean;
        // [InDataSet]
        "Transaction TypeEditable": Boolean;
        // [InDataSet]
        TransactionSpecificationEditab: Boolean;
        // [InDataSet]
        "Transport MethodEditable": Boolean;
        // [InDataSet]
        "Entry PointEditable": Boolean;
        // [InDataSet]
        AreaEditable: Boolean;
        // [InDataSet]
        "GTA Service TypeEditable": Boolean;
        // [InDataSet]
        "Consignment Note No.Editable": Boolean;
        // [InDataSet]
        "Declaration Form (GTA)Editable": Boolean;
        // [InDataSet]
        InputServiceDistributionEditab: Boolean;
        // [InDataSet]
        ManufacturerECCNoEditable: Boolean;
        // [InDataSet]
        "Manufacturer NameEditable": Boolean;
        // [InDataSet]
        "Manufacturer AddressEditable": Boolean;
        // [InDataSet]
        "Freight ChargesEditable": Boolean;
        // [InDataSet]
        "C FormEditable": Boolean;
        // [InDataSet]
        "Form CodeEditable": Boolean;
        // [InDataSet]
        "Form No.Editable": Boolean;
        // [InDataSet]
        "LC No.Editable": Boolean;
        // [InDataSet]
        TradingEditable: Boolean;
        // [InDataSet]
        "Vendor TIN No.Editable": Boolean;
        // [InDataSet]
        "Applies-to Doc. TypeEditable": Boolean;
        // [InDataSet]
        "Applies-to Doc. No.Editable": Boolean;
        // [InDataSet]
        "Applies-to IDEditable": Boolean;
        // [InDataSet]
        "Paid AmountEditable": Boolean;
        // [InDataSet]
        "Paid Cheque No.Editable": Boolean;
        // [InDataSet]
        "Paid Cheque DateEditable": Boolean;
        // [InDataSet]
        ClosedEditable: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        AccessControl: Record 2000000053;
        ChangeExchangeRate: Page 511;

    //  [Scope('Internal')]
    procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit "DocumentNoVisibility";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Blanket Order", rec."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;
}


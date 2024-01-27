page 50051 "Top Purchase"
{
    Caption = 'Top Purchase';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("TOP 5 PURCHASES DASHBOARD")
            {
                Caption = 'TOP 5 PURCHASES DASHBOARD';
                grid("Top 5 Vendors")
                {
                    Caption = 'Top 5 Vendors';
                    group("Purchase Valuewise")
                    {
                        Caption = 'Purchase Valuewise';
                        label(lab1)
                        {
                            CaptionClass = TopVendorName[1];
                            ShowCaption = false;
                        }
                        label(lab2)
                        {
                            CaptionClass = TopVendorName[2];
                            ShowCaption = false;
                        }
                        label(lab3)
                        {
                            CaptionClass = TopVendorName[3];
                            ShowCaption = false;
                        }
                        label(lab4)
                        {
                            CaptionClass = TopVendorName[4];
                            ShowCaption = false;
                        }
                        label(lab5)
                        {
                            CaptionClass = TopVendorName[5];
                            ShowCaption = false;
                        }
                    }
                    group(group1)
                    {
                        field(PurchaseAmount1; PurchaseAmount[1])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopVendor[1]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseAmount2; PurchaseAmount[2])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopVendor[2]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseAmount3; PurchaseAmount[3])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopVendor[3]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseAmount4; PurchaseAmount[4])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopVendor[4]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseAmount5; PurchaseAmount[5])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopVendor[5]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                    }
                }
                grid("Purch. Transactionwise")
                {
                    Caption = 'Purch. Transactionwise';
                    // group()
                    // {
                    //     label()
                    //     {
                    //         CaptionClass = TopVendorName1[1];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopVendorName1[2];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopVendorName1[3];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopVendorName1[4];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopVendorName1[5];
                    //         ShowCaption = false;
                    //     }
                    // }
                    group(General)
                    {
                        field(PurchaseqtyAmount1; PurchaseqtyAmount[1])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopQtyVendor[1]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseqtyAmount2; PurchaseqtyAmount[2])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopQtyVendor[2]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseqtyAmount3; PurchaseqtyAmount[3])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopQtyVendor[3]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseqtyAmount4; PurchaseqtyAmount[4])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopQtyVendor[4]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                        field(PurchaseqtyAmount5; PurchaseqtyAmount[5])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(VendorLedgerForm);
                                VendorLedgerEntry.RESET;
                                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                                VendorLedgerEntry.SETRANGE("Vendor No.", TopQtyVendor[5]);
                                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                VendorLedgerForm.SETTABLEVIEW(VendorLedgerEntry);
                                VendorLedgerForm.RUN;
                            end;
                        }
                    }
                }
                grid("Top 5 Items")
                {
                    Caption = 'Top 5 Items';
                    //group("Purchase Valuewise")
                    //{
                    //Caption = 'Purchase Valuewise';
                    // label()
                    // {
                    //     CaptionClass = TopItemName1[1];
                    //     ShowCaption = false;
                    // }
                    // label()
                    // {
                    //     CaptionClass = TopItemName1[2];
                    //     ShowCaption = false;
                    // }
                    // label()
                    // {
                    //     CaptionClass = TopItemName1[3];
                    //     ShowCaption = false;
                    // }
                    // label()
                    // {
                    //     CaptionClass = TopItemName1[4];
                    //     ShowCaption = false;
                    // }
                    // label()
                    // {
                    //     CaptionClass = TopItemName1[5];
                    //     ShowCaption = false;
                    // }
                    // }
                    group(General2)
                    {
                        field(QtyPurchased11; QtyPurchased1[1])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[1]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased12; QtyPurchased1[2])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[2]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased13; QtyPurchased1[3])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[3]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased14; QtyPurchased1[4])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[4]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased15; QtyPurchased1[5])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[5]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                    }
                    group(General3)
                    {
                        field(TotalItemValuePurchased11; TotalItemValuePurchased1[1])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[1]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased12; TotalItemValuePurchased1[2])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[2]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased13; TotalItemValuePurchased1[3])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[3]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased14; TotalItemValuePurchased1[4])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[4]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased15; TotalItemValuePurchased1[5])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem1[5]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                    }
                }
                grid("Purch. Quantity Wise")
                {
                    // Caption = 'Purch. Quantity Wise';
                    // group()
                    // {
                    //     label()
                    //     {
                    //         CaptionClass = TopItemName[1];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopItemName[2];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopItemName[3];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopItemName[4];
                    //         ShowCaption = false;
                    //     }
                    //     label()
                    //     {
                    //         CaptionClass = TopItemName[5];
                    //         ShowCaption = false;
                    //     }
                    // }
                    group(General4)
                    {
                        field(QtyPurchased1; QtyPurchased[1])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[1]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased2; QtyPurchased[2])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[2]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased3; QtyPurchased[3])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[3]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased4; QtyPurchased[4])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[4]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtyPurchased5; QtyPurchased[5])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[5]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                    }
                    group(General6)
                    {
                        field(TotalItemValuePurchased1; TotalItemValuePurchased[1])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[1]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased2; TotalItemValuePurchased[2])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[2]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased3; TotalItemValuePurchased[3])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[3]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased4; TotalItemValuePurchased[4])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[4]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValuePurchased5; TotalItemValuePurchased[5])
                        {

                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[5]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Month := DATE2DMY(TODAY, 2);
        Year := DATE2DMY(TODAY, 3);
        StartingDateofTheMonth := DMY2DATE(1, Month, Year);

        TopVendorCal;
        TopPurchasedVendorCal;
        TopItemAmountCal;
        TopItemCal;
    end;

    var
        Vendor: Record 23;
        TopVendor: array[5] of Code[20];
        TopPOVendor: Code[20];
        TotalPurchaseAmtVendorwise: Decimal;
        VendorPurchaseAmtGreater: Decimal;
        VendorLedgerEntry: Record 25;
        VendorLedgerForm: Page 29;
        Month: Integer;
        Year: Integer;
        StartingDateofTheMonth: Date;
        PurchaseAmount: array[5] of Decimal;
        i: Integer;
        TotalPurchaseQtyVendorwise: Integer;
        VendorPurchaseQtyGreater: Integer;
        TopQtyVendor: array[5] of Code[20];
        PurchaseqtyAmount: array[5] of Decimal;
        Item: Record 27;
        TopItem: array[5] of Code[20];
        TotalItemValuePurchased: array[5] of Decimal;
        TotalItemQtyPurchasedGreater: Decimal;
        ItemLedgerEntry: Record 32;
        ItemLedgerEntryForm: Page 38;
        TotalItemQtyPurchased: Decimal;
        QtyPurchased: array[5] of Decimal;
        TopVendorName: array[5] of Text[60];
        TopVendorName1: array[5] of Text[60];
        TopItemName: array[5] of Text[50];
        TopItem1: array[5] of Code[20];
        TotalItemValuePurchased1: array[5] of Decimal;
        TotalItemQtyPurchasedGreater1: Decimal;
        TotalItemQtyPurchased1: Decimal;
        QtyPurchased1: array[5] of Decimal;
        TopItemName1: array[5] of Text[50];

    //[Scope('Internal')]
    procedure TopVendorCal()
    begin
        VendorPurchaseAmtGreater := 0;
        Vendor.RESET;
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseAmtVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalPurchaseAmtVendorwise += VendorLedgerEntry."Purchase (LCY)";
                    UNTIL VendorLedgerEntry.NEXT = 0;
                IF ABS(TotalPurchaseAmtVendorwise) > VendorPurchaseAmtGreater THEN BEGIN
                    VendorPurchaseAmtGreater := ABS(TotalPurchaseAmtVendorwise);
                    TopVendor[1] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseAmtGreater := VendorPurchaseAmtGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseAmtGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1', TopVendor[1]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseAmtVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalPurchaseAmtVendorwise += VendorLedgerEntry."Purchase (LCY)";
                    UNTIL VendorLedgerEntry.NEXT = 0;
                IF ABS(TotalPurchaseAmtVendorwise) > VendorPurchaseAmtGreater THEN BEGIN
                    VendorPurchaseAmtGreater := ABS(TotalPurchaseAmtVendorwise);
                    TopVendor[2] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseAmtGreater := VendorPurchaseAmtGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseAmtGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1&<>%2', TopVendor[1], TopVendor[2]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseAmtVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalPurchaseAmtVendorwise += VendorLedgerEntry."Purchase (LCY)";
                    UNTIL VendorLedgerEntry.NEXT = 0;
                IF ABS(TotalPurchaseAmtVendorwise) > VendorPurchaseAmtGreater THEN BEGIN
                    VendorPurchaseAmtGreater := ABS(TotalPurchaseAmtVendorwise);
                    TopVendor[3] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseAmtGreater := VendorPurchaseAmtGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseAmtGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1&<>%2&<>%3', TopVendor[1], TopVendor[2], TopVendor[3]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseAmtVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalPurchaseAmtVendorwise += VendorLedgerEntry."Purchase (LCY)";
                    UNTIL VendorLedgerEntry.NEXT = 0;
                IF ABS(TotalPurchaseAmtVendorwise) > VendorPurchaseAmtGreater THEN BEGIN
                    VendorPurchaseAmtGreater := ABS(TotalPurchaseAmtVendorwise);
                    TopVendor[4] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseAmtGreater := VendorPurchaseAmtGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseAmtGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1&<>%2&<>%3&<>%4', TopVendor[1], TopVendor[2], TopVendor[3], TopVendor[4]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseAmtVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalPurchaseAmtVendorwise += VendorLedgerEntry."Purchase (LCY)";
                    UNTIL VendorLedgerEntry.NEXT = 0;
                IF ABS(TotalPurchaseAmtVendorwise) > VendorPurchaseAmtGreater THEN BEGIN
                    VendorPurchaseAmtGreater := ABS(TotalPurchaseAmtVendorwise);
                    TopVendor[5] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseAmtGreater := VendorPurchaseAmtGreater;
            UNTIL Vendor.NEXT = 0;

        CLEAR(TopVendorName);
        i := 0;
        REPEAT
            i += 1;
            Vendor.RESET;
            Vendor.SETRANGE(Vendor."No.", TopVendor[i]);
            IF Vendor.FINDFIRST THEN;
            TopVendorName[i] := Vendor.Name;
        UNTIL i = 5;

        CLEAR(PurchaseAmount);
        i := 0;
        REPEAT
            i += 1;
            VendorLedgerEntry.RESET;
            VendorLedgerEntry.SETRANGE("Vendor No.", TopVendor[i]);
            VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
            IF VendorLedgerEntry.FINDSET THEN
                REPEAT
                    PurchaseAmount[i] += VendorLedgerEntry."Purchase (LCY)";
                UNTIL VendorLedgerEntry.NEXT = 0;
        UNTIL i = 5;
    end;

    //[Scope('Internal')]
    procedure TopPurchasedVendorCal()
    begin
        VendorPurchaseQtyGreater := 0;
        Vendor.RESET;
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseQtyVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    TotalPurchaseQtyVendorwise += VendorLedgerEntry.COUNT;
                IF ABS(TotalPurchaseQtyVendorwise) > VendorPurchaseQtyGreater THEN BEGIN
                    VendorPurchaseQtyGreater := ABS(TotalPurchaseQtyVendorwise);
                    TopQtyVendor[1] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseQtyGreater := VendorPurchaseQtyGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseQtyGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1', TopQtyVendor[1]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseQtyVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    TotalPurchaseQtyVendorwise += VendorLedgerEntry.COUNT;
                IF ABS(TotalPurchaseQtyVendorwise) > VendorPurchaseQtyGreater THEN BEGIN
                    VendorPurchaseQtyGreater := ABS(TotalPurchaseQtyVendorwise);
                    TopQtyVendor[2] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseQtyGreater := VendorPurchaseQtyGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseQtyGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1&<>%2', TopQtyVendor[1], TopQtyVendor[2]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseQtyVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    TotalPurchaseQtyVendorwise += VendorLedgerEntry.COUNT;
                IF ABS(TotalPurchaseQtyVendorwise) > VendorPurchaseQtyGreater THEN BEGIN
                    VendorPurchaseQtyGreater := ABS(TotalPurchaseQtyVendorwise);
                    TopQtyVendor[3] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseQtyGreater := VendorPurchaseQtyGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseQtyGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1&<>%2&<>%3', TopQtyVendor[1], TopQtyVendor[2], TopQtyVendor[3]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseQtyVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    TotalPurchaseQtyVendorwise += VendorLedgerEntry.COUNT;
                IF ABS(TotalPurchaseQtyVendorwise) > VendorPurchaseQtyGreater THEN BEGIN
                    VendorPurchaseQtyGreater := ABS(TotalPurchaseQtyVendorwise);
                    TopQtyVendor[4] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseQtyGreater := VendorPurchaseQtyGreater;
            UNTIL Vendor.NEXT = 0;

        VendorPurchaseQtyGreater := 0;
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", '<>%1&<>%2&<>%3&<>%4', TopQtyVendor[1], TopQtyVendor[2], TopQtyVendor[3], TopQtyVendor[4]);
        IF Vendor.FINDSET THEN
            REPEAT
                TotalPurchaseQtyVendorwise := 0;
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF VendorLedgerEntry.FINDSET THEN
                    TotalPurchaseQtyVendorwise += VendorLedgerEntry.COUNT;
                IF ABS(TotalPurchaseQtyVendorwise) > VendorPurchaseQtyGreater THEN BEGIN
                    VendorPurchaseQtyGreater := ABS(TotalPurchaseQtyVendorwise);
                    TopQtyVendor[5] := Vendor."No.";
                END
                ELSE
                    VendorPurchaseQtyGreater := VendorPurchaseQtyGreater;
            UNTIL Vendor.NEXT = 0;

        CLEAR(TopVendorName1);
        i := 0;
        REPEAT
            i += 1;
            Vendor.RESET;
            Vendor.SETRANGE(Vendor."No.", TopQtyVendor[i]);
            IF Vendor.FINDFIRST THEN;
            TopVendorName1[i] := Vendor.Name;
        UNTIL i = 5;

        CLEAR(PurchaseqtyAmount);
        i := 0;
        REPEAT
            i += 1;
            VendorLedgerEntry.RESET;
            VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
            VendorLedgerEntry.SETRANGE("Vendor No.", TopQtyVendor[i]);
            VendorLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
            IF VendorLedgerEntry.FINDSET THEN
                REPEAT
                    PurchaseqtyAmount[i] += VendorLedgerEntry."Purchase (LCY)";
                UNTIL VendorLedgerEntry.NEXT = 0;
        UNTIL i = 5;
    end;

    //[Scope('Internal')]
    procedure TopItemCal()
    begin
        TotalItemQtyPurchasedGreater := 0;
        Item.RESET;
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtyPurchased += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased) > TotalItemQtyPurchasedGreater THEN BEGIN
                    TotalItemQtyPurchasedGreater := ABS(TotalItemQtyPurchased);
                    TopItem[1] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater := TotalItemQtyPurchasedGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1', TopItem[1]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtyPurchased += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased) > TotalItemQtyPurchasedGreater THEN BEGIN
                    TotalItemQtyPurchasedGreater := ABS(TotalItemQtyPurchased);
                    TopItem[2] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater := TotalItemQtyPurchasedGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2', TopItem[1], TopItem[2]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtyPurchased += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased) > TotalItemQtyPurchasedGreater THEN BEGIN
                    TotalItemQtyPurchasedGreater := ABS(TotalItemQtyPurchased);
                    TopItem[3] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater := TotalItemQtyPurchasedGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2&<>%3', TopItem[1], TopItem[2], TopItem[3]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtyPurchased += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased) > TotalItemQtyPurchasedGreater THEN BEGIN
                    TotalItemQtyPurchasedGreater := ABS(TotalItemQtyPurchased);
                    TopItem[4] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater := TotalItemQtyPurchasedGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2&<>%3&<>%4', TopItem[1], TopItem[2], TopItem[3], TopItem[4]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtyPurchased += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased) > TotalItemQtyPurchasedGreater THEN BEGIN
                    TotalItemQtyPurchasedGreater := ABS(TotalItemQtyPurchased);
                    TopItem[5] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater := TotalItemQtyPurchasedGreater;
            UNTIL Item.NEXT = 0;

        CLEAR(TopItemName);
        i := 0;
        REPEAT
            i += 1;
            Item.RESET;
            Item.SETRANGE("No.", TopItem[i]);
            IF Item.FINDFIRST THEN;
            TopItemName[i] := Item.Description;
        UNTIL i = 5;

        CLEAR(TotalItemValuePurchased);
        CLEAR(QtyPurchased);
        i := 0;
        REPEAT
            i += 1;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE("Item No.", TopItem[i]);
            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
            ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    QtyPurchased[i] += ItemLedgerEntry.Quantity;
                    ItemLedgerEntry.CALCFIELDS("Purchase Amount (Expected)", "Purchase Amount (Actual)");
                    TotalItemValuePurchased[i] += ItemLedgerEntry."Purchase Amount (Expected)" + ItemLedgerEntry."Purchase Amount (Actual)";
                UNTIL ItemLedgerEntry.NEXT = 0;
        UNTIL i = 5;
    end;

    //[Scope('Internal')]
    procedure TopItemAmountCal()
    begin
        TotalItemQtyPurchasedGreater1 := 0;
        Item.RESET;
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased1 := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Purchase Amount (Expected)", "Purchase Amount (Actual)");
                        TotalItemQtyPurchased1 += ItemLedgerEntry."Purchase Amount (Expected)" + ItemLedgerEntry."Purchase Amount (Actual)";
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased1) > TotalItemQtyPurchasedGreater1 THEN BEGIN
                    TotalItemQtyPurchasedGreater1 := ABS(TotalItemQtyPurchased1);
                    TopItem1[1] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater1 := TotalItemQtyPurchasedGreater1;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater1 := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1', TopItem1[1]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased1 := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Purchase Amount (Expected)", "Purchase Amount (Actual)");
                        TotalItemQtyPurchased1 += ItemLedgerEntry."Purchase Amount (Expected)" + ItemLedgerEntry."Purchase Amount (Actual)";
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased1) > TotalItemQtyPurchasedGreater1 THEN BEGIN
                    TotalItemQtyPurchasedGreater1 := ABS(TotalItemQtyPurchased1);
                    TopItem1[2] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater1 := TotalItemQtyPurchasedGreater1;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater1 := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2', TopItem1[1], TopItem1[2]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased1 := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Purchase Amount (Expected)", "Purchase Amount (Actual)");
                        TotalItemQtyPurchased1 += ItemLedgerEntry."Purchase Amount (Expected)" + ItemLedgerEntry."Purchase Amount (Actual)";
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased1) > TotalItemQtyPurchasedGreater1 THEN BEGIN
                    TotalItemQtyPurchasedGreater1 := ABS(TotalItemQtyPurchased1);
                    TopItem1[3] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater1 := TotalItemQtyPurchasedGreater1;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater1 := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2&<>%3', TopItem1[1], TopItem1[2], TopItem1[3]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased1 := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Purchase Amount (Expected)", "Purchase Amount (Actual)");
                        TotalItemQtyPurchased1 += ItemLedgerEntry."Purchase Amount (Expected)" + ItemLedgerEntry."Purchase Amount (Actual)";
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased1) > TotalItemQtyPurchasedGreater1 THEN BEGIN
                    TotalItemQtyPurchasedGreater1 := ABS(TotalItemQtyPurchased1);
                    TopItem1[4] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater1 := TotalItemQtyPurchasedGreater1;
            UNTIL Item.NEXT = 0;

        TotalItemQtyPurchasedGreater1 := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2&<>%3&<>%4', TopItem1[1], TopItem1[2], TopItem1[3], TopItem1[4]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtyPurchased1 := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Purchase Amount (Expected)", "Purchase Amount (Actual)");
                        TotalItemQtyPurchased1 += ItemLedgerEntry."Purchase Amount (Expected)" + ItemLedgerEntry."Purchase Amount (Actual)";
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtyPurchased1) > TotalItemQtyPurchasedGreater1 THEN BEGIN
                    TotalItemQtyPurchasedGreater1 := ABS(TotalItemQtyPurchased1);
                    TopItem1[5] := Item."No.";
                END
                ELSE
                    TotalItemQtyPurchasedGreater1 := TotalItemQtyPurchasedGreater1;
            UNTIL Item.NEXT = 0;

        CLEAR(TopItemName1);
        i := 0;
        REPEAT
            i += 1;
            Item.RESET;
            Item.SETRANGE("No.", TopItem1[i]);
            IF Item.FINDFIRST THEN;
            TopItemName1[i] := Item.Description;
        UNTIL i = 5;

        CLEAR(TotalItemValuePurchased1);
        CLEAR(QtyPurchased1);
        i := 0;
        REPEAT
            i += 1;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE("Item No.", TopItem1[i]);
            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
            ItemLedgerEntry.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    QtyPurchased1[i] += ItemLedgerEntry.Quantity;
                    ItemLedgerEntry.CALCFIELDS("Purchase Amount (Expected)", "Purchase Amount (Actual)");
                    TotalItemValuePurchased1[i] += ItemLedgerEntry."Purchase Amount (Expected)" + ItemLedgerEntry."Purchase Amount (Actual)";
                UNTIL ItemLedgerEntry.NEXT = 0;
        UNTIL i = 5;
    end;
}


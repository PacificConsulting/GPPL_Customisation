pageextension 50040 "Prod. Order ComponentExtcstm" extends "Prod. Order Components"
{
    layout
    {
        addafter("Remaining Quantity")
        {
            field(InventoryAvailable; InventoryAvailable)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Inventory Available';
            }
            field("Online Rejection Qty"; Rec."Online Rejection Qty")
            {
                ApplicationArea = all;
                Editable = OnlineRejEditable;
            }
            field("Input Quantity"; Rec."Input Quantity")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    ProOrd22: Record "Production Order";
                    ProOrdComp22: Record "Prod. Order Component";
                    TempQty22: Decimal;
                    ILE22: Record "Item Ledger Entry";
                begin
                    //>>22Oct2018
                    Rec.CALCFIELDS("Act. Consumption (Qty)");
                    IF Rec."Act. Consumption (Qty)" <> 0 THEN
                        ERROR('You cannot Input Quantity after Posting, Kindly create New line');

                    CLEAR(TempQty22);
                    ProOrd22.RESET;
                    IF ProOrd22.GET(rec.Status, rec."Prod. Order No.") THEN
                        IF ProOrd22."Order Type" = ProOrd22."Order Type"::Primary THEN BEGIN
                            ProOrdComp22.RESET;
                            ProOrdComp22.SETRANGE(Status, rec.Status);
                            ProOrdComp22.SETRANGE("Prod. Order No.", rec."Prod. Order No.");
                            ProOrdComp22.SETFILTER("Line No.", '<>%1', rec."Line No.");
                            IF ProOrdComp22.FINDFIRST THEN BEGIN
                                ProOrdComp22.CALCSUMS("Expected Quantity");
                                TempQty22 := ProOrdComp22."Expected Quantity";
                                TempQty22 += rec."Input Quantity";

                                ILE22.RESET;
                                ILE22.SETCURRENTKEY("Document No.");
                                ILE22.SETRANGE("Document No.", rec."Prod. Order No.");
                                ILE22.SETRANGE("Entry Type", ILE22."Entry Type"::Output);
                                IF NOT ILE22.FINDFIRST THEN
                                    IF TempQty22 > ProOrd22.Quantity THEN
                                        ERROR('Quantity cannot be greater than Production Quantity');
                            END;
                        END;
                    //<<22Oct2018
                end;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //RSPLSUM 24Feb21>>
        CLEAR(InventoryAvailable);
        RecItem.RESET;
        IF RecItem.GET(Rec."Item No.") THEN BEGIN
            RecItem.CALCFIELDS(Inventory);
            InventoryAvailable := RecItem.Inventory;
        END;
        //RSPLSUM 24Feb21<<
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        //>>04Sep2018
        OnlineRejEditable := FALSE;
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            ProOrd.RESET;
            ProOrd.SETRANGE(Status, Rec.Status);
            ProOrd.SETRANGE("No.", Rec."Prod. Order No.");
            ProOrd.SETRANGE("Order Type", ProOrd."Order Type"::Secondary);
            IF ProOrd.FINDFIRST THEN
                OnlineRejEditable := TRUE
            ELSE
                OnlineRejEditable := FALSE;
        END ELSE
            OnlineRejEditable := FALSE;
        //<<04Sep2018
    end;

    var
        InventoryAvailable: Decimal;
        RecItem: Record Item;
        OnlineRejEditable: Boolean;
        ProOrd: Record "Production Order";
}
page 50039 "Discount Calculation"
{
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field(CustomerNo; CustomerNo)
            {
                Caption = 'Customer No.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    IF PAGE.RUNMODAL(22, CustomerRec) = ACTION::LookupOK THEN
                        CustomerNo := CustomerRec."No.";
                end;
            }
            field(StartingDate; StartingDate)
            {
            }
            field(EndingDate; EndingDate)
            {
                Caption = 'EndingDate';
            }
            field(ItemNo; ItemNo)
            {

                trigger OnLookup(var Text: Text): Boolean
                begin
                    IF PAGE.RUNMODAL(31, ItemRec) = ACTION::LookupOK THEN BEGIN
                        ItemNo := ItemRec."No.";
                        ItemDescription := ItemRec.Description;
                    END;
                end;
            }
            field(ItemDescription; ItemDescription)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Show Data")
            {
                Caption = '&Show Data';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ShowSalesdata;
                end;
            }
            action("&Create Data")
            {
                Caption = '&Create Data';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF CustomerNo = '' THEN
                        ERROR('Please select the Customer');
                    IF StartingDate = 0D THEN
                        ERROR('Please give one date range');
                    IF EndingDate = 0D THEN
                        ERROR('Please give one date range');
                    /*
                    Discounts.RESET;
                    Discounts.SETRANGE("Expected TPT Cost",CustomerNo);
                    IF ItemNo <> '' THEN
                       Discounts.SETRANGE("LR Date",ItemNo);
                    Discounts.SETRANGE(Discounts."To Location Name",FALSE);
                    IF Discounts.FINDSET THEN
                    BEGIN
                       IF CONFIRM(
                    'The Data for this customer already exists. If you create again the old data will be deleted. Do you still want to continue?',
                                  TRUE) THEN
                      BEGIN
                        DeleteSalesdata;
                        CreateSalesdata;
                        ShowSalesdata;
                      END
                      ELSE
                        ShowSalesdata;
                    END
                    ELSE
                    BEGIN
                      CreateSalesdata;
                      ShowSalesdata;
                    END;
                    */

                end;
            }
        }
    }

    var
        CustomerNo: Code[10];
        CustomerRec: Record 18;
        StartingDate: Date;
        EndingDate: Date;
        ItemNo: Code[10];
        ItemRec: Record 27;
        SalesInvoiceLine: Record 113;
        Discounts: Record 50021;
        Discounts1: Record 50021;
        Created: Boolean;
        ItemDescription: Text[50];
        Text19046906: Label 'Starting Date';
        Text19021864: Label 'Item No.';

    //[Scope('Internal')]
    procedure CreateSalesdata()
    begin
        Created := FALSE;
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETCURRENTKEY("Sell-to Customer No.", "Posting Date", Type, "No.", "Line No.");
        SalesInvoiceLine.SETRANGE("Sell-to Customer No.", CustomerNo);
        SalesInvoiceLine.SETRANGE("Posting Date", StartingDate, EndingDate);
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
        IF ItemNo <> '' THEN
            SalesInvoiceLine.SETRANGE("No.", ItemNo);
        IF SalesInvoiceLine.FINDSET THEN
            REPEAT
                Discounts.RESET;
                Discounts.SETRANGE(Discounts."Invoice No.", SalesInvoiceLine."Document No.");
                Discounts.SETRANGE(Discounts."Invoice Date", SalesInvoiceLine."Posting Date");
                IF NOT Discounts.FINDFIRST THEN BEGIN
                    /*
                    Discounts1.INIT;
                    Discounts1."Invoice No." := SalesInvoiceLine."Document No.";
                    Discounts1."Invoice Date" := SalesInvoiceLine."Posting Date";
                    Discounts1."LR No." :=  SalesInvoiceLine."No.";
                    Discounts1."LR Date" := SalesInvoiceLine."Posting Date";
                    Discounts1.Open := SalesInvoiceLine.Description;
                    Discounts1.Applied := SalesInvoiceLine."Unit of Measure Code";
                    Discounts1."Vehicle No." := SalesInvoiceLine."Qty. per Unit of Measure";
                    Discounts1."From Location Code" := SalesInvoiceLine.Quantity;
                    Discounts1."From Location Name" := SalesInvoiceLine."Quantity (Base)";
                    Discounts1.Destination := SalesInvoiceLine."MRP Price";
                    Discounts1."Vendor Code" := SalesInvoiceLine."Unit Price"/SalesInvoiceLine."Qty. per Unit of Measure";
                    Discounts1."Expected TPT Cost" := SalesInvoiceLine."Sell-to Customer No.";
                    Discounts1.INSERT;
                    Created := TRUE;
                    */
                END;
            UNTIL SalesInvoiceLine.NEXT = 0;
        IF Created THEN
            MESSAGE('The Sales data have been created.')
        ELSE
            MESSAGE('No Data was found in this range');

    end;

    // [Scope('Internal')]
    procedure DeleteSalesdata()
    begin
        /*
        Discounts1.RESET;
        Discounts1.SETRANGE("Expected TPT Cost",CustomerNo);
        IF ItemNo <> '' THEN
           Discounts1.SETRANGE("LR Date",ItemNo);
        Discounts1.SETRANGE("To Location Name",FALSE);
        IF Discounts1.FINDSET THEN
           Discounts.DELETEALL;
        */

    end;

    // [Scope('Internal')]
    procedure ShowSalesdata()
    begin
        /*
        Discounts1.RESET;
        Discounts1.SETRANGE("Expected TPT Cost",CustomerNo);
        IF ItemNo <> '' THEN
           Discounts1.SETRANGE("LR Date",ItemNo);
        Discounts1.SETRANGE("To Location Name",FALSE);
        DiscountForm.SETTABLEVIEW(Discounts1);
        DiscountForm.RUN;
        */

    end;
}


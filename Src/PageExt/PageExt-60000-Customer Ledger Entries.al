pageextension 60000 customeLedgerEntriesExt extends "Customer Ledger Entries"
{
    Editable = false;
    layout
    {
        addafter(Description)
        {
            /* field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            } */
        }
        addafter("Global Dimension 1 Code")
        {
            /* field("Sales (LCY)"; Rec."Sales (LCY)")
            {
                ApplicationArea = all;
            } */
        }
        addafter("Global Dimension 2 Code")
        {
            // field("Sub Expense"; rec."Sub Expense")
            // {
            //     ApplicationArea = all;
            // }
            field("Cheque No."; Rec."Cheque No.")
            {
                ApplicationArea = all;
            }
            field("Cheque Date"; rec."Cheque Date")
            {
                ApplicationArea = all;
            }
            field("Creation Date"; rec."Creation Date")
            {
                ApplicationArea = all;
            }
        }
        addafter(Amount)
        {
            /* field("Debit Amount"; rec."Debit Amount")
            {
                ApplicationArea = all;
            } */
            /*  field("Credit Amount"; rec."Credit Amount")
             {
                 ApplicationArea = all;
             } */

        }
        addafter("Amount (LCY)")
        {
            /* field("Debit Amount (LCY)"; rec."Debit Amount (LCY)")
            {
                ApplicationArea = all;
            } */
            /*  field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
             {
                 ApplicationArea = all;
             } */
        }
        addafter("Entry No.")
        {
            /* field("Message to Recipient"; rec."Message to Recipient")
            {
                ApplicationArea = all;
            } */
            /* field("Payment Method Code"; rec."Payment Method Code")
            {
                ApplicationArea = all;
            } */
        }
        addafter("Direct Debit Mandate ID")
        {
            field("Original Currency Factor"; rec."Original Currency Factor")
            {
                ApplicationArea = all;
            }
            field("Payment Term Code"; rec."Payment Term Code")
            {
                ApplicationArea = all;
            }
        }

    }


    actions
    {
        /*  modify("Print GST Voucher")
         {


             CustLedgerEntry.SETFILTER("Document Type",'%1|%2',CustLedgerEntry."Document Type"::Payment,CustLedgerEntry."Document Type"::Refund);
         } */
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        user.GET(USERID);
        IF (user."User ID" = 'CF24') OR (user."User ID" = 'CF09') OR (user."User ID" = 'CF11') OR (user."User ID" = 'CF12') OR
        (user."User ID" = 'CF16') OR (user."User ID" = 'CF22') OR (user."User ID" = 'CF29') OR (user."User ID" = 'CF31') OR
        (user."User ID" = 'CF32') OR (user."User ID" = 'CF34') OR (user."User ID" = 'CF35') OR (user."User ID" = 'CF36') OR
        (user."User ID" = 'CF40') OR (user."User ID" = 'CF41') OR (user."User ID" = 'CF42') OR (user."User ID" = 'CF43') OR
        (user."User ID" = 'CF44') OR (user."User ID" = 'CF46') OR (user."User ID" = 'CF47') OR (user."User ID" = 'CF48') OR
        (user."User ID" = 'CF49') OR (user."User ID" = 'CF50') OR (user."User ID" = 'CF51') OR (user."User ID" = 'CF52') OR
        (user."User ID" = 'CF53') OR (user."User ID" = 'CF55') THEN
            ERROR('You ar not allowed to View the Ledger Entries');

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //RSPLSUM 21Jan21>>
        CLEAR(PaymentTermsCode);
        IF rec."Document Type" = rec."Document Type"::Invoice THEN BEGIN
            RecSIH.RESET;
            IF RecSIH.GET(rec."Document No.") THEN
                PaymentTermsCode := RecSIH."Payment Terms Code";
        END;
        //RSPLSUM 21Jan21<<
    END;


    var
        myInt: Integer;
        user: Record 91;
        PaymentTermsCode: Code[10];
        RecSIH: Record 112;
}
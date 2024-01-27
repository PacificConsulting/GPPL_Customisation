table 50058 "Detailed G/L Entry Application"
{
    Caption = 'Detailed G/L Entry Application';
    DataCaptionFields = "G/L Account No.";
    DrillDownPageID = 50099;
    LookupPageID = 50099;
    Permissions = TableData 50058 = rimd;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "G/L Application Entry No."; Integer)
        {
            Caption = 'G/L Application Entry No.';
            TableRelation = "G/L Entry Application";
        }
        field(3; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = ',Initial Entry,Application';
            OptionMembers = ,"Initial Entry",Application;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(8; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(9; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(10; "User ID"; Code[50])
        {
            Caption = 'User ID';
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit 418;
            begin
                //UserMgt.LookupUserID("Source Code");
            end;
        }
        field(11; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(12; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(13; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
        }
        field(14; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
        }
        field(15; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount (LCY)';
        }
        field(16; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount (LCY)';
        }
        field(17; "Initial Entry Global Dim. 1"; Code[20])
        {
            Caption = 'Initial Entry Global Dim. 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Initial Entry Global Dim. 2"; Code[20])
        {
            Caption = 'Initial Entry Global Dim. 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(20; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(21; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(22; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(23; "Initial Document Type"; Option)
        {
            Caption = 'Initial Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(24; "Applied G/L Appl Entry No."; Integer)
        {
            Caption = 'Applied G/L Appl Entry No.';
        }
        field(25; Unapplied; Boolean)
        {
            Caption = 'Unapplied';
        }
        field(26; "Unapplied by Entry No."; Integer)
        {
            Caption = 'Unapplied by Entry No.';
            TableRelation = "Detailed G/L Entry Application";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "G/L Application Entry No.", "Posting Date")
        {
        }
        key(Key3; "G/L Application Entry No.", "Entry Type", "Posting Date")
        {
            MaintainSQLIndex = false;
            SumIndexFields = "Amount (LCY)";
        }
        key(Key4; "Document No.", "Document Type", "Posting Date")
        {
        }
        key(Key5; "Debit Amount", "G/L Account No.", "Entry Type")
        {
        }
        key(Key6; "G/L Application Entry No.", "Posting Date", "Document No.")
        {
        }
        key(Key7; "G/L Account No.", "Entry Type", "Document Type", "Posting Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "G/L Application Entry No.", "G/L Account No.", "Posting Date", "Document Type", "Document No.")
        {
        }
    }

    trigger OnDelete()
    begin
        //ERROR('Detailed G/L Application Entry cannot be Deleted');
    end;

    trigger OnInsert()
    var
        GenJnlPostPreview: Codeunit 19;
    begin
    end;

    //[Scope('Internal')]
    procedure UpdateDebitCredit(Correction: Boolean)
    begin
        /*
        IF ((Amount > 0) OR ("Amount (LCY)" > 0)) AND NOT Correction OR
           ((Amount < 0) OR ("Amount (LCY)" < 0)) AND Correction
        THEN BEGIN
          "Credit Amount (LCY)" := Amount;
          "Initial Entry Global Dim. 1" := 0;
          "Initial Entry Global Dim. 2" := "Amount (LCY)";
          "Gen. Bus. Posting Group" := 0;
        END ELSE BEGIN
          "Credit Amount (LCY)" := 0;
          "Initial Entry Global Dim. 1" := -Amount;
          "Initial Entry Global Dim. 2" := 0;
          "Gen. Bus. Posting Group" := -"Amount (LCY)";
        END;
        */

    end;

    // [Scope('Internal')]
    procedure SetZeroTransNo(TransactionNo: Integer)
    var
        DtldCustLedgEntry: Record 379;
        ApplicationNo: Integer;
    begin
        DtldCustLedgEntry.SETCURRENTKEY("Transaction No.");
        DtldCustLedgEntry.SETRANGE("Transaction No.", TransactionNo);
        IF DtldCustLedgEntry.FINDSET(TRUE) THEN BEGIN
            ApplicationNo := DtldCustLedgEntry."Entry No.";
            REPEAT
                DtldCustLedgEntry."Transaction No." := 0;
                DtldCustLedgEntry."Application No." := ApplicationNo;
                DtldCustLedgEntry.MODIFY;
            UNTIL DtldCustLedgEntry.NEXT = 0;
        END;
    end;
}


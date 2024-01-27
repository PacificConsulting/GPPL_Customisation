tableextension 50007 CusLedEntExtCustm extends 21
{
    fields
    {
        field(50000; "Cheque No."; Code[20])
        {
            //CalcFormula = Lookup("Bank Account Ledger Entry"."Cheque No." WHERE ("Document No."=FIELD("Document No.")));
            Description = '//EBT Rakshitha';
            //FieldClass = FlowField; Azhar pending
        }
        field(50001; "Cheque Date"; Date)
        {
            Description = '//EBT Rakshitha';
        }
        field(50002; "Creation Date"; DateTime)
        {
            Description = 'RSPLDJ 22NOV19';
        }
        field(50003; "Credit Checking Not Required"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
        }
        field(50004; "Payment Term Code"; Code[10])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Payment Terms Code" WHERE("No." = FIELD("Document No.")));
            Description = 'RB-N 30Jan2019';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}
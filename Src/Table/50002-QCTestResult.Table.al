table 50002 "QC Test Result"
{

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
        }
        field(3; "Item No."; Code[20])
        {
            Editable = false;
        }
        field(4; Parameter; Code[30])
        {
            Editable = false;
        }
        field(5; "Min Range"; Code[20])
        {
            Editable = false;
        }
        field(6; "Max Range"; Code[20])
        {
            Editable = false;
        }
        field(7; Result; Code[20])
        {

            trigger OnValidate()
            begin
                //TESTFIELD("Min Range");
                //TESTFIELD("Max Range");
            end;
        }
        field(8; Approved; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            begin
                TESTFIELD(Result);
                IF NOT Approved THEN BEGIN
                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE(PurchaseLine."Document No.", "Order No.");
                    PurchaseLine.SETRANGE(PurchaseLine."Line No.", "Line No.");
                    PurchaseLine.SETRANGE(PurchaseLine."QC Approved", TRUE);
                    IF PurchaseLine.FINDFIRST THEN
                        ERROR('QC has been approved for the Item No. %1 in PO No. %2', "Item No.", "Order No.");
                END;
            end;
        }
        field(9; "Qty to Approve"; Decimal)
        {
        }
        field(10; Description; Text[50])
        {
        }
        field(11; "Typical Value"; Text[30])
        {
        }
        field(12; Rejected; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Order No.", "Line No.", Parameter)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchaseLine: Record 39;
        QCTestResult: Record 50002;
}


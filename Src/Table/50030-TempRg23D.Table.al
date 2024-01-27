table 50030 "Temp Rg 23 D"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Location Code"; Code[10])
        {
        }
        field(3; "Item No."; Code[10])
        {
        }
        field(4; "Lot No."; Code[10])
        {
        }
        field(5; "Item Description"; Text[60])
        {
        }
        field(6; "Product Category"; Code[10])
        {
        }
        field(7; "Excise Chapter"; Code[10])
        {
        }
        field(8; "Pack Size"; Code[10])
        {
        }
        field(9; "Unit Of Measurement"; Decimal)
        {
        }
        field(10; Type; Code[10])
        {
        }
        field(11; "BRT No."; Code[20])
        {
        }
        field(12; "BRT Date"; Date)
        {
        }
        field(13; "TRR No."; Code[20])
        {
        }
        field(14; "TRR Date"; Date)
        {
        }
        field(15; "Supply Location Code"; Code[10])
        {
        }
        field(16; "Inward Quantity"; Decimal)
        {
        }
        field(17; "Opening Qty in Lt/Kg"; Decimal)
        {
        }
        field(18; "Addition For period"; Decimal)
        {
        }
        field(19; "Inward Qty in Lt/Kg"; Decimal)
        {
        }
        field(20; "Transfer Price per Lt/Kg"; Decimal)
        {
        }
        field(21; "Transfer Value"; Decimal)
        {
        }
        field(22; "Inward Rate of ED"; Decimal)
        {
        }
        field(23; "Inward BED"; Decimal)
        {
        }
        field(24; "Inward eCess"; Decimal)
        {
        }
        field(25; "Inward SHE Cess"; Decimal)
        {
        }
        field(26; "Inward Total Excise Duty"; Decimal)
        {
        }
        field(27; "Invoice No."; Code[20])
        {
        }
        field(28; "Invoice Date"; Date)
        {
        }
        field(29; "Party Code"; Code[20])
        {
        }
        field(30; "Outward No of Packs"; Decimal)
        {
        }
        field(31; "Outward Qty"; Decimal)
        {
        }
        field(32; MRP; Decimal)
        {
        }
        field(33; "Outward Rate"; Decimal)
        {
        }
        field(34; "Sales Value"; Decimal)
        {
        }
        field(35; "Outward Excise %"; Decimal)
        {
        }
        field(36; "Outward BED"; Decimal)
        {
        }
        field(37; "Outward eCess"; Decimal)
        {
        }
        field(38; "Outward SHE Cess"; Decimal)
        {
        }
        field(39; "Outward Total Excise"; Decimal)
        {
        }
        field(40; "Adjustment From BRT"; Decimal)
        {
        }
        field(41; "Adjusted From Differencial Dut"; Decimal)
        {
        }
        field(42; "Excise Duty Recoverable"; Decimal)
        {
        }
        field(43; "Plant Location"; Code[10])
        {
        }
        field(44; "Closing Balance"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Location Code", "Item No.", "Lot No.", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}


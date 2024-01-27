table 50043 "Multiple Details E-way Bill"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "EWB No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Group No."; Text[30])
        {
        }
        field(4; "Vehicle No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Trans Doc No."; Code[20])
        {
        }
        field(6; "Trans Doc Date"; Text[30])
        {
        }
        field(7; Quantity; Text[30])
        {
        }
        field(8; "Veh Added Date"; Text[30])
        {
        }
        field(9; "New Vehicle No."; Code[20])
        {
        }
        field(10; "Reason Code"; Text[100])
        {
        }
        field(11; "From Place"; Text[30])
        {
        }
        field(12; "Old Vehicle No."; Code[20])
        {
        }
        field(13; "Old Tran No."; Code[20])
        {
        }
        field(14; "New Tran No."; Code[20])
        {
        }
        field(15; "From State"; Text[30])
        {
        }
        field(16; "Reason Rem"; Text[30])
        {
        }
        field(17; "To State"; Text[30])
        {
        }
        field(18; "To Place"; Text[30])
        {
        }
        field(19; "Tr Mode"; Text[30])
        {
        }
        field(20; "Total Qty"; Text[30])
        {
        }
        field(21; "Unit Code"; Text[30])
        {
        }
        field(22; "EWB Creation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Created By User"; Code[110])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "VH Valid Upto"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "VH Updated Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Created Date"; Date)
        {
        }
        field(28; "EWB Valid Upto"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "EWB Updated Date"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "EWB No.", "Group No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


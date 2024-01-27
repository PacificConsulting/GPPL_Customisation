table 50044 "Detailed E-Way Bill"
{
    DrillDownPageID = 50015;
    LookupPageID = 50015;

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
        field(3; "EWB Valid Upto"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "EWB Updated Date"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Cons. EWB No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cons. EWB Updated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Cons. EWB Valid Upto"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Cancel Date"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "EWB Creation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Created By User"; Code[110])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Vehicle No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "VH Valid Upto"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "VH Updated Date"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "GST Ledg. Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Group No"; Text[30])
        {
        }
        field(17; "Created Date"; Date)
        {
        }
        field(18; "Vehicle Created DateTime"; DateTime)
        {
        }
        field(19; CharA; Code[10])
        {
        }
        field(20; CharB; Code[10])
        {
        }
        field(21; CharC; Code[10])
        {
        }
        field(22; Value; Code[3])
        {
        }
        field(23; Encoding; Code[20])
        {
        }
        field(24; Barcode; BLOB)
        {
        }
        field(25; "Transporter Code"; Code[20])
        {
        }
        field(26; "Transporter Name"; Text[100])
        {
        }
        field(27; "Trans. Doc. No."; Code[20])
        {
        }
        field(28; "Trans. Doc. Date"; Text[15])
        {
        }
        field(29; "From Place"; Text[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "EWB No.", CharA, "Vehicle No.", "Transporter Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


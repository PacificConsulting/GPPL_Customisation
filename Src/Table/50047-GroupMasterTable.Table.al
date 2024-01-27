table 50047 "Group Master Table"
{
    // 
    // Date        Version      Remarks
    // .....................................................................................
    // 16May2018   RB-N         New Table for Customer| Vendor Grouping

    DrillDownPageID = 50129;
    LookupPageID = 50129;

    fields
    {
        field(1; Type; Option)
        {
            Editable = true;
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(2; "Group Code"; Code[10])
        {
            Caption = 'Group Code';
        }
        field(3; "Group Name"; Text[50])
        {
        }
        field(4; "Insurance Limit"; Decimal)
        {
        }
        field(5; "Management Limit"; Decimal)
        {
        }
        field(6; "Temporary Limit"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Type, "Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


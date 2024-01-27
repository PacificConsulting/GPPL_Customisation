table 50015 "Item Version Parameters-Result"
{
    LookupPageID = 50032;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(2; "Version Code"; Code[10])
        {
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Item No."));
        }
        field(3; Parameter; Code[50])
        {
            TableRelation = "QC Item Parameter";
        }
        field(4; "Typical Value"; Code[120])
        {
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Item No."));
        }
        field(10; "Min Value"; Code[30])
        {
        }
        field(11; "Max Value"; Code[30])
        {
        }
        field(20; Mandatory; Boolean)
        {
        }
        field(21; Result; Code[100])
        {
        }
        field(22; "Posting Date"; Date)
        {
        }
        field(23; "Batch No./DC No"; Code[30])
        {
        }
        field(24; "Testing Method"; Code[50])
        {
        }
        field(25; "Blend Order No"; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(26; "Tested By"; Text[100])
        {
        }
        field(27; "QC Test Report Generated"; Boolean)
        {
        }
        field(28; "Approved By"; Code[20])
        {
        }
        field(29; "Test Result Approved"; Boolean)
        {
            Editable = true;
        }
        field(31; "Line No."; Integer)
        {
        }
        field(32; Remarks; Text[250])
        {
        }
        field(33; "Remarks 1"; Text[250])
        {
        }
        field(35; "Certificate No."; Code[20])
        {
        }
        field(50000; "Item Description"; Text[50])
        {
            Description = 'EBT STIVAN (11072012)';
        }
    }

    keys
    {
        key(Key1; "Item No.", Parameter, "Testing Method", "Blend Order No", "Version Code")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Version Code", "Line No.", Parameter, "Blend Order No")
        {
        }
        key(Key3; "Item No.", "Version Code", "Line No.", Parameter, "Batch No./DC No")
        {
        }
        key(Key4; "Item No.", "Version Code", "Batch No./DC No", "Line No.")
        {
        }
        key(Key5; "Item No.", "Version Code", Parameter, "Testing Method", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}


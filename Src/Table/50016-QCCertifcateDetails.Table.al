table 50016 "QC Certifcate Details"
{
    DrillDownPageID = 50035;
    LookupPageID = 50035;

    fields
    {
        field(1; "Certificate No."; Code[20])
        {
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                recITEM.GET("Item No.");
                "Item Description" := recITEM.Description;
            end;
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Batch No."; Code[20])
        {
        }
        field(5; "Blend Order No."; Code[20])
        {
        }
        field(6; "Item Description"; Text[50])
        {
            Description = 'EBT STIVAN 09112012';
        }
        field(7; "Location Code"; Code[10])
        {
            Description = 'EBT STIVAN 11042013';
        }
        field(8; "Tentative Batch No."; Code[20])
        {
            Description = 'EBT STIVAN 25072013';
        }
    }

    keys
    {
        key(Key1; "Certificate No.", "Item No.", "Blend Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        recITEM: Record 27;
}


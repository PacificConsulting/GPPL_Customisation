table 50035 "Purch. Order Comment Master"
{
    Caption = 'Purch. Order Comment Master';
    DrillDownPageID = 50057;
    LookupPageID = 50057;
    Permissions = TableData 50035 = rimd;

    fields
    {
        field(1; "Record ID"; Integer)
        {
        }
        field(2; Comment; Text[240])
        {
        }
    }

    keys
    {
        key(Key1; "Record ID", Comment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        //>>11July2017 DeletePermission

        IF (USERID <> 'GPUAE\UNNIKRISHNAN.VS') OR (USERID <> 'GPUAE\KAUSTUBH.PARAB') THEN
            ERROR('You dont have permission to delete "Purchase Order Comment Master"');

        //<<11July2017 DeletePermission
    end;
}


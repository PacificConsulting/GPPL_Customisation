tableextension 50002 "Salesperson/PurchaserExTCustm" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; BlockedC; Boolean)
        {
            Description = 'EBT STIVAN (07/06/2013) - For Filtertation Purpose in Card and List Form';
        }
        field(50001; "Region Head Code"; Code[20])
        {
            Description = 'RB-N  28Jun2018';
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50002; "Region Code"; Code[10])
        {
            Description = 'RB-N 19Jun2019';
        }
        field(50003; "Zone Code"; Code[10])
        {
            Description = 'RSPLSUM 16Apr2020';
        }
        field(50004; HOD; Code[20])
        {
            Description = 'RSPLSUM 14Jan21';
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50005; L1; Code[20])
        {
            Description = 'RSPLSUM 22Jan21';
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50350; "RWR Parent"; Boolean)
        {
            Description = 'YSR30847';
        }
        field(50351; "Parent RWR Code"; Code[100])
        {
            Caption = 'Parent RWR';
            Description = 'YSR30847';
            TableRelation = "Salesperson/Purchaser".Code WHERE("RWR Parent" = FILTER('Yes'));

            trigger OnValidate()
            begin
                IF "RWR Parent" THEN
                    ERROR('');
            end;
        }
    }

}
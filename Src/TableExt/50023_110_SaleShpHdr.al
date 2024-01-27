tableextension 50023 SalesShpHdrExtcutm extends 110
{
    fields
    {
        field(50001; "Full Name"; Text[100])
        {
            Description = 'RSPLSUM 28Jun2020 length changed from 60 to 100';
        }
        field(50025; "Driver's Name"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50026; "Driver's License No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50027; "Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50028; "Vehicle Capacity"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50029; "Vehicle For Location"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha, RSPLSUM 28Jun2020 field disabled and incorporated in Full Name';
            Enabled = false;
        }
        field(50030; "Transport Type"; Option)
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
            OptionCaption = ' ,Intercity,Local+Intercity,Cust.Transport';
            OptionMembers = " ",Intercity,"Local+Intercity","Cust.Transport";
        }
        field(50031; "Local Driver's Name"; Text[50])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50032; "Local Driver's License No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50033; "Local Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50034; "Local Vehicle Capacity"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50035; "Local Vehicle for Location"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha, RSPLSUM 28Jun2020 field disabled and incorporated in Full Name';
            Enabled = false;
        }
        field(50036; "Local Vehicle No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50037; "Local LR No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50038; "Local LR Date"; Date)
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50114; "CT3 Order"; Boolean)
        {

            trigger OnValidate()
            begin
                //EBT Paramita
                IF "CT3 Order" THEN BEGIN
                    IF "CT1 Order" THEN
                        ERROR('U cannot select CT3 And CT1 both');
                END;
                //EBT Paramita
            end;
        }
        field(50115; "CT3 No."; Code[20])
        {
        }
        field(50116; "CT3 Date"; Date)
        {
        }
        field(50117; "ARE3 No."; Code[20])
        {
        }
        field(50118; "ARE3 Date"; Date)
        {
        }
        field(50120; "CT1 Order"; Boolean)
        {

            trigger OnValidate()
            begin
                //EBT Paramita
                IF "CT1 Order" THEN BEGIN
                    IF "CT3 Order" THEN
                        ERROR('U cannot select CT1 And CT3 both');
                END;
                //EBT Paramita
            end;
        }
        field(50121; "CT1 No."; Code[20])
        {
        }
        field(50122; "CT1 Date"; Date)
        {
        }
        field(50123; "ARE1 No."; Code[20])
        {
        }
        field(50124; "ARE1 Date"; Date)
        {
        }
        field(50131; "Ex-Factory"; Text[20])
        {
            Description = '//RSPL-Rahul';
        }
        field(50150; "Under Rebate"; Boolean)
        {
        }
        field(50151; "Under LUT"; Boolean)
        {
            Editable = true;
        }
        field(50152; "Export Under Rebate"; Text[30])
        {
        }
        field(50153; "Export Under LUT"; Text[30])
        {
        }
        field(50170; "Credit Limit Approval"; Option)
        {
            Description = 'RSPL022 - Credit Limit Approval';
            Editable = false;
            OptionCaption = 'Open,Pending for Credit Approval,Approved';
            OptionMembers = Open,"Pending for Credit Approval",Approved;
        }
        field(50181; "Get Entry Outward"; Code[20])
        {
            Description = 'NB28902';
        }
        field(59995; "Road Permit No."; Code[20])
        {
            Description = 'EBT STIVAN (11-12-2012)';
        }
        field(60299; "Freight Type"; Option)
        {
            Description = 'EBT STIVAN (12-06-2013)';
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP";
        }
        field(60300; "Freight Charges"; Code[20])
        {
        }
        field(70002; "Sales Invoice No"; Code[20])
        {
            Description = 'EBT MILAN (30-07-2013)';
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(70050; "Cash Discount Percentage"; Decimal)
        {
            Description = 'EBT';
        }
        field(70059; "Sales Order No"; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));
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
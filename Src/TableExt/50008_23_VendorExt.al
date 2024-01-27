tableextension 50008 VendorExtCustm extends Vendor
{
    fields
    {
        field(50001; "Full Name"; Text[60])
        {
        }
        field(50002; "Creation Date"; Date)
        {
            Description = 'EBT 0001';
            Editable = false;
        }
        field(50003; "Shipping Agent"; Boolean)
        {
            Description = 'EBT/LR/0001';

            trigger OnValidate()
            begin
                //EBT/LR/0001
                IF NOT "Shipping Agent" THEN
                    IF "Shipping Agent Code" <> '' THEN
                        ERROR('Shipping Agent Code has been defined for this Vendor. First delete the Shipping Agent.');
                //EBT/LR/0001
            end;
        }
        field(50004; "TDS not Applicable"; Boolean)
        {
            Description = 'EBT Stivan 03/10/2012';
        }
        field(50005; "Agent Required"; Boolean)
        {
            Description = 'EBT - PRATYUSHA - CUST-COMM';
        }
        field(50006; "W.e.f. Date(T.I.N No.)"; Date)
        {
            Description = 'RSPL 251114';
        }
        field(50007; "W.e.f. Date(C.S.T No.)"; Date)
        {
            Description = 'RSPL 251114';
        }
        field(50008; "MSME Status"; Option)
        {
            Description = 'RB-N  14Feb2019';
            OptionCaption = ' ,Micro Industries,Small Scale Industries,Medium Scale Industries,Non MSME';
            OptionMembers = " ","Micro Industries","Small Scale Industries","Medium Scale Industries","Non MSME";

            trigger OnValidate()
            begin

                //>>14Feb2019
                IF "MSME Status" = "MSME Status"::" " THEN
                    "MSME Registration No." := '';

                IF "MSME Status" = "MSME Status"::"Non MSME" THEN
                    "MSME Registration No." := '';
                //<<14Feb2019
            end;
        }
        field(50009; "MSME Registration No."; Code[15])
        {
        }
        field(50010; "Vendor Group Code"; Code[20])
        {
            Description = 'RSPLSUM 20May2020';
            TableRelation = "Group Master Table"."Group Code" WHERE(Type = CONST(Vendor));
        }
        field(50011; "IRN Applicable"; Boolean)
        {
            Description = 'RSPLSUM 07Jan21';
        }
        field(50012; "Exclude From Bal Confir Mail"; Boolean)
        {
            Caption = 'Exclude From Balance Confirmation Mail';
            Description = 'AM31267';
        }
        field(50300; "ITR filled for last 02 years"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
        }
        field(50301; "Linking of Aadhaar with PAN"; Option)
        {
            Description = 'robotdssid';
            OptionCaption = ' ,Yes,No,Not Applicable';
            OptionMembers = " ",Yes,No,"Not Applicable";
        }
        field(50302; "L.S.T. No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Rec.Validate("Creation Date", Today);
    end;



    var
        myInt: Integer;
}
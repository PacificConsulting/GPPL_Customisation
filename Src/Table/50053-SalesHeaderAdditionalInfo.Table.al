table 50053 "Sales Header - Additional Info"
{
    Caption = 'Sales Header - Additional Info';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Vessel Code"; Code[10])
        {
            TableRelation = "Vessel Master"."Vessel Code";
        }
        field(4; "Vessel Name"; Text[50])
        {
            CalcFormula = Lookup("Vessel Master"."Vessel Name" WHERE("Vessel Code" = FIELD("Vessel Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Port Code"; Code[10])
        {
            TableRelation = "Port Master".Code;
        }
        field(6; "Port Description"; Text[50])
        {
            CalcFormula = Lookup("Port Master"."Port Description" WHERE(Code = FIELD("Port Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Location (of Port)"; Option)
        {
            OptionCaption = ' ,Berth,Inner Anchorage,Outer Anchorage,OPL,BFL';
            OptionMembers = " ",Berth,"Inner Anchorage","Outer Anchorage",OPL,BFL;
        }
        field(8; "Trade Terms"; Text[30])
        {
        }
        field(9; "Agent Code"; Code[20])
        {
        }
        field(10; "Load Port"; Code[10])
        {
            TableRelation = "Port Master";
        }
        field(11; "Discharge Port"; Code[10])
        {
            TableRelation = "Port Master";
        }
        field(12; "Nature of Sale"; Option)
        {
            OptionCaption = ' ,Physical,Back to Back (B2B),Other';
            OptionMembers = " ",Physical,"Back to Back (B2B)",Other;
        }
        field(13; "Shipping Bill No"; Text[30])
        {
        }
        field(14; "Shipping Bill  Date"; Date)
        {
        }
        field(15; "B/L No."; Text[30])
        {
        }
        field(16; "B/L Date"; Date)
        {
        }
        field(17; "BDN No."; Text[20])
        {
        }
        field(18; "BDN Date"; Date)
        {
        }
        field(19; "Advance Receipt No"; Code[20])
        {
        }
        field(20; "Buyer's Order No"; Code[20])
        {
        }
        field(21; "Buyer's Order Date"; Date)
        {
        }
        field(22; "Terms Of Delivery"; Option)
        {
            OptionMembers = " ",Truck,Barge;
        }
        field(24; "BOE No."; Code[20])
        {
        }
        field(25; "Port Location Name"; Option)
        {
            OptionMembers = " ",Berth,Anchorage;
        }
        field(26; "Pricing Type"; Option)
        {
            OptionMembers = ,DELIVERED,Extank;
        }
        field(27; "ID Card Number"; Code[10])
        {
        }
        field(28; "Seal Number"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


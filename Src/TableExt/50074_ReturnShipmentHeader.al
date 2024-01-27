tableextension 50074 ReturnShipmentHeaderExtcstm extends "Return Shipment Header"
{
    fields
    {
        field(50001; "Full Name"; Text[60])
        {
        }
        field(50008; "User City"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Form Update sales Invoice";
        }
        field(50009; "User State"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = State;
        }
        field(50010; "User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(60008; "Gate Pass"; Boolean)
        {
            Description = '17Mar2019  OGP';
            Editable = false;
        }
        field(60009; "Gate Pass Status"; Option)
        {
            Description = '17Mar2019  OGP';
            Editable = false;
            OptionCaption = ' ,Returnable,Non-Returnable';
            OptionMembers = " ",Returnable,"Non-Returnable";
        }
        field(60010; "Mode of Transport"; Option)
        {
            Description = '17Mar2019  OGP';
            Editable = false;
            OptionCaption = ' ,By Air,By Cargo,By Courier,By H.O Mail,By Hand Carry';
            OptionMembers = " ","By Air","By Cargo","By Courier","By H.O Mail","By Hand Carry";
        }
        field(60011; "Requestor's Dept"; Text[30])
        {
            Description = '17Mar2019  OGP';
            Editable = false;
        }
        field(60012; "Return Material Date"; Date)
        {
            Description = '17Mar2019  OGP';
            Editable = false;
        }
        field(60013; "Purpose of GatePass"; Text[30])
        {
            Description = '17Mar2019  OGP, RSPLSUM 29Jul2020 length changed from 80 to 30';
            Editable = false;
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
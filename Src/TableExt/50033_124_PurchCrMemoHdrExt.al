tableextension 50033 PurchCrMemoHdrExtcutm extends 124
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
            TableRelation = State;//Azhar Pending
        }
        field(50010; "User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50054; "Order Creation Date"; Date)
        {
            Description = 'EBT MILAN (280114) - Flowed from Blenket Order Todays Date';
        }
        field(50055; "Freight Type"; Option)
        {
            Description = 'EBT MILAN 280114 Should flow from Blnket to order';
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP";
        }
        field(50056; "Exp. TPT Cost"; Decimal)
        {
            Description = 'EBT MILAN (280114) - Flowed from Blenket Order Todays Date';
        }
        field(50291; "E-Inv Irn"; Text[70])
        {
            // Azhar Pending CalcFormula = Lookup("GST Ledger Entry"."E-Inv Irn" WHERE ("Transaction Type"=CONST('Purchase'),
            //                                                            "Document No."=FIELD("No."),
            //                                                            "Document Type"=CONST('Credit Memo')));
            Description = 'RSPL_28117_AviMali_11122020_EINV';
            Editable = false;
            //FieldClass = FlowField;
        }
        // field(50360; "E-Way Bill No."; Code[20])
        // {
        //     //Azhar Pending CalcFormula = Lookup("GST Ledger Entry"."E-Way Bill No." WHERE("Document No."=FIELD("No."),
        //     //                                                                 "Transaction Type"=CONST('Purchase'),
        //     //                                                                 "Document Type"=CONST('Credit Memo')));
        //     Description = 'ysrEWB';
        //     Editable = true;
        //     //FieldClass = FlowField;
        // }
        field(50361; "QR Code"; BLOB)
        {
            Description = 'RSPL_28117_AviMali_11122020_EINV';
        }
        field(60001; Remarks; Text[120])
        {
            Description = 'Pratyusha-flowed to Shipping Documents.';
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
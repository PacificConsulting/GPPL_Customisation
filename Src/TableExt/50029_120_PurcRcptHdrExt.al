tableextension 50029 PurchaseRcpHdrExtCutm extends 120
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
            TableRelation = State; //Azhar Pending
        }
        field(50010; "User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50020; "Closed GRN"; Boolean)
        {
            Description = 'EBT STIVAN 10/10/2012 - For Reporting Level Purpose';
        }
        field(50030; "Blanket Order No."; Code[20])
        {
            Description = 'EBT 0003';
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
        field(60001; Remarks; Text[40])
        {
            Description = 'Pratyusha-flowed to Shipping Documents.,RSPLSUM 15Apr2020 length changed from 120 to 40';
        }
        field(60006; "Work Order"; Boolean)
        {
            Description = '10Apr2018 WorkOrderProcess';
            Editable = false;
        }
        field(60029; "Vessel Code"; Code[10])
        {
            Description = 'RSPLSUM 29Jul2020';
            Editable = false;
            TableRelation = "Vessel Master"."Vessel Code";
        }
        field(60030; "Vessel Name"; Text[50])
        {
            CalcFormula = Lookup("Vessel Master"."Vessel Name" WHERE("Vessel Code" = FIELD("Vessel Code")));
            Description = 'RSPLSUM 29Jul2020';
            Editable = false;
            FieldClass = FlowField;
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
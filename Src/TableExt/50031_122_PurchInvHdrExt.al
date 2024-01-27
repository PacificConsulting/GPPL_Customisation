tableextension 50031 PurinvhdrExtcutm extends 122
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
        field(50017; "Handover Date"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50018; "Handover To"; Text[30])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50019; "Date of Receipt"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50020; "Date of Issue"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50021; "Total No. of Invoices"; Code[10])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50022; "Period Form"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50023; "Period To"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50024; "Form Issued Amount"; Decimal)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50025; "Form Issued No."; Code[20])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form --> Length Changed from 10 to 20';
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
        field(60007; "Invoice Received By Finance"; Date)
        {
            Description = '14May2018';
            Editable = false;
        }
        field(60024; "Department Code"; Option)
        {
            Description = 'RSPLSUM 14Apr2020';
            Editable = false;
            OptionCaption = ' ,Material,Administration,Travel Desk,HR,IT,Company Secretory,Accounts,Marketing,Plant - Maintenance,Plant - Admin,R&D and QC,SCM';
            OptionMembers = " ",Material,Administration,"Travel Desk",HR,IT,"Company Secretory",Accounts,Marketing,"Plant - Maintenance","Plant - Admin","R&D and QC",SCM;
        }
        field(60025; "Deal Sheet No."; Text[20])
        {
            Description = 'RSPLSUM 15Apr2020';
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
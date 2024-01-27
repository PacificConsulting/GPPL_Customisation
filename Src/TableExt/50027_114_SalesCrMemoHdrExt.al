tableextension 50027 SalesCrmemoHdrExtCutm extends 114
{
    fields
    {
        field(50001; "Full Name"; Text[100])
        {
            Description = 'RSPLSUM 28Jun2020 length changed from 60 to 100';
        }
        field(50005; "Cancelled Invoice"; Boolean)
        {
            Description = 'EBT/CANINV/0001';
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
        field(50130; FOC; Boolean)
        {
            Description = 'RSPL/CUST/FOC/RET001';
        }
        field(50131; "Ex-Factory"; Text[20])
        {
            Description = 'RSPL-Rahul';
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
        // field(50217; "QR code"; BLOB)
        // {
        //     Description = 'RSPL-AD-EWB';
        // }
        field(59995; "Road Permit No."; Code[20])
        {
            Description = 'EBT STIVAN (11-12-2012)';
        }
        field(60000; "Last Year Sales Return"; Boolean)
        {
            Description = 'EBT0002';
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
        field(70050; "Cash Discount Percentage"; Decimal)
        {
            Description = 'EBT';
        }
        field(70064; IRN; Text[250])
        {
            // CalcFormula = Lookup("GST Ledger Entry"."E-Inv Irn" WHERE ("Transaction Type"=CONST('Sales'),
            //                                                            "Document No."=FIELD("No."),
            //                                                            "Document Type"=CONST('Credit Memo')));Azhar Pending
            Description = 'RSPLSID 01Sept2020';
            Editable = false;
            //FieldClass = FlowField;
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
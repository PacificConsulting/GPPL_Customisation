table 50020 "Transport Details"
{
    // //RSPL-CAS-06789-V4F4X7       Nikhil    Code added to calculate deductions
    // //RSPL-CAS-07045-Y1L4CB       Nikhil    Code added to Calculate Qty In Ltrs and KGS

    DrillDownPageID = 50056;
    LookupPageID = 50070;

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
        }
        field(2; "Invoice Date"; Date)
        {
            Editable = false;
        }
        field(3; "LR No."; Code[20])
        {
            Editable = false;
        }
        field(4; "LR Date"; Date)
        {
            Editable = false;
        }
        field(5; "Vehicle No."; Code[20])
        {
            Editable = false;
        }
        field(6; "From Location Code"; Code[20])
        {
            Editable = false;
            TableRelation = Location.Code;
        }
        field(7; "From Location Name"; Text[50])
        {
            Editable = false;
        }
        field(8; Destination; Code[50])
        {
            Description = 'RB-N  26Jun2019 Old Value 35';
            Editable = false;
        }
        field(9; "Vendor Code"; Code[10])
        {
            Editable = true;
            TableRelation = Vendor."No.";
        }
        field(10; "Vendor Name"; Text[50])
        {
            Editable = true;
        }
        field(11; "Shipping Agent Code"; Code[10])
        {
            Editable = true;
            TableRelation = "Shipping Agent".Code;
        }
        field(12; "Shipping Agent Name"; Text[50])
        {
            Editable = true;
        }
        field(13; "TPT Invoice No."; Code[30])
        {
        }
        field(14; "TPT Invoice Date"; Date)
        {
        }
        field(15; "TPT Type"; Option)
        {
            OptionMembers = " ","16 KL","18 KL";
        }
        field(16; "Expected TPT Cost"; Decimal)
        {
            Editable = false;
        }
        field(17; Quantity; Decimal)
        {
            Editable = false;
        }
        field(18; Rate; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //"Passed Amount" := Quantity * Rate;
            end;
        }
        field(19; "Passed Amount"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                "Total Amount" := "Passed Amount" + "Other Charges";
                //RSPL-Sourav111214
                IF ("Total Amount" > 0) OR ("Total Amount-Local" > 0) THEN
                    "Entry Date" := WORKDATE;
                //RSPL-Sourav111214


                //RSPL-CAS-06789-V4F4X7
                Deductions := 0;
                IF ("Passed Amount" <> 0) AND ("Bill Amount" <> 0) THEN
                    Deductions := "Passed Amount" - "Bill Amount";
                //RSPL-CAS-06789-V4F4X7
            end;
        }
        field(20; "To Location Code"; Code[20])
        {
            Editable = false;
            TableRelation = Location.Code;
        }
        field(21; "To Location Name"; Text[50])
        {
            Editable = false;
        }
        field(22; "Freight Type"; Option)
        {
            Editable = true;
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP";
        }
        field(23; "Bill Amount"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                //RSPL-Sourav111214
                IF ("Total Amount" > 0) OR ("Total Amount-Local" > 0) THEN
                    "Entry Date" := WORKDATE;
                //RSPL-Sourav111214

                //RSPL-CAS-06789-V4F4X7
                Deductions := 0;
                IF ("Passed Amount" <> 0) AND ("Bill Amount" <> 0) THEN
                    Deductions := "Passed Amount" - "Bill Amount";
                //RSPL-CAS-06789-V4F4X7
            end;
        }
        field(24; Open; Boolean)
        {
        }
        field(25; Applied; Boolean)
        {
        }
        field(26; "Applied Document No."; Code[20])
        {
            Editable = true;
        }
        field(27; "Applied Date"; Date)
        {
            Editable = true;
        }
        field(28; Posted; Boolean)
        {
            Editable = true;
        }
        field(29; "Cancelled Invoice"; Boolean)
        {
            Editable = true;
        }
        field(30; "Local LR No."; Code[20])
        {
            Editable = false;
        }
        field(31; "Local LR Date"; Date)
        {
            Editable = false;
        }
        field(32; "Local Vehicle No."; Code[20])
        {
            Editable = false;
        }
        field(33; "Local Shipment Agent Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Shipping Agent".Code;
        }
        field(34; "Local Shipment Agent Name"; Text[50])
        {
            Editable = false;
        }
        field(35; "Local Expected TPT Cost"; Decimal)
        {
            Editable = false;
        }
        field(36; "Local TPT Bill Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                //RSPL-Sourav111214
                IF ("Total Amount" > 0) OR ("Total Amount-Local" > 0) THEN
                    "Entry Date" := WORKDATE;
                //RSPL-Sourav111214
            end;
        }
        field(37; "Local TPT Passed Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Amount-Local" := "Local TPT Passed Amount" + "Other Charges-Local";
                //RSPL-Sourav111214
                IF ("Total Amount" > 0) OR ("Total Amount-Local" > 0) THEN
                    "Entry Date" := WORKDATE;
                //RSPL-Sourav111214
            end;
        }
        field(38; "Local TPT Invoice No."; Code[30])
        {
        }
        field(39; "Local TPT Invoice Date"; Date)
        {
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(41; UOM; Text[20])
        {
            Editable = false;
        }
        field(42; Type; Option)
        {
            Editable = false;
            OptionMembers = Invoice,Transfer,Purchase;
        }
        field(43; "Vehicle Capacity"; Text[30])
        {
            Editable = false;
        }
        field(44; "Local Vehicle Capacity"; Text[30])
        {
            Editable = false;
        }
        field(45; "Customer Name"; Text[60])
        {
            Editable = false;
        }
        field(46; "Blanket Order/ Shipment No."; Code[20])
        {
            Description = 'EBT MILAN 070214';
            Editable = false;
        }
        field(47; "Other Charges"; Decimal)
        {
            Description = 'EBT Deepika 220514';

            trigger OnValidate()
            begin
                "Total Amount" := "Passed Amount" + "Other Charges";
                //RSPL-Sourav111214
                IF ("Total Amount" > 0) OR ("Total Amount-Local" > 0) THEN
                    "Entry Date" := WORKDATE;
                //RSPL-Sourav111214
            end;
        }
        field(48; "Other Charges-Local"; Decimal)
        {
            Description = 'EBT Deepika 220514';

            trigger OnValidate()
            begin
                "Total Amount-Local" := "Local TPT Passed Amount" + "Other Charges-Local";
                //RSPL-Sourav111214
                IF ("Total Amount" > 0) OR ("Total Amount-Local" > 0) THEN
                    "Entry Date" := WORKDATE;
                //RSPL-Sourav111214
            end;
        }
        field(49; "Total Amount"; Decimal)
        {
            Description = 'EBT Deepika 220514';
        }
        field(50; "Total Amount-Local"; Decimal)
        {
            Description = 'EBT Deepika 220514';
        }
        field(50050; "Type of Vehicle"; Option)
        {
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,Tanker,Truck,Tempo,Export,Others';
            OptionMembers = " ",Tanker,Truck,Tempo,Export,Others;
        }
        field(50051; "Category of Tanker 1"; Option)
        {
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,SS,MS';
            OptionMembers = " ",SS,MS;
        }
        field(50052; "Category of Tanker 2"; Option)
        {
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,Insulated,Non-Insulated';
            OptionMembers = " ",Insulated,"Non-Insulated";
        }
        field(50053; "Category of Tanker 3"; Option)
        {
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,With Pump,W/O Pump';
            OptionMembers = " ","With Pump","W/O Pump";
        }
        field(50054; "Category of Tanker 4"; Option)
        {
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,With Compartment,W/O Compartment';
            OptionMembers = " ","With Compartment","W/O Compartment";
        }
        field(50055; "Type of Truck"; Option)
        {
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,Full Body Type,Half Body Type,Container Type';
            OptionMembers = " ","Full Body Type","Half Body Type","Container Type";
        }
        field(50056; "Entry Date"; Date)
        {
            Description = 'RSPL SOURAV 111214';
        }
        field(50057; Reason; Text[250])
        {
            Description = 'RSPL SOURAV 230115';
        }
        field(50058; "TPT Invoice Receipt Date"; Date)
        {
            Description = 'RSPL CAS-06245-R5W6T5';
        }
        field(50059; Deductions; Decimal)
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
            Editable = false;
        }
        field(50060; "Total Quantity in(Kg)"; Decimal)
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
            Editable = false;
        }
        field(50061; "Quantity in Ltrs."; Decimal)
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
            Editable = false;
        }
        field(50062; "Quantity in KGS"; Decimal)
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
            Editable = false;
        }
        field(50063; "Total Packing Material Weight"; Decimal)
        {
            Description = 'RSPL-CAS-07525-J5Y1V1';
            Editable = false;
            FieldClass = Normal;
        }
        field(50064; "Grand Total"; Decimal)
        {
            Description = 'RSPL-CAS-07525-J5Y1V1';
        }
        field(50065; "Additional Weight"; Decimal)
        {
            Description = 'RSPL-CAS-07525-J5Y1V1';
        }
        field(50066; "No. of Packs"; Decimal)
        {
            Description = 'RB-N 14Nov2017';
            Editable = false;
        }
        field(50067; "Vehicle Capacity Gate Entry"; Text[30])
        {
            Description = 'RB-N 14Nov2017';
            Editable = false;
        }
        field(50068; "Gate Entry No."; Code[20])
        {
            Description = 'RB-N 14Nov2017';
            Editable = false;
        }
        field(50069; "Expected Loading"; Decimal)
        {
            Description = 'RSPLSUM';
            Editable = false;
        }
        field(50070; "Expetced Unloading"; Decimal)
        {
            Description = 'RSPLSUM';
            Editable = false;
        }
        field(50071; "Actual Loading"; Decimal)
        {
            Description = 'RSPLSUM';
        }
        field(50072; "Actual Unloading"; Decimal)
        {
            Description = 'RSPLSUM';
        }
    }

    keys
    {
        key(Key1; "Invoice No.")
        {
            Clustered = true;
        }
        key(Key2; "TPT Invoice No.")
        {
        }
        key(Key3; "Invoice Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('You do not have permission to Delete');
    end;

    var
        RecSalesInvLine: Record 113;
        RecSalesInvHeader: Record 112;
        Var_QtyUom: Decimal;
        RecILE: Record 32;
        RecILE1: Record 32;
        RecSalesShpmntLine: Record 111;
}


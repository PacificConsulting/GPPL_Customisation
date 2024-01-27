tableextension 50085 "PosGatEntrHeaderExtCstm" extends "Posted Gate Entry Header"
{
    fields
    {
        field(50000; Transporter; Code[20])
        {
            Description = 'EBT/Gate Entry/0001';
            TableRelation = "Shipping Agent";
        }
        field(50001; "Driver's Name"; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50002; "Driver's License No."; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50003; "Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50004; "Vehicle Capacity"; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50005; "Vehicle For Location"; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50007; "Releasing Date"; Date)
        {
            Description = 'EBT/Gate Entry/0001';
            Editable = false;
        }
        field(50008; "Releasing Time"; Time)
        {
            Description = 'EBT/Gate Entry/0001';
            Editable = false;
        }
        field(50009; "Total Value"; Decimal)
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50010; "Total Quantity"; Decimal)
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50011; "Transporter Name"; Text[60])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50012; Invoice; Boolean)
        {
            Description = 'EBT/LR/0001';
        }
        field(50013; Invoiced; Boolean)
        {
            Description = 'EBT/LR/0001';
            Editable = false;
        }
        field(50014; "Invoice No."; Code[20])
        {
            Description = 'EBT/LR/0001';
        }
        field(50015; "Out Time"; Time)
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50016; "Vehicle Out"; Boolean)
        {
            Description = 'EBT/Gate Entry/0001';
            Editable = true;
        }
        field(50017; "Out Date"; Date)
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50021; "Created User ID"; Code[25])
        {
            Description = 'EBT MILAN 141013';
        }
        field(50022; "Release User ID"; Code[30])
        {
            Description = 'EBT MILAN 141013';
        }
        field(50023; "Vendor Code"; Code[20])
        {
            Description = 'EBT MILAN 141013';
            TableRelation = Vendor."No.";
        }
        field(50024; Location; Code[20])
        {
            Description = 'EBT MILAN 141013';
            TableRelation = Location.Code;
        }
        field(50025; "Item Code"; Code[20])
        {
            Description = 'EBT MILAN 141013';
            TableRelation = Item."No.";
        }
        field(50026; PUC; Option)
        {
            Description = 'EBT MILAN 141013';
            OptionMembers = " ",YES,NO;
        }
        field(50027; "Vendor Location Gross Weight"; Decimal)
        {
            Description = 'EBT MILAN 141013';
        }
        field(50028; "Vendor Location Tare Weight"; Decimal)
        {
            Description = 'EBT MILAN 141013';
        }
        field(50029; "Vendor Location Net Weight"; Decimal)
        {
            Description = 'EBT MILAN 141013';
        }
        field(50030; "Inhouse Gross Weight"; Decimal)
        {
            Description = 'EBT MILAN 141013';
        }
        field(50031; "Inhouse Tare Weight"; Decimal)
        {
            Description = 'EBT MILAN 141013';
        }
        field(50032; "Inhouse Net Weight"; Decimal)
        {
            Description = 'EBT MILAN 141013';
        }
        field(50033; "Vendor Invoice/Document No."; Code[50])
        {
            Description = 'EBT MILAN 141013 Extend from 20 to 50 on 010114';
        }
        field(50034; "Posted User ID"; Code[50])
        {
            Description = 'EBT MILAN 141013';
        }
        field(50035; "Customer Code"; Code[20])
        {
            Description = 'EBT MILAN 151013';
            TableRelation = Customer."No.";
        }
        field(50036; "Customer Name"; Text[60])
        {
            Description = 'EBT MILAN 151013';
        }
        field(50037; "Vehicle Taken Time"; Time)
        {
            Description = 'EBT MILAN 010114';
            Editable = false;
        }
        field(50038; "Vehicle Taken Date"; Date)
        {
            Description = 'EBT MILAN 010114';
            Editable = false;
        }
        field(50039; "Entry No."; Code[20])
        {
            Description = 'EBT MILAN 010114';
        }
        field(50040; "Vehicle Insurance Date"; Date)
        {
            Description = 'EBT MILAN 010114';
            Editable = false;
        }
        field(50041; "PUC Date"; Date)
        {
            Description = 'EBT MILAN 010114';
            Editable = false;
        }
        field(50042; "Vehicle Taken user ID"; Code[50])
        {
            Description = 'EBT MILAN 140114';
            Editable = false;
        }
        field(50043; "Vehicle Body Height/Length"; Text[15])
        {
            Description = 'EBT MILAN 230114';
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
        field(50056; "Total Qty"; Decimal)
        {
            CalcFormula = Sum("Posted Gate Entry Line".Quantity WHERE("Entry Type" = FIELD("Entry Type"),
                                                                       "Gate Entry No." = FIELD("No.")));
            Description = 'RSPL-CAS-06789-V4F4X7';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Grand Total" := "Total Qty" + "Total Packing Material Weight" + "Additional Weight";
            end;
        }
        field(50057; "Weighment Slip No."; Code[20])
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
        }
        field(50058; "Weighment Qty."; Decimal)
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
        }
        field(50059; "Total Packing Material Weight"; Decimal)
        {
            CalcFormula = Sum("Posted Gate Entry Line"."Packing Material Weight" WHERE("Gate Entry No." = FIELD("No.")));
            Description = 'RSPL-CAS-07525-J5Y1V1';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Grand Total" := "Total Qty" + "Total Packing Material Weight" + "Additional Weight";
            end;
        }
        field(50060; "Grand Total"; Decimal)
        {
            Description = 'RSPL-CAS-07525-J5Y1V1';
        }
        field(50061; "Additional Weight"; Decimal)
        {
            Description = 'RSPL-CAS-07525-J5Y1V1';

            trigger OnValidate()
            begin
                "Grand Total" := "Total Qty" + "Total Packing Material Weight" + "Additional Weight";
            end;
        }
        field(50062; "Check Post"; Text[50])
        {
            Description = 'RB-N 19Dec2017';
            Editable = false;
        }
        field(50063; "Gross Weight"; Decimal)
        {
            Description = 'RB-N 04Sep2018';
            Editable = false;
        }
        field(50064; "Tare Weight"; Decimal)
        {
            Description = 'RB-N 04Sep2018';
            Editable = false;

            trigger OnValidate()
            begin
                //"Net Weight" := "Gross Weight" - "Tare Weight";
            end;
        }
        field(50065; "Net Weight"; Decimal)
        {
            Description = 'RB-N 04Sep2018';
            Editable = false;
        }
        field(50066; "Material Inward No."; Text[15])
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50067; "Helper with Vehicle"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50068; "PPE Available with Driver"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50069; "Invoice Copy Original"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50070; "Invoice Copy DFT"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50071; "E-Way Bill"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50072; "PO Copy/PO Reference"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50073; "Weigh Slip"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50074; "Certificate of Analysis"; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50075; MSDS; Boolean)
        {
            Description = 'RSPLSUM04Mar21';
            Editable = false;
        }
        field(50076; "Remarks 1"; Text[100])
        {
            Description = 'DJ29319';
        }
        field(50077; "Remarks 2"; Text[100])
        {
            Description = 'DJ29319';
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
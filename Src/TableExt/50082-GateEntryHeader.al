tableextension 50082 GateEntryHeader_Ext extends "Gate Entry Header" //pcpl-064 11dec2023
{
    fields
    {
        field(50000; Transporter; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
            TableRelation = "Shipping Agent";
        }
        field(50001; "Driver's Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50002; "Driver's License No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50003; "Driver's Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50004; "Vehicle Capacity"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001 EBT MILAN Changed from Text30 to code20 and table relation with vehicle capacity 06012014';
            TableRelation = "Vehicle Capacity".Code;
        }
        field(50005; "Vehicle For Location"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50006; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
            Editable = false;

        }
        field(50007; "Releasing Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50008; "Releasing Time"; Time)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50009; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50010; "Total Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50011; "Transporter Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT/Gate Entry/0001';
        }
        field(50020; "Short Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 290813';
        }
        field(50021; "Created User ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50022; "Release User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50023; "Vendor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
            TableRelation = Vendor."No.";
        }
        field(50024; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
            Description = 'EBT MILAN 141013';
        }
        field(50025; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
            TableRelation = Item."No.";
        }
        field(50026; PUC; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,YES,NO';
            OptionMembers = " ",YES,NO;
            Description = 'EBT MILAN 141013';
        }
        field(50027; "Vendor Location Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50028; "Vendor Location Tare Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50029; "Vendor Location Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50030; "Inhouse Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50031; "Inhouse Tare Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50032; "Inhouse Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50033; "Vendor Invoice/Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013 Extend from 20 to 50 on 010114';
        }
        field(50034; "Posted User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 141013';
        }
        field(50035; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 151013';
        }
        field(50036; "Customer Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 151013';
        }
        field(50037; "Vehicle Taken Time"; Time)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 010114';
            Editable = false;
        }
        field(50038; "Vehicle Taken Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 010114';
            Editable = false;
        }
        field(50040; "Vehicle Insurance Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 010114';
        }
        field(50041; "PUC Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 010114';
        }
        field(50042; "Vehicle Taken user ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 140114/RSPL-Rahul Size increase from 20';
            Editable = false;
        }
        field(50043; "Vehicle Body Height/Length"; Text[15])
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 230114';
        }
        field(50044; "Once Released"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EBT MILAN 270114 to only editable vehicle detail at reopen document';
        }
        field(50050; "Type of Vehicle"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,Tanker,Truck,Tempo,Export,Others';
            OptionMembers = " ",Tanker,Truck,Tempo,Export,Others;
        }
        field(50051; "Category of Tanker 1"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",SS,MS;
            OptionCaption = ' ,SS,MS';
            Description = 'RSPL SOURAV 111214';
        }
        field(50052; "Category of Tanker 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Insulated,Non-Insulated';
            OptionMembers = " ",Insulated,"Non-Insulated";
            Description = 'RSPL SOURAV 111214';
        }
        field(50053; "Category of Tanker 3"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,With Pump,W/O Pump';
            OptionMembers = " ","With Pump","W/O Pump";
            Description = 'RSPL SOURAV 111214';
        }
        field(50054; "Category of Tanker 4"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,With Compartment,W/O Compartment';
            OptionMembers = " ",,"With Compartment","W/O Compartment";
        }
        field(50055; "Type of Truck"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL SOURAV 111214';
            OptionCaption = ' ,Full Body Type,Half Body Type,Container Type';
            OptionMembers = " ","Full Body Type","Half Body Type","Container Type";
        }
        // field(50056; "Total Qty"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Gate Entry Line".Quantity WHERE("Gate Entry No." = FIELD("No.")));
        //     //DataClassification = ToBeClassified;
        //     Description = 'RSPL-CAS-06789-V4F4X7';
        //     Editable = false;
        // }
        field(50057; "Weighment Slip No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL-CAS-06789-V4F4X7';
        }
        field(50058; "Weighment Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL-CAS-06789-V4F4X7';
        }
        field(50059; "Total Packing Material Weight"; Blob)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL-CAS-07525-J5Y1V1';
        }
        field(50060; "Grand Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL-CAS-07525-J5Y1V1';
        }
        field(50061; "Additional Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPL-CAS-07525-J5Y1V1';
        }
        field(50062; "Check Post"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'RB-N 19Dec2017';
        }
        field(50063; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RB-N 04Sep2018';
        }
        field(50064; "Tare Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RB-N 04Sep2018';
        }
        field(50065; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'RB-N 04Sep2018';
        }
        field(50066; "Material Inward No."; Text[15])
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50067; "Helper with Vehicle"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50068; "PPE Available with Driver"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50069; "Invoice Copy Original"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50070; "Invoice Copy DFT"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50071; "E-Way Bill"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50072; "PO Copy/PO Reference"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50073; "Weigh Slip"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50074; "Certificate of Analysis"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50075; MSDS; boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RSPLSUM04Mar21';
        }
        field(50076; "Remarks 1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'DJ29319';
        }
        field(50077; "Remarks 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'DJ29319';
        }
        field(50300; Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'DJ29319';
        }
        field(50301; "Vehicle Capacity New"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Fahim Alak require manual entry field for decimal places.';
        }

        // Add changes to table fields here
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
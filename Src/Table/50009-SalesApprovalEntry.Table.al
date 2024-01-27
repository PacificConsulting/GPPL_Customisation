table 50009 "Sales Approval Entry"
{
    // RSPLSUM28688 - option added in Document Type:QC


    fields
    {
        field(1; "Document Type"; Option)
        {
            Description = 'RSPLAM29597 Customer KYC Option Added';
            OptionCaption = 'Sales Order,Blanket PO,Sales Invoice,Sales CrMemo,Purch Invoice,Purch CrMemo,Journal Voucher,GatePass,SalesReturnOrder,Customer,Customer OCL,QC,Customer KYC';
            OptionMembers = "Sales Order","Blanket PO","Sales Invoice","Sales CrMemo","Purch Invoice","Purch CrMemo","Journal Voucher",GatePass,SalesReturnOrder,Customer,"Customer OCL",QC,"Customer KYC";
        }
        field(2; "Document No."; Code[20])
        {
            TableRelation = IF ("Document Type" = CONST("Sales Order")) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(3; "User ID"; Code[50])
        {
            TableRelation = User."User Name";

            trigger OnValidate()
            begin
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected -------START
                User1.GET("User ID");
                "User Name" := User1.Name;
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected ---------END
            end;
        }
        field(4; "Approvar ID"; Code[50])
        {

            trigger OnValidate()
            begin
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected -------START
                User1.GET("Approvar ID");
                "Approver Name" := User1.Name;
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected ---------END
            end;
        }
        field(5; "Mandatory ID"; Boolean)
        {
        }
        field(6; Approved; Boolean)
        {
        }
        field(7; "Approval Date"; Date)
        {
        }
        field(8; "Approval Time"; Time)
        {
        }
        field(9; "User Name"; Text[30])
        {
        }
        field(10; "Approver Name"; Text[30])
        {
        }
        field(11; "Version No."; Integer)
        {
            Description = 'RB-N 17Nov2017';
            Editable = false;
        }
        field(12; "Date Sent for Approval"; Date)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(13; "Time Sent for Approval"; Time)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(14; "Credit Limit Approvar ID"; Code[50])
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(15; "Credit Limit Approvar Name"; Text[50])
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(16; "Credit Limit Approval Date"; Date)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(17; "Credit Limit Approval Time"; Time)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(18; "Over Due Approvar ID"; Code[50])
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(19; "Over Due Approvar Name"; Text[50])
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(20; "Over Due Approval Date"; Date)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(21; "Over Due Approval Time"; Time)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(22; "Level2 Approvar ID"; Code[50])
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(23; "Level2 Approvar Name"; Text[50])
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(24; "Level2 Approvar Date"; Date)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(25; "Level2 Approvar Time"; Time)
        {
            Description = 'RB-N 14Mar2018';
            Editable = false;
        }
        field(26; "Sequence No."; Integer)
        {
            Description = 'RB-N 16May2018';
            Editable = false;
        }
        field(27; "Division Code"; Code[20])
        {
            Description = 'RB-N 17May2018';
            Editable = false;
        }
        field(28; Rejected; Boolean)
        {
            Description = 'RB-N 23May2018';
            Editable = false;
        }
        field(29; "Rejected Date"; Date)
        {
            Description = 'RB-N 23May2018';
            Editable = false;
        }
        field(30; "Rejected Time"; Time)
        {
            Description = 'RB-N 23May2018';
            Editable = false;
        }
        field(50000; Cancelled; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50001; "Cancelled Date"; Date)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50002; "Cancelled Time"; Time)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50003; "Finance Approver ID"; Code[50])
        {
            Description = 'DJ 25012021';
            Editable = false;
        }
        field(50004; "Finance Approver Name"; Text[50])
        {
            Description = 'DJ 25012021';
            Editable = false;
        }
        field(50005; "Finance Approver Date"; Date)
        {
            Description = 'DJ 25012021';
            Editable = false;
        }
        field(50006; "Finance Approver Time"; Time)
        {
            Description = 'DJ 25012021';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Approvar ID", "Version No.", "Sequence No.", "Document Type")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        User1: Record 91;
}


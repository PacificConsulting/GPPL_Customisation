page 50010 "Sales Approval Entry"
{
    Caption = 'Approval Entry';
    DataCaptionFields = "Document Type";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50009;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Version No."; rec."Version No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("User Name"; rec."User Name")
                {
                    ApplicationArea = all;
                }
                field(Approved; rec.Approved)
                {
                    ApplicationArea = all;
                }
                field("Approvar ID"; rec."Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Approver Name"; rec."Approver Name")
                {
                    ApplicationArea = all;
                }
                field("Approval Date"; rec."Approval Date")
                {
                    ApplicationArea = all;
                }
                field("Approval Time"; rec."Approval Time")
                {
                    ApplicationArea = all;
                }
                field("Mandatory ID"; rec."Mandatory ID")
                {
                    ApplicationArea = all;
                }
                field("Date Sent for Approval"; rec."Date Sent for Approval")
                {
                    ApplicationArea = all;
                }
                field("Time Sent for Approval"; rec."Time Sent for Approval")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar ID"; rec."Level2 Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar Name"; rec."Level2 Approvar Name")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar Date"; rec."Level2 Approvar Date")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar Time"; rec."Level2 Approvar Time")
                {
                    ApplicationArea = all;
                }
                field("Finance Approvar ID"; FinAppUser)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Finance Approvar Date"; FinAppDate)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Finance Approvar Time"; FinAppTime)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        //>>14May2019
        CLEAR(FinAppUser);
        CLEAR(FinAppDate);
        CLEAR(FinAppTime);
        IF rec."Document Type" = rec."Document Type"::"Blanket PO" THEN BEGIN
            CLEAR(PH);
            IF PH.GET(PH."Document Type"::"Blanket Order", rec."Document No.") THEN BEGIN
                FinAppUser := PH."Finance Approver ID";
                FinAppDate := DT2DATE(PH."Finance Approver Date");
                FinAppTime := DT2TIME(PH."Finance Approver Date");
            END;
        END;
        //<<14May2019
    end;

    var
        PH: Record 38;
        FinAppUser: Code[50];
        FinAppDate: Date;
        FinAppTime: Time;

    //[Scope('Internal')]
    procedure Setfilters(DocumentType: Option "Sales Order","Blanket PO","Sales Invoice","Sales CrMemo","Purch Invoice","Purch CrMemo","Journal Voucher",GatePass,SalesReturnOrder,Customer,"Customer OCL","Customer KYC"; DocumentNo: Code[20])
    begin
        IF DocumentNo <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETCURRENTKEY("Document Type", "Document No.");
            IF DocumentType <> DocumentType::Customer THEN//RSPLSUM 17May2020
                rec.SETRANGE("Document Type", DocumentType)
            ELSE//RSPLSUM 17May2020
                //SETFILTER("Document Type",'%1|%2',"Document Type"::Customer,"Document Type"::"Customer OCL");//RSPLSUM 17May2020
                rec.SETFILTER("Document Type", '%1|%2|%3', rec."Document Type"::Customer, rec."Document Type"::"Customer OCL", rec."Document Type"::"Customer KYC");//RSPLSUM 17May2020  //RSPLAM29597 Customer KYC Added
                                                                                                                                                                    //SETRANGE(Approved,FALSE);
            rec.SETRANGE("Document No.", DocumentNo);
            rec.FILTERGROUP(0);
        END;
    end;
}


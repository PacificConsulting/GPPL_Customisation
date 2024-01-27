pageextension 50010 CustomerListExtcstm extends "Customer List"
{
    Editable = false;
    layout
    {
        addafter(name)
        {
            field("Headquarter Location"; rec."Headquarter Location")
            {
                ApplicationArea = all;
            }
            field("Customer Kms"; rec."Customer Kms")
            {
                ApplicationArea = all;
            }

            field("LBT Reg. No."; rec."LBT Reg. No.")
            {
                ApplicationArea = all;
            }
            // field("E.C.C. No."; rec."E.C.C. No.")
            // {
            //     ApplicationArea = all;
            // }
            field("E-Mail"; rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field("Creation Date"; rec."Creation Date")
            {
                ApplicationArea = all;
            }
            field(Address; rec.Address)
            {
                ApplicationArea = all;
            }
            field("Net Change"; rec."Net Change")
            {
                ApplicationArea = all;
            }
            field("GST Customer Type"; rec."GST Customer Type")
            {
                ApplicationArea = all;
            }
            field("Address 2"; rec."Address 2")
            {
                ApplicationArea = all;
            }
            // field("T.I.N. No."; rec."T.I.N. No.")
            // {
            //     ApplicationArea = all;
            // }
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Approved Payment Days"; rec."Approved Payment Days")
            {
                ApplicationArea = all;
            }
            field("State Code"; rec."State Code")
            {
                ApplicationArea = all;
            }
            // field("Salesperson Code"; rec."Salesperson Code")
            // {
            //     ApplicationArea = all;
            // }
            field("Vendor No."; rec."Vendor No.")
            {
                ApplicationArea = all;
            }
            field("Debit Amount"; rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount"; rec."Credit Amount")
            {
                ApplicationArea = all;
            }
            // field("Sales (LCY)"; rec."Sales (LCY)")
            // {
            //     ApplicationArea = all;
            // }
            field(Balance; rec.Balance)
            {
                ApplicationArea = all;
            }
            // field("Balance (LCY)"; rec."Balance (LCY)")
            // {
            //     ApplicationArea = all;
            // }
            // field(Structure; rec.Structure)
            // {
            //     ApplicationArea = all;
            // }
            field(Type; rec.Type)
            {
                ApplicationArea = all;
            }
            field(City; rec.City)
            {
                ApplicationArea = all;
            }
            field("O/s Email Alert"; rec."O/s Email Alert")
            {
                ApplicationArea = all;
            }
            field("GST Registration No."; rec."GST Registration No.")
            {
                ApplicationArea = all;
            }
            field("P.A.N. No."; rec."P.A.N. No.")
            {
                ApplicationArea = all;
            }
            field("Management Limit"; rec."Management Limit")
            {
                ApplicationArea = all;
            }
            field("Management Limit Exp Date"; rec."Management Limit Exp Date")
            {
                ApplicationArea = all;
            }
            field("Temporary Limit"; rec."Temporary Limit")
            {
                ApplicationArea = all;
            }
            field("Temporary Limit Exp Date"; rec."Temporary Limit Exp Date")
            {
                ApplicationArea = all;
            }
            field("Turnover Above 10 Crores"; rec."Turnover Above 10 Crores")
            {
                ApplicationArea = all;
            }
            field("ITR filled for last 02 years"; rec."ITR filled for last 02 years")
            {
                ApplicationArea = all;
            }
            field("Linking of Aadhaar with PAN"; rec."Linking of Aadhaar with PAN")
            {
                ApplicationArea = all;
            }
            field("Exclude From Bal Confir Mail"; rec."Exclude From Bal Confir Mail")
            {
                ApplicationArea = all;
            }
            field(TANNO; rec.TANNO)
            {
                ApplicationArea = all;
            }

        }
        // Add changes to page layout here


    }

    actions
    {
        // Add changes to page actions here
        addafter("&Customer")
        {
            action("Send Balance ConfirmationC")
            {
                RunObject = Report 70254;
                Promoted = true;
                PromotedIsBig = true;
                Image = MailAttachment;
                PromotedCategory = Process;
            }
            action("Create Account in Dynamics CRM")
            {
                trigger OnAction()

                VAR
                    Customer: Record 18;
                    CRMIntegrationManagement: Codeunit 5330;
                    CustomerRecordRef: RecordRef;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(Customer);
                    Customer.NEXT;

                    IF Customer.COUNT = 1 THEN
                        // CRMIntegrationManagement.CreateNewRecordInCRM(rec.RECORDID, FALSE)
                        CRMIntegrationManagement.CreateNewRecordsFromCRM(Rec.RecordId)
                    ELSE BEGIN
                        CustomerRecordRef.GETTABLE(Customer);
                        CRMIntegrationManagement.CreateNewRecordsInCRM(CustomerRecordRef);
                    END
                END;
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //  {
        //              MemberOF.RESET;
        //     MemberOF.SETRANGE(MemberOF."User ID", USERID);
        //              MemberOF.SETRANGE(MemberOF."Role ID",'MARKETING');
        //              IF MemberOF.FINDFIRST THEN
        //              }
        //RSPL-TC +
        UserSetup.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'MARKETING');
        IF AccessControl.FINDFIRST THEN BEGIN //RSPL-TC -
                                              //CSOmapping.RESET;
                                              //CSOmapping.SETRANGE(CSOmapping."User Id",USERID);
                                              //CSOmapping.SETRANGE(CSOmapping.Type,CSOmapping.Type::"Responsibility Center");
                                              //IF CSOmapping.FINDFIRST THEN
                                              //BEGIN
                                              // SETRANGE("Responsibility Center",CSOmapping.Value);
            rec.SETRANGE("Salesperson Code", USERID);
            //END;
        END ELSE
            //EBT0001
            IF LocationMap.GET(UPPERCASE(USERID), 0) THEN
                rec.SETFILTER(rec."Responsibility Center", GetResCustFilter);
        //EBT0001


        rec.SETCURRENTKEY(Name);           //EBT STIVAN ---(16/04/2012)--- To Filter Customer List as per Name
        rec.SETFILTER(Blocked, '<>%1', 3);   //EBT STIVAN ---(09/06/2012)--- To Filter Blocked as <> ALL  //RSPLAM Comment And Added in Page Filter
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    BEGIN
        //RSPLSUM 26Aug2020>>
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETRANGE("Role ID", 'CUSTCREATION');
        IF NOT AccessControl.FINDFIRST THEN
            ERROR('You do not have permission, Please contact system administrator');
        //RSPLSUM 26Aug2020<<
    END;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    BEGIN
        //RSPLSUM 26Aug2020>>
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETRANGE("Role ID", 'CUSTCREATION');
        IF NOT AccessControl.FINDFIRST THEN
            ERROR('You do not have permission, Please contact system administrator');
        //RSPLSUM 26Aug2020<<
    END;

    var
        UserSetup: Record 91;
        AccessControl: Record 2000000053;
        LocationMap: Record 50029;
        UserMgt: Codeunit 5700;
        User: Record 91;

    procedure GetResCustFilter(): Code[200]
    begin


        LocationMap.RESET;
        IF LocationMap.GET(UPPERCASE(USERID), 0) THEN
            EXIT(LocationMap.Area)
        ELSE
            EXIT('');
    end;




}
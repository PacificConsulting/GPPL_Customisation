/// MY PC 10 01 2024
pageextension 50078 "GeneralLedgerSetupExt" extends "General Ledger Setup"
{
    layout
    {
        addafter("Tax Information")
        {
            field("Ecess Account"; rec."Ecess Account")
            {
                ApplicationArea = all;
            }
            field("She Cess"; rec."She Cess")
            {
                ApplicationArea = all;
            }
            field("Custom Ecess Account"; rec."Custom Ecess Account")
            {
                ApplicationArea = all;
            }
            field("Custom She Cess Acc"; rec."Custom She Cess Acc")
            {
                ApplicationArea = all;
            }
            field("ADE Account"; rec."ADE Account")
            {
                ApplicationArea = all;
            }
            field("CVD Account"; rec."CVD Account")
            {
                ApplicationArea = all;
            }
            field("BCD Account"; rec."BCD Account")
            {
                ApplicationArea = all;
            }
            field("Excise Recovarable"; rec."Excise Recovarable")
            {
                ApplicationArea = all;
            }
            field("Excise Payable"; rec."Excise Payable")
            {
                ApplicationArea = all;
            }
            field("Email Notification On JV"; rec."Email Notification On JV")
            {
                ApplicationArea = all;
            }
            field("OCL Over Due days"; rec."OCL Over Due days")
            {
                ApplicationArea = all;
            }
            field("Exchange Master Company"; rec."Exchange Master Company")
            {
                ApplicationArea = all;
                TableRelation = Company.Name;
                Description = 'RSPLSUM-BUNKER';
            }
            field("E-Inv Token"; rec."E-Inv Token")
            {
                ApplicationArea = all;
            }
            field("E-Inv Sek"; rec."E-Inv Sek")
            {
                ApplicationArea = all;
            }
            field("E-Inv Public Key"; rec."E-Inv Public Key")
            {
                ApplicationArea = all;
            }
            field("E-Inv Token Expiry"; rec."E-Inv Token Expiry")
            {
                ApplicationArea = all;
            }
            field("GST TDS Rounding Precision"; rec."GST TDS Rounding Precision")
            {
                ApplicationArea = all;
            }
            field("TDS Effective Date"; rec."TDS Effective Date")
            {
                ApplicationArea = all;
            }

            field("EWB UserName"; Rec."EWB UserName")
            {
                ApplicationArea = all;
            }
            field("EWB Password"; rec."EWB Password")
            {
                ApplicationArea = all;
            }
            field("TCS Threshold Starting Date"; rec."TCS Threshold Starting Date")
            {
                ApplicationArea = all;
            }
            field("TCS Threshold Amount"; rec."TCS Threshold Amount")
            {
                ApplicationArea = all;
            }
            field("MKey ID"; rec."MKey ID")
            {
                ApplicationArea = all;
            }

            field("MSecret Key"; rec."MSecret Key")
            {
                ApplicationArea = all;
            }
            field(MPicture; rec.MPicture)
            {
                ApplicationArea = all;
            }
            field(MHomepage; rec.MHomepage)
            {
                ApplicationArea = all;
            }
            field(MDescription; rec.MDescription)
            {
                ApplicationArea = all;
            }
            field("MInvoice URL"; rec."MInvoice URL")
            {
                ApplicationArea = all;
                ExtendedDatatype = URL;
            }
            field("MPayment URL"; rec."MPayment URL")
            {
                ApplicationArea = all;
                ExtendedDatatype = URL;
            }
            field("MCredit Memo URL"; rec."MCredit Memo URL")
            {
                ApplicationArea = all;
                ExtendedDatatype = URL;
            }
            field("MJson File Path"; rec."MJson File Path")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Json File Path';
                Style = Strong;
                StyleExpr = TRUE;
                trigger OnValidate()
                var
                    FileManagement: Codeunit 419;
                begin
                    //  "MJson File Path" := FileManagement.BrowseForFolderDialog('Windows', 'Json File Template', TRUE);

                end;
            }
            field("MIs Invoice"; rec."MIs Invoice")
            {
                ApplicationArea = all;
            }
            field("MIs Payment"; rec."MIs Payment")
            {
                ApplicationArea = all;
            }
            field("MIs Credit Memo"; rec."MIs Credit Memo")
            {
                ApplicationArea = all;
            }
            field("MAuthorization Key"; rec."MAuthorization Key")
            {
                ApplicationArea = all;
                ExtendedDatatype = Masked;
                CaptionML = ENU = 'Authorization Key';
                Style = Strong;
                StyleExpr = TRUE;
            }
            field(MJournalURL; rec.MJournalURL)
            {
                ApplicationArea = all;
                ExtendedDatatype = URL;
                CaptionML = ENU = 'Journal URL';

                Style = Strong;
                StyleExpr = TRUE;
            }
            field("MIs Journal"; rec."MIs Journal")
            {
                ApplicationArea = all;
            }


        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

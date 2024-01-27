// MY PC 12 01 2024
pageextension 50096 "PostedPurchCreditMemoExt" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("E-Inv Irn"; rec."E-Inv Irn")
            {
                ApplicationArea = all;
            }
            field(Remarks; rec.Remarks)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("&Navigate")

        {
            action("Cancel IRN")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ClientId: Text;
                    AuthToken: Text;
                    Sek: Text;
                    TokenExpiry: Text;
                    CancelDate: Text;
                    //  ConvertCode: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Convert";
                    // byteAppKey: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Byte";
                    decryptedSek: Text;
                    AckNo: Text;
                    AckDt: Text;
                    Irn: Text;
                    SignedInvoice: Text;
                    SignedQRCode: Text;
                    Client_ID: Text;
                    Client_Secret: Text;
                    cuEInvoiceAPI: Codeunit 50006;
                    // Text000_Options: TextConst 'ENU=&Cancel IRN,&Cancel E-Way Bill,Cancel Both;ENN=&Receive,&Invoice,Receive &and Invoice';
                    Selection: Integer;
                    GeneralLedgerSetup: Record 98;
                    pgRespectivePage: Page 50093;
                // TransType: 'Purchase,Sales';
                //   GSTLedgerEntry: Record 16418;
                begin
                    //RSPL_28117_AviMali_11122020_EINV  
                    //   DetailGSTLedgerEntry1.SETRANGE("Document No.", "No.");
                    //  IF DetailGSTLedgerEntry1.FINDFIRST THEN BEGIN
                    //      DocNo := DetailGSTLedgerEntry1."Document No.";
                    //  END ELSE
                    //      ERROR(Text001, "No.");

                    // GeneralLedgerSetup.GET;
                    // pgRespectivePage.SetData("E-Inv Irn", '', '', '', "No.", AuthToken, Sek, 1, TransType::Purchase);
                    // pgRespectivePage.RUN;

                    //RSPL_28117_AviMali_11122020_EINV 
                end;
            }

            action("Get IRN Detail")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    LocRec: Record 14;
                    //  CUEinvoice: Codeunit 50011;
                    ClientId: Text;
                    AuthToken: Text;
                    Sek: Text;
                    Client_ID: Text;
                    Client_Secret: Text;
                    TokenExpiry: Text;
                    decryptedSek: Text;
                begin
                    LocRec.GET(rec."Location Code");
                    // CUEinvoice.SetLocation(LocRec.Code);
                    //DJ GSP API
                    //  CUEinvoice.GetToken(LocRec."E-Inv ClientId", LocRec."E-Inv Client_Secret", AuthToken, TokenExpiry);
                    //  CUEinvoice.GetIRNDetails(AuthToken, Sek, "E-Inv Irn", LocRec."E-Inv ClientId", LocRec."E-Inv Password", LocRec."GST Registration No.", LocRec."E-Inv UserName");
                    //DJ GSP API
                    //DJ Govt API Comment

                end;
            }


        }
    }

    var
        myInt: Integer;
}

pageextension 80001 Vendor_Card_Ext extends "Vendor Card"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }

        modify(Name)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                rec.TestField("Full Name");
            end;
        }
        addafter("Post Code")
        {
            /*  field(City; Rec.City)
             {
                 ApplicationArea = all;
             } */
        }
        addafter(Contact)
        {
            field("Full Name"; rec."Full Name")
            {
                ApplicationArea = all;
            }
        }
        addafter("Last Date Modified")
        {
            field("Creation Date"; rec."Creation Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Shipping Agent"; rec."Shipping Agent")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    //EBT/LR/0001
                    IF Rec."Shipping Agent" THEN
                        //CurrForm."Shipping Agent Code".EDITABLE := TRUE
                        ShippingAgentCode := TRUE //RSPL-TC
                    ELSE
                        //CurrForm."Shipping Agent Code".EDITABLE := FALSE;
                        ShippingAgentCode := FALSE //RSPL-TC
                                                   //EBT/LR/0001
                END;

            }
            // field("Structure"; rec."Structure")
            // {
            //     ApplicationArea = all;
            // }
            field("Exclude From Bal Confir Mail"; rec."Exclude From Bal Confir Mail")
            {
                ApplicationArea = all;
            }
            field("Vendor Group Code"; rec."Vendor Group Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Tax Liable")
        {
            field("TDS not Applicable"; rec."TDS not Applicable")
            {
                ApplicationArea = all;
            }
        }
        addafter("Prepayment %")
        {
            field("IRN Applicable"; rec."IRN Applicable")
            {
                ApplicationArea = all;
            }
            field("W.e.f. Date(C.S.T No.)"; rec."W.e.f. Date(C.S.T No.)")
            {
                ApplicationArea = all;
            }
            field("W.e.f. Date(T.I.N No.)"; rec."W.e.f. Date(T.I.N No.)")
            {
                ApplicationArea = all;
            }
            /*  field("P.A.N. No."; Rec."P.A.N. No.")
             {
                 ApplicationArea = all;
                 trigger OnValidate()
                 begin
                     IF rec."P.A.N. No." <> '' THEN
                         IF STRLEN(rec."P.A.N. No.") > 10 THEN
                             ERROR('P.A.N. No. Should not more then 10 digits')
                 END;

             } */

        }
        modify("P.A.N. No.")
        {
            trigger OnBeforeValidate()
            begin
                IF rec."P.A.N. No." <> '' THEN
                    IF STRLEN(rec."P.A.N. No.") > 10 THEN
                        ERROR('P.A.N. No. Should not more then 10 digits')
            end;
        }
        modify("Preferred Bank Account Code")
        {
            Visible = true;
        }
        addafter("Language Code")
        {
            /*  field("VAT Registration No."; Rec."VAT Registration No.")
             {
                 ApplicationArea = all;
                 trigger OnDrillDown()
                 var
                     // myInt: Integer;
                     VATRegistrationLogMgt: Codeunit 249;
                 begin
                     VATRegistrationLogMgt.AssistEditVendorVATReg(Rec);
                 end;
             } */

        }
        addafter("P.A.N. Reference No.")
        {
            field("Linking of Aadhaar with PAN"; rec."Linking of Aadhaar with PAN")
            {
                ApplicationArea = all;
            }
            field("ITR filled for last 02 years"; rec."ITR filled for last 02 years")
            {
                ApplicationArea = all;
            }
            // field("Service Entity Type"; rec."Service Entity Type")
            // {
            //     ApplicationArea = all;
            // }
        }
        addafter("Commissioner's Permission No.")
        {
            /*  field(Transporter; rec.Transporter)
             {
                 ApplicationArea = all;
             }
  */
        }
        addafter(Invoicing)
        {
            group(MSME)
            {
                field("MSME Status"; Rec."MSME Status")
                {
                    ApplicationArea = ALL;
                    trigger OnValidate()
                    begin
                        //>>14Feb2019
                        MSMERegNoEdit := FALSE;
                        IF (Rec."MSME Status" = Rec."MSME Status"::" ") OR (Rec."MSME Status" = Rec."MSME Status"::"Non MSME") THEN
                            MSMERegNoEdit := FALSE
                        ELSE
                            MSMERegNoEdit := TRUE;
                        //<<14Feb2019
                    END;

                }
                field("MSME Registration No."; rec."MSME Registration No.")
                {
                    ApplicationArea = all;
                    Editable = MSMERegNoEdit;
                }
            }
        }



        modify("VAT Registration No.")
        {
            Visible = true;
            trigger OnDrillDown()
            var

                VATRegistrationLogMgt: Codeunit 249;
            begin
                VATRegistrationLogMgt.AssistEditVendorVATReg(Rec);
            end;
        }
        /*  modify("P.A.N. Status")
         {
            // OptionCaption = ' ,PANAPPLIED,PANINVALID,PANNOTAVBL,PANNOTAPPL';
            // OptionCaptionML = " ,PANAPPLIED,PANINVALID,PANNOTAVBL,PANNOTAPPL";
         }
  */


        // Add changes to page layout here
    }


    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Vendor Form will get Editable ----START
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETRANGE("Role ID", 'VENDCREATION');
        IF NOT (AccessControl.FINDFIRST) THEN
            CurrPage.EDITABLE(FALSE);
        //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Vendor Form will get Editable ------END
        //RSPL-TC -
    end;

    trigger OnQueryClosePage(closeActio: Action): Boolean
    var
        myInt: Integer;
    begin
        IF Rec."No." <> '' THEN BEGIN//RSPLSUM
            Rec.TESTFIELD("MSME Status");//14Feb2019
            Rec.TESTFIELD("GST Vendor Type");//RSPLSUM03May21
        END;//RSPLSUM03May21

        IF (Rec."MSME Status" = Rec."MSME Status"::"Micro Industries")
        OR (Rec."MSME Status" = Rec."MSME Status"::"Small Scale Industries")
        OR (Rec."MSME Status" = Rec."MSME Status"::"Medium Scale Industries") THEN
            Rec.TESTFIELD("MSME Registration No.");
    end;

    trigger OnAfterGetRecord()
    begin
        rec.SETRANGE("No.");
        //EBT/LR/0001
        IF Rec."Shipping Agent" THEN
            //CurrForm."Shipping Agent Code".EDITABLE := TRUE
            ShippingAgentCode := TRUE //RSPL-TC
        ELSE
            //CurrForm."Shipping Agent Code".EDITABLE := FALSE;
            ShippingAgentCode := FALSE; //RSPL-TC
                                        //EBT/LR/0001 
                                        //>>14Feb2019
        MSMERegNoEdit := FALSE;
        IF (Rec."MSME Status" = Rec."MSME Status"::" ") OR (Rec."MSME Status" = Rec."MSME Status"::"Non MSME") THEN
            MSMERegNoEdit := FALSE
        ELSE
            MSMERegNoEdit := TRUE;
        //<<14Feb2019
    END;
    //end;

    var
        myInt: Integer;
        ShippingAgentCode: Boolean;
        User: Record 91;
        AccessControl: Record 2000000053;

        MSMERegNoEdit: Boolean;
}
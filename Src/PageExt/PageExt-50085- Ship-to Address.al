// MY PC 11 01 2024
pageextension 50085 "ShipToAddressExt" extends "Ship-to Address"
{
    layout
    {
        addafter("GST Registration No.")
        {
            field("GST Customer Type"; rec."GST Customer Type")
            {
                ApplicationArea = all;
            }
            field("T.I.N. No."; rec."T.I.N. No.")
            {
                ApplicationArea = all;
            }
            field("Tax Exemption No."; rec."Tax Exemption No.")
            {
                ApplicationArea = all;
            }
            field("L.S.T. No."; rec."L.S.T. No.")
            {
                ApplicationArea = all;
            }
            field("C.S.T. No."; rec."C.S.T. No.")
            {
                ApplicationArea = all;
            }
            field("P.A.N. No."; rec."P.A.N. No.")
            {
                ApplicationArea = all;
            }
            field("E.C.C. No."; rec."E.C.C. No.")
            {
                ApplicationArea = all;
            }
            field(Range; rec.Range)
            {
                ApplicationArea = all;
            }
            field(Collectorate; rec.Collectorate)
            {
                ApplicationArea = all;
            }
            field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
            {
                ApplicationArea = all;
            }
            field("State Code"; rec."State Code")
            {
                ApplicationArea = all;
            }
            field(Structure; rec.Structure)
            {
                ApplicationArea = all;
            }
            field("P.A.N. Reference No."; rec."P.A.N. Reference No.")
            {
                ApplicationArea = all;
            }
            field("P.A.N. Status"; rec."P.A.N. Status")
            {
                ApplicationArea = all;
            }
            field("Export or Deemed Export"; rec."Export or Deemed Export")
            {
                ApplicationArea = all;
            }
            field("VAT Exempted"; rec."VAT Exempted")
            {
                ApplicationArea = all;
            }
        }
    }



    actions
    {
        // Add changes to page actions here
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        //RSPLSUM 01Feb21
        rec.TESTFIELD(City);
        IF rec."GST Customer Type" <> rec."GST Customer Type"::Export THEN
            rec.TESTFIELD(rec."Post Code");
        //RSPLSUM 01Feb21
    end;

    var
        myInt: Integer;
}
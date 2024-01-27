tableextension 50018 GenjonlineExtCtm extends 81
{
    fields

    {

        field(50000; "Check Print Name"; Text[100])
        {
            Description = 'EBT STIVAN - 09042012 - Added Field For Check Printing';
        }
        field(50001; "Tot. Serv Tax Amount (Intm) 1"; Decimal)
        {
            Caption = 'Tot. Serv Tax Amount (Intm)';
        }
        field(50002; "PoT 1"; Boolean)
        {
            Caption = 'PoT';
            Editable = false;

            trigger OnValidate()
            begin
                //VALIDATE("Input Service Distribution");
            end;
        }
        field(50003; "Posting 1"; Boolean)
        {
            Caption = 'Posting';
        }
        field(50004; "Applied TDS Base Amount 1"; Decimal)
        {
            Caption = 'Applied TDS Base Amount';
        }
        field(50017; "Exp/Purchase Invoice Doc. No."; Code[20])
        {
            Description = 'EBT STIVAN 140412 --> To get Posted Purchase or expense Invoice No.';
            TableRelation = "Purch. Inv. Header"."No.";
        }
        field(50018; "Post Excise Details"; Boolean)
        {
        }
        field(50019; "Entry Type"; Option)
        {
            OptionCaption = ' ,Transfer Shipment,Transfer Receipt';
            OptionMembers = " ","Transfer Shipment","Transfer Receipt";
        }
        field(50201; "Credit Card No. 1"; Code[20])
        {
            Caption = 'Credit Card No.';

            // TableRelation = IF ("Account Type" = CONST('Customer'),
            //                     "Document Type" = FILTER('Payment|Refund'),
            //                     "Bal. Account Type" = CONST('Bank Account')) "DO Payment Credit Card" WHERE("Customer No." = FIELD("Account No."));
            //Azhar Pending

            trigger OnValidate()
            var
                DOPaymentMgt: Codeunit 825;
            begin
                CheckNoCardTransactEntryExist(xRec);
                IF "Credit Card No. 1" = '' THEN
                    EXIT;

                //DOPaymentMgt.CheckCreditCardData("Credit Card No. 1");
            end;
        }
        field(50202; "Send For Approval"; Boolean)
        {
            Description = '31Oct2018 JVApprovalProcess';
            Editable = false;
        }
        field(50203; "Level1 Approval"; Boolean)
        {
            Description = '31Oct2018 JVApprovalProcess';
            Editable = false;
        }
        field(50204; "Level2 Approval"; Boolean)
        {
            Description = '31Oct2018 JVApprovalProcess';
            Editable = false;
        }
        field(50205; "Approval Status"; Option)
        {
            Description = '31Oct2018 JVApprovalProcess';
            Editable = false;
            OptionCaption = 'Open,Pending for L1 Approval,Pending for L2 Approval,Approved';
            OptionMembers = Open,"Pending for L1 Approval","Pending for L2 Approval",Approved;
        }
        field(50206; "Cheque Type"; Option)
        {
            Description = 'RSPLSUM 21Feb2020';
            OptionCaption = ' ,Computerized,Manual';
            OptionMembers = " ",Computerized,Manual;

            trigger OnValidate()
            var
                RecGnlJnlBatch: Record 232;
                RecBankAcc: Record 270;
            //NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                //RSPLSUM 21Feb2020>>
                IF "Journal Template Name" = 'BANK PAYME' THEN BEGIN
                    IF "Cheque Type" = "Cheque Type"::Computerized THEN BEGIN
                        RecGnlJnlBatch.RESET;
                        RecGnlJnlBatch.SETRANGE("Journal Template Name", "Journal Template Name");
                        RecGnlJnlBatch.SETRANGE(Name, "Journal Batch Name");
                        IF RecGnlJnlBatch.FINDFIRST THEN BEGIN
                            RecGnlJnlBatch.TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                            RecGnlJnlBatch.TESTFIELD("Bal. Account No.");
                        END;
                    END;

                    IF ("Cheque Type" = "Cheque Type"::Computerized) AND
                        (RecGnlJnlBatch."Bal. Account Type" = RecGnlJnlBatch."Bal. Account Type"::"Bank Account") AND
                          (RecGnlJnlBatch."Bal. Account No." <> '') THEN BEGIN
                        RecBankAcc.RESET;
                        IF RecBankAcc.GET(RecGnlJnlBatch."Bal. Account No.") THEN BEGIN
                            RecBankAcc.TESTFIELD("Cheque No. Series");
                            //CLEAR(NoSeriesMgt);
                            //"Cheque No." := NoSeriesMgt.GetNextNo(RecBankAcc."Cheque No. Series", "Posting Date", TRUE);
                        END;
                    END;
                END;
                //RSPLSUM 21Feb2020<<
            end;
        }
        field(50207; "Credit Checking Not Required"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;
        }
        modify("Party Code")
        {
            trigger OnAfterValidate()
            var
                RecCust: Record Customer;
            begin
                RecCust.Reset();
                RecCust.SetRange("No.", Rec."Bal. Account No.");
                if RecCust.FindFirst() then begin
                    if RecCust."KYC Approval Status" <> RecCust."KYC Approval Status"::Approved then begin

                        Error('Customer KYC Not Approved %1');
                    end;
                end;

            end;
        }
        modify("Bal. Account No.")
        {
            trigger OnAfterValidate()
            var
                RecCust: Record Customer;
            begin
                RecCust.Reset();
                RecCust.SetRange("No.", Rec."Bal. Account No.");
                if RecCust.FindFirst() then begin
                    if RecCust."KYC Approval Status" <> RecCust."KYC Approval Status"::Approved then begin

                        Error('Customer KYC Not Approved %1');
                    end;
                    Rec.Validate("Check Print Name", RecCust."Full Name");
                end else begin
                    Rec.Validate("Check Print Name", '');
                end;

            end;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
                Bank: Record "Bank Account";
                Cust: Record Customer;
            begin
                if Rec."Account Type" = Rec."Account Type"::Vendor then begin

                    if Vend.Get(Rec."Account No.") then begin
                        //EBT STIVAN -(09/04/2012)- For Cheque Printing ---Start
                        Rec.Validate("Check Print Name", Vend."Full Name");
                        //EBT STIVAN -(09/04/2012)- For Cheque Printing ---END
                    end;

                end;
                if Rec."Account Type" = Rec."Account Type"::Customer then begin

                    if Cust.Get(Rec."Account No.") then begin
                        //EBT STIVAN -(09/04/2012)- For Cheque Printing ---Start
                        Rec.Validate("Check Print Name", Cust."Full Name");
                        //EBT STIVAN -(09/04/2012)- For Cheque Printing ---END
                    end;

                end;
                if Rec."Account Type" = Rec."Account Type"::"Bank Account" then begin

                    if Bank.Get(Rec."Account No.") then begin
                        //EBT STIVAN -(09/04/2012)- For Cheque Printing ---Start
                        Rec.Validate("Check Print Name", Bank.Name);
                        //EBT STIVAN -(09/04/2012)- For Cheque Printing ---END
                    end;

                end;

            end;
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

    local procedure CheckNoCardTransactEntryExist(GenJnlLine: Record 81)
    var
        //DOPaymentTransLogEntry: Record 829;
        //DOPaymentTransLogMgt: Codeunit 829;
        DocumentType: Integer;
        Text017: Label 'Credit card %1 has already been performed for this %2, but posting failed. You must complete posting of the document of type %2 with the number %3.';
    begin
        /*
        CASE GenJnlLine."Document Type" OF
            GenJnlLine."Document Type"::Payment:
                DocumentType := DOPaymentTransLogEntry."Document Type"::Payment;
            GenJnlLine."Document Type"::Refund:
                DocumentType := DOPaymentTransLogEntry."Document Type"::Refund;
        END;
        IF DOPaymentTransLogEntry.FINDFIRST THEN
            IF DOPaymentTransLogMgt.FindPostingNotFinishedEntry(DocumentType, GenJnlLine."Document No.", DOPaymentTransLogEntry) THEN
                ERROR(Text017, DOPaymentTransLogEntry."Transaction Type", GenJnlLine."Document Type", GenJnlLine."Document No.");
                */
    end;

}
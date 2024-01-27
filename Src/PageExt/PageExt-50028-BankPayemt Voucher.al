pageextension 50028 "BankPayment VoucherExtCstm " extends "Bank Payment Voucher"
{
    layout
    {
        addafter(Description)
        {
            field("Check Print Name"; Rec."Check Print Name")
            {
                ApplicationArea = all;
            }
            field("Cheque Type"; Rec."Cheque Type")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    //RSPLSUM 24Feb2020>>
                    IF Rec."Cheque Type" = Rec."Cheque Type"::Computerized THEN
                        ChequeNoEditable := FALSE
                    ELSE
                        ChequeNoEditable := TRUE;
                    //RSPLSUM 24Feb2020<<
                end;
            }
        }
        modify("Document No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //RSPLSUM 24Feb2020>>
                IF Rec."Journal Template Name" = 'BANK PAYME' THEN BEGIN
                    RecGnlJnlLine.RESET;
                    RecGnlJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    RecGnlJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    RecGnlJnlLine.SETRANGE("Document No.", Rec."Document No.");
                    IF RecGnlJnlLine.FINDFIRST THEN BEGIN
                        Rec."Cheque Type" := RecGnlJnlLine."Cheque Type";
                        Rec."Cheque No." := RecGnlJnlLine."Cheque No.";
                    END ELSE BEGIN
                        Rec."Cheque Type" := Rec."Cheque Type"::" ";
                        Rec."Cheque No." := '';
                    END;
                END;
                //RSPLSUM 24Feb2020<<
            end;
        }

    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        AccessControl: Record "Access Control";
    begin

        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETFILTER("Role ID", '%1|%2', 'SUPER', 'LEDGER ENTRIES VIEW');
        IF AccessControl.FINDFIRST THEN
            AccVisible := TRUE
        ELSE
            AccVisible := FALSE;

        //RSPL-TC -

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        RecGnlJnlLine: Record "Gen. Journal Line";
    begin
        //RSPLSUM 24Feb2020>>
        IF Rec."Journal Template Name" = 'BANK PAYME' THEN BEGIN
            RecGnlJnlLine.RESET;
            RecGnlJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
            RecGnlJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
            RecGnlJnlLine.SETRANGE("Document No.", Rec."Document No.");
            IF RecGnlJnlLine.FINDFIRST THEN BEGIN
                Rec."Cheque Type" := RecGnlJnlLine."Cheque Type";
                Rec."Cheque No." := RecGnlJnlLine."Cheque No.";
            END ELSE BEGIN
                Rec."Cheque Type" := Rec."Cheque Type"::" ";
                Rec."Cheque No." := '';
            END;
        END;
        //RSPLSUM 24Feb2020<<
    end;

    var
        myInt: Integer;
        AccVisible: Boolean;
        RecGnlJnlLine: Record "Gen. Journal Line";
        ChequeNoEditable: Boolean;
}
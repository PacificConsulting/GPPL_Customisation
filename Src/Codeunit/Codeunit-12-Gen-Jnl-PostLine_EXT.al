codeunit 50020 GenJnlPostExtCstm
{
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostGenJnlLine, '', false, false)]
    local procedure OnBeforePostGenJnlLine(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean);
    var
        //GSTManagement: Codeunit gst mn
        GenJnlLine: Record "Gen. Journal Line";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GSTTCSErr: Label 'You cannot post the transcation, It has TCS and GST payment .';
        NextTransactionNo: Integer;
        GLSourceCode: Code[10];
    begin

        // //EBT STIVAN ---(14/04/2012)--- To Capture The Posting Document No in Message After Posting ---START
        // GetGLEntryNo(GlobalGLEntry."Entry No.");
        // //EBT STIVAN ---(14/04/2012)--- To Capture The Posting Document No in Message After Posting -----END

        // //Mintifi_SUM>>
        // OnAfterPostGenJnlLine(GenJnlLine); // Added By Leo CodeValue.
        //                                   //Mintifi_SUM<<

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterPostCust, '', false, false)]
    local procedure OnAfterPostCust(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer);
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry."Credit Checking Not Required" := GenJournalLine."Credit Checking Not Required";//RSPLSUM-BUNKER
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterPostBankAcc, '', false, false)]
    local procedure OnAfterPostBankAcc(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; Balancing: Boolean; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer);
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        TDSAmount: Decimal;
        BankAcc: Record "Bank Account";
        BankChargeAmount: Decimal;
        SignOfBankAccLedgAmount: Decimal;
        BPDocumentNo: Code[20];
    begin
        //BankAccLedgEntry."Currency Code" := BankAcc."Currency Code";

        //>>RSPL-Rahul
        BankAccLedgEntry."Currency Code" := GenJnlLine."Currency Code";
        IF GenJnlLine."Currency Factor" <> 0 THEN
            BankAccLedgEntry."Currency Factor" := 1 / GenJnlLine."Currency Factor";
        //<<RSPL-Rahul     


        //>>RSPL
        IF BankAccLedgEntry."Currency Factor" <> 0 THEN
            BankAccLedgEntry."Amount (FCY)" := BankAccLedgEntry.Amount / BankAccLedgEntry."Currency Factor"
        ELSE
            BankAccLedgEntry."Amount (FCY)" := 0;
        //<<RSPL


        //EBT STIVAN (09042012)---For Check printing-------------------------------------------------------START
        BPDocumentNo := BankAccLedgEntry."Document No.";
        //EBT STIVAN (09042012)---For Check printing-------------------------------------------------------START

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostJob, '', false, false)]
    local procedure OnBeforePostJob(var GenJournalLine: Record "Gen. Journal Line"; GLEntry: Record "G/L Entry"; var IsJobLine: Boolean; var IsHandled: Boolean);
    var
        GlobalGLEntry: Record "G/L Entry";
        SU: Codeunit "Single Instance CU";
    begin
        SU.InsertGL(GlobalGLEntry);//EBT SU
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitGLEntry, '', false, false)]
    local procedure OnAfterInitGLEntry(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register");
    var
        GenJnlLine: Record "Gen. Journal Line";

    begin
        //GLEntry.Amount := Amount;  //RSPL-TC
        GLEntry.Amount := ROUND(Amount, 0.01, '=');//RSPL-Sourav
                                                   //EBT STIVAN -(09/04/2012)- For Cheque Printing ---Start
        GLEntry."Check Print Name" := GenJnlLine."Check Print Name"; //SUDIP Please complie removing the comment
                                                                     //EBT STIVAN -(09/04/2012)- For Cheque Printing ---END
        GLEntry."Creation Date" := CURRENTDATETIME; // DJ 25Nov2019
                                                    //EBT STIVAN -(05/01/2012)- To update Purchase/Expense Document No in case of JV ---START
        GLEntry."Exp/Purchase Invoice Doc. No." := GenJnlLine."Exp/Purchase Invoice Doc. No."; //SUDIP Please complie removing the comment
                                                                                               //EBT STIVAN -(05/01/2012)- To update Purchase/Expense Document No in case of JV -----END
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInsertGLEntry, '', false, false)]
    local procedure OnAfterInsertGLEntry(var Sender: Codeunit "Gen. Jnl.-Post Line"; GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line"; TempGLEntryBuf: Record "G/L Entry" temporary; CalcAddCurrResiduals: Boolean);
    var
        NeedsRoundingErr: Label '%1 needs to be rounded';
    begin

        //MJ Added ROUND format for Rounding Error----Start
        IF GenJnlLine."Currency Code" = '' THEN BEGIN
            IF ROUND(GLEntry.Amount, 0.01) <> ROUND(GLEntry.Amount) THEN
                GLEntry.FIELDERROR(
                  Amount,
                  STRSUBSTNO(NeedsRoundingErr, GLEntry.Amount));
        END ELSE
            ;
        //MJ Added ROUND format for Rounding Error----End
    end;





    var
        myInt: Integer;
}
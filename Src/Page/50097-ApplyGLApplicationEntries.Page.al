page 50097 "Apply GL Application Entries"
{
    Caption = 'Apply GL Application Entries';
    DataCaptionFields = "G/L Account No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Worksheet;
    SourceTable = 50057;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Posting Date2"; ApplyingGLEntAppEntry."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                }
                field("Document Type2"; ApplyingGLEntAppEntry."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
                }
                field("Document No.2"; ApplyingGLEntAppEntry."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                }
                field("GL Account No2"; ApplyingGLEntAppEntry."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                    Editable = false;
                }
                field("Description2"; ApplyingGLEntAppEntry.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field(Amount; ApplyingGLEntAppEntry.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                }
                field("Remaining Amount2"; ApplyingGLEntAppEntry."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                }
            }
            repeater(control03)
            {
                field("Applies-to ID"; rec."Applies-to ID")
                {
                    Visible = "Applies-to IDVisible";
                }
                field("Posting Date"; rec."Posting Date")
                {
                    Editable = false;
                }
                field("Document Type"; rec."Document Type")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Document No."; rec."Document No.")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                }
                field(Description; rec.Description)
                {
                    Editable = false;
                }
                field("Remaining Amount"; rec."Remaining Amount")
                {
                }
                field("Appln. Remaining Amount"; CalcApplnRemainingAmount(rec."Remaining Amount"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Remaining Amount';
                    Editable = false;
                }
                field("Amount to Apply2"; rec."Amount to Apply")
                {

                    trigger OnValidate()
                    begin
                        /*
                        IF (xRec."Amount to Apply" = 0) OR ("Amount to Apply" = 0) AND
                           ((ApplnType = ApplnType::"Applies-to ID") OR (CalcType = CalcType::Direct))
                        THEN
                          SetCustApplId;
                        GET("Entry No.");
                        AmounttoApplyOnAfterValidate;
                        */

                    end;
                }
            }
            group(group2)
            {
                Visible = false;
                fixed(General1)
                {
                    group("Appln. Currency")
                    {
                        Caption = 'Appln. Currency';
                        field(ApplnCurrencyCode; ApplnCurrencyCode)
                        {
                            ApplicationArea = all;
                            Editable = false;
                            TableRelation = Currency;
                        }
                    }
                    group("Amount to Apply")
                    {
                        Caption = 'Amount to Apply';
                        field(AmountToApply; AmountToApplyShow)
                        {
                            ApplicationArea = all;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Amount to Apply';
                            Editable = false;
                        }
                    }
                    group("Applied Amount")
                    {
                        Caption = 'Applied Amount';
                        field(AppliedAmount; AppliedAmountShow)
                        {
                            ApplicationArea = all;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Applied Amount';
                            Editable = false;
                        }
                    }
                    group("Available Amount")
                    {
                        Caption = 'Available Amount';
                        field("Remaining Amount3"; ApplyingGLEntAppEntry."Remaining Amount")
                        {
                            ApplicationArea = all;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Available Amount';
                            Editable = false;
                        }
                    }
                    group(Balance)
                    {
                        Caption = 'Balance';
                        field(ControlBalance; ApplyingGLEntAppEntry."Remaining Amount" + AmountToApplyShow)
                        {
                            ApplicationArea = all;
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part(part1; 9106)
            {
                SubPageLink = "Entry No." = FIELD("Entry No.");
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Application")
            {
                Caption = '&Application';
                Image = Apply;
                action("Set Applies-to ID")
                {
                    Caption = 'Set Applies-to ID';
                    Image = SelectLineToApply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    begin
                        CLEAR(GLApplEntry);
                        GLApplEntry.COPY(Rec);
                        CurrPage.SETSELECTIONFILTER(GLApplEntry);

                        CLEAR(AmountToApplyShow);
                        CLEAR(AppliedAmountShow);
                        IF GLApplEntry.FINDSET THEN
                            REPEAT
                                IF GLApplEntry."Applies-to ID" = '' THEN BEGIN
                                    GLApplEntry."Applies-to ID" := USERID;
                                    GLApplEntry."Amount to Apply" := GLApplEntry."Remaining Amount";
                                    GLApplEntry.MODIFY;
                                    AmountToApplyShow += GLApplEntry."Amount to Apply";
                                    AppliedAmountShow := AmountToApplyShow;
                                END ELSE BEGIN
                                    GLApplEntry."Applies-to ID" := '';
                                    GLApplEntry."Amount to Apply" := 0;
                                    GLApplEntry.MODIFY;
                                    AmountToApplyShow -= GLApplEntry."Amount to Apply";
                                    AppliedAmountShow := AmountToApplyShow;
                                END;
                            UNTIL GLApplEntry.NEXT = 0;
                    end;
                }
                action("Post Application")
                {
                    Caption = 'Post Application';
                    Ellipsis = true;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        PostDirectApplication;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF ApplnType = ApplnType::"Applies-to Doc. No." THEN
            CalcApplnAmount;
    end;

    trigger OnAfterGetRecord()
    begin

        //StyleTxt := SetStyle;
    end;

    trigger OnInit()
    begin
        "Applies-to IDVisible" := TRUE;
    end;

    trigger OnModifyRecord(): Boolean
    begin

        //IF "Applies-to ID" <> xRec."Applies-to ID" THEN
        // CalcApplnAmount;
        //EXIT(FALSE);
    end;

    trigger OnOpenPage()
    begin
        CLEAR(ApplyingGLEntAppEntry);
        ApplyingGLEntAppEntry.COPY(Rec);
        ApplyingGLEntAppEntry.CALCFIELDS(Amount, "Remaining Amount", "Debit Amount", "Credit Amount");

        rec.SETFILTER("Entry No.", '<>%1', ApplyingGLEntAppEntry."Entry No.");
        rec.SETRANGE("G/L Account No.", ApplyingGLEntAppEntry."G/L Account No.");
        rec.SETRANGE(Open, TRUE);
        rec.SETFILTER("Remaining Amount", '<>%1', 0);

        IF ApplyingGLEntAppEntry."Debit Amount" <> 0 THEN
            rec.SETFILTER("Credit Amount", '<>%1', 0);
        IF ApplyingGLEntAppEntry."Credit Amount" <> 0 THEN
            rec.SETFILTER("Debit Amount", '<>%1', 0);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //IF CloseAction = ACTION::LookupOK THEN
        //LookupOKOnPush;
        //IF ApplnType = ApplnType::"Applies-to Doc. No." THEN BEGIN
        //IF OK AND (ApplyingGLEntAppEntry."Posting Date" < "Posting Date") THEN BEGIN
        //OK := FALSE;
        //ERROR(
        //EarlierPostingDateErr,ApplyingGLEntAppEntry."Document Type",ApplyingGLEntAppEntry."Document No.",
        //"Document Type","Document No.");
        //END;
        // IF OK THEN BEGIN
        // IF "Amount to Apply" = 0 THEN
        //END;

        //END;
        //END;
    end;

    var
        ApplyingGLEntAppEntry: Record 50057 temporary;
        AppliedGLEntAppEntry: Record 50057;
        Currency: Record 4;
        CurrExchRate: Record 330;
        GenJnlLine: Record 81;
        GenJnlLine2: Record 81;
        Cust: Record 18;
        GLEntryAppl: Record 50057;
        GLSetup: Record 98;
        CustEntrySetApplID: Codeunit 101;
        GenJnlApply: Codeunit 225;
        SalesPost: Codeunit 80;
        PaymentToleranceMgt: Codeunit 426;
        CustEntryEdit: Codeunit 103;
        Navigate: Page 344;
        AppliedAmount: Decimal;
        ApplyingAmount: Decimal;
        PmtDiscAmount: Decimal;
        ApplnDate: Date;
        ApplnCurrencyCode: Code[10];
        ApplnRoundingPrecision: Decimal;
        ApplnRounding: Decimal;
        ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
        AmountRoundingPrecision: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        StyleTxt: Text;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        CalcType: Option Direct,GenJnlLine,SalesHeader,ServHeader;
        CustEntryApplID: Code[50];
        ValidExchRate: Boolean;
        DifferentCurrenciesInAppln: Boolean;
        Text002: Label 'You must select an applying entry before you can post the application.';
        ShowAppliedEntries: Boolean;
        Text003: Label 'You must post the application from the window where you entered the applying entry.';
        CannotSetAppliesToIDErr: Label 'You cannot set Applies-to ID while selecting Applies-to Doc. No.';
        OK: Boolean;
        EarlierPostingDateErr: Label 'You cannot apply and post an entry to an entry with an earlier posting date.\\Instead, post the document of type %1 with the number %2 and then apply it to the document of type %3 with the number %4.';
        PostingDone: Boolean;
        //[InDataSet]
        "Applies-to IDVisible": Boolean;
        Text012: Label 'The application was successfully posted.';
        Text013: Label 'The %1 entered must not be before the %1 on the %2.';
        Text019: Label 'Post application process has been canceled.';
        ActionPerformed: Boolean;
        CannotSetRefundIDErr: Label 'You cannot apply entries from set Applies-to ID';
        CannotSetRefundOfflineErr: Label 'You cannot Re-apply GST Refund entries once it has been unapplied';
        TransactionType2: Option Purchase,Sales,Transfer,Service;
        InvoiceBase: Decimal;
        GSTWithTCSErr: Label 'You cannot apply documents that have TCS with GST.';
        CannotApplyClosedEntriesErr: Label 'One or more of the entries that you selected is closed. You cannot apply closed entries.';
        GLEntryApplID: Code[50];
        ApplyGLAppEntry: Page 50097;
        MustNotBeBeforeErr: Label 'The Posting Date entered must not be before the Posting Date on the Cust. Ledger Entry.';
        NoEntriesAppliedErr: Label 'Cannot post because you did not specify which entry to apply. You must specify an entry in the %1 field for one or more open entries.', Comment = '%1 - Caption of "Applies to ID" field of Gen. Journal Line';
        GLApplEntry: Record 50057;
        GLApplEntryPost: Record 50057;
        SelectionAppliedGLAppEnt: Record 50057;
        testcnt: Integer;
        testcnt1: Integer;
        SelectedAmountToApply: Decimal;
        AmountToApplyShow: Decimal;
        AppliedAmountShow: Decimal;

    //  [Scope('Internal')]
    procedure SetGenJnlLine(NewGenJnlLine: Record 81; ApplnTypeSelect: Integer)
    begin
        GenJnlLine := NewGenJnlLine;

        IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer THEN
            ApplyingAmount := GenJnlLine.Amount;
        IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN
            ApplyingAmount := -GenJnlLine.Amount;
        ApplnDate := GenJnlLine."Posting Date";
        ApplnCurrencyCode := GenJnlLine."Currency Code";
        CalcType := CalcType::GenJnlLine;

        CASE ApplnTypeSelect OF
            GenJnlLine.FIELDNO("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            GenJnlLine.FIELDNO("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        END;

        SetApplyingCustLedgEntry;
    end;

    // [Scope('Internal')]
    procedure SetGLEntryApplication(NewGLEntryAppl: Record 50057)
    begin
        Rec := NewGLEntryAppl;
    end;

    // [Scope('Internal')]
    procedure SetApplyingCustLedgEntry()
    var
        Customer: Record 18;
        "CustEntry-Edit": Codeunit 103;
    begin

        /*CASE CalcType OF
          CalcType::SalesHeader:
            BEGIN
              ApplyingCustLedgEntry."Entry No." := 1;
              ApplyingCustLedgEntry."Posting Date" := SalesHeader."Posting Date";
              IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" THEN
                ApplyingCustLedgEntry."Document Type" := SalesHeader."Document Type"::"Credit Memo"
              ELSE
                ApplyingCustLedgEntry."Document Type" := SalesHeader."Document Type";
              ApplyingCustLedgEntry."Document No." := SalesHeader."No.";
              ApplyingCustLedgEntry."Customer No." := SalesHeader."Bill-to Customer No.";
              ApplyingCustLedgEntry.Description := SalesHeader."Posting Description";
              ApplyingCustLedgEntry."Currency Code" := SalesHeader."Currency Code";
              IF ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::"Credit Memo" THEN  BEGIN
                ApplyingCustLedgEntry.Amount := -TotalSalesLine."Amount To Customer";
                ApplyingCustLedgEntry."Remaining Amount" := -TotalSalesLine."Amount To Customer";
              END ELSE BEGIN
                ApplyingCustLedgEntry.Amount := TotalSalesLine."Amount To Customer";
                ApplyingCustLedgEntry."Remaining Amount" := TotalSalesLine."Amount To Customer";
              END;
              CalcApplnAmount;
            END;
          CalcType::ServHeader:
            BEGIN
              ApplyingCustLedgEntry."Entry No." := 1;
              ApplyingCustLedgEntry."Posting Date" := ServHeader."Posting Date";
              ApplyingCustLedgEntry."Document Type" := ServHeader."Document Type";
              ApplyingCustLedgEntry."Document No." := ServHeader."No.";
              ApplyingCustLedgEntry."Customer No." := ServHeader."Bill-to Customer No.";
              ApplyingCustLedgEntry.Description := ServHeader."Posting Description";
              ApplyingCustLedgEntry."Currency Code" := ServHeader."Currency Code";
              IF ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::"Credit Memo" THEN  BEGIN
                ApplyingCustLedgEntry.Amount := -TotalServLine."Amount To Customer";
                ApplyingCustLedgEntry."Remaining Amount" := -TotalServLine."Amount To Customer";
              END ELSE BEGIN
                ApplyingCustLedgEntry.Amount := TotalServLine."Amount To Customer";
                ApplyingCustLedgEntry."Remaining Amount" := TotalServLine."Amount To Customer";
              END;
              CalcApplnAmount;
            END;
          CalcType::Direct:
            BEGIN
              IF "Applying Entry" THEN BEGIN
                IF ApplyingCustLedgEntry."Entry No." <> 0 THEN
                  CustLedgEntry := ApplyingCustLedgEntry;
                "CustEntry-Edit".RUN(Rec);
                IF "Applies-to ID" = '' THEN
                  SetCustApplId;
                CALCFIELDS(Amount);
                ApplyingCustLedgEntry := Rec;
                IF CustLedgEntry."Entry No." <> 0 THEN BEGIN
                  Rec := CustLedgEntry;
                  "Applying Entry" := FALSE;
                  SetCustApplId;
                END;
                SETFILTER("Entry No.",'<> %1',ApplyingCustLedgEntry."Entry No.");
                ApplyingAmount := ApplyingCustLedgEntry."Remaining Amount";
                ApplnDate := ApplyingCustLedgEntry."Posting Date";
                ApplnCurrencyCode := ApplyingCustLedgEntry."Currency Code";
              END;
              CalcApplnAmount;
            END;
          CalcType::GenJnlLine:
            BEGIN
              ApplyingCustLedgEntry."Entry No." := 1;
              ApplyingCustLedgEntry."Posting Date" := GenJnlLine."Posting Date";
              ApplyingCustLedgEntry."Document Type" := GenJnlLine."Document Type";
              ApplyingCustLedgEntry."Document No." := GenJnlLine."Document No.";
              IF GenJnlLine."Bal. Account Type" = GenJnlLine."Account Type"::Customer THEN BEGIN
                ApplyingCustLedgEntry."Customer No." := GenJnlLine."Bal. Account No.";
                Customer.GET(ApplyingCustLedgEntry."Customer No.");
                ApplyingCustLedgEntry.Description := Customer.Name;
              END ELSE BEGIN
                ApplyingCustLedgEntry."Customer No." := GenJnlLine."Account No.";
                ApplyingCustLedgEntry.Description := GenJnlLine.Description;
              END;
              ApplyingCustLedgEntry."Currency Code" := GenJnlLine."Currency Code";
              ApplyingCustLedgEntry.Amount := GenJnlLine.Amount;
              ApplyingCustLedgEntry."Remaining Amount" := GenJnlLine.Amount;
              CalcApplnAmount;
            END;
        END;
        */

    end;

    //[Scope('Internal')]
    procedure SetCustApplId()
    var
        CustLedgerEntry: Record 21;
    begin
        /*
        IF (CalcType = CalcType::GenJnlLine) AND (ApplyingCustLedgEntry."Posting Date" < "Posting Date") THEN
          ERROR(
            EarlierPostingDateErr,ApplyingCustLedgEntry."Document Type",ApplyingCustLedgEntry."Document No.",
            "Document Type","Document No.");
        
        IF ApplyingCustLedgEntry."Entry No." <> 0 THEN
          GenJnlApply.CheckAgainstApplnCurrency(
            ApplnCurrencyCode,"Currency Code",GenJnlLine."Account Type"::Customer,TRUE);
        
        CustLedgEntry.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(CustLedgEntry);
        IF "Applies-to ID" = '' THEN BEGIN
          CASE CalcType OF
            CalcType::SalesHeader :
              IF "GST on Advance Payment" THEN
                CustEntrySetApplID.SetGSTType(SalesHeader);
            CalcType::ServHeader :
              IF "GST on Advance Payment" THEN
                CustEntrySetApplID.SetGSTTypeService(ServHeader);
            CalcType::GenJnlLine :
              IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN
                CustEntrySetApplID.SetRefund;
          END;
        END;
        CustEntrySetApplID.SetApplId(CustLedgEntry,ApplyingCustLedgEntry,GetAppliesToID);
        ActionPerformed := CustLedgEntry."Applies-to ID" <> '';
        CalcApplnAmount;
        */

    end;

    local procedure GetAppliesToID() AppliesToID: Code[50]
    begin
        /*
        CASE CalcType OF
          CalcType::GenJnlLine:
            AppliesToID := GenJnlLine."Applies-to ID";
          CalcType::SalesHeader:
            AppliesToID := SalesHeader."Applies-to ID";
          CalcType::ServHeader:
            AppliesToID := ServHeader."Applies-to ID";
        END;
        */

    end;

    //[Scope('Internal')]
    procedure CalcApplnAmount()
    var
        ExchAccGLJnlLine: Codeunit 366;
    begin

        /*AppliedAmount := 0;
        PmtDiscAmount := 0;
        DifferentCurrenciesInAppln := FALSE;
        
        CASE CalcType OF
          CalcType::Direct:
            BEGIN
              FindAmountRounding;
              CustEntryApplID := USERID;
              IF CustEntryApplID = '' THEN
                CustEntryApplID := '***';
        
              CustLedgEntry := ApplyingCustLedgEntry;
        
              AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
              AppliedCustLedgEntry.SETRANGE("Customer No.","Customer No.");
              AppliedCustLedgEntry.SETRANGE(Open,TRUE);
              AppliedCustLedgEntry.SETRANGE("Applies-to ID",CustEntryApplID);
        
              IF ApplyingCustLedgEntry."Entry No." <> 0 THEN BEGIN
                CustLedgEntry.CALCFIELDS("Remaining Amount");
                AppliedCustLedgEntry.SETFILTER("Entry No.",'<>%1',ApplyingCustLedgEntry."Entry No.");
              END;
        
              HandlChosenEntries(0,
                CustLedgEntry."Remaining Amount",
                CustLedgEntry."Currency Code",
                CustLedgEntry."Posting Date");
            END;
          CalcType::GenJnlLine:
            BEGIN
              FindAmountRounding;
              IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN
                ExchAccGLJnlLine.RUN(GenJnlLine);
        
              CASE ApplnType OF
                ApplnType::"Applies-to Doc. No.":
                  BEGIN
                    AppliedCustLedgEntry := Rec;
                    WITH AppliedCustLedgEntry DO BEGIN
                      CALCFIELDS("Remaining Amount");
                      IF "Currency Code" <> ApplnCurrencyCode THEN BEGIN
                        "Remaining Amount" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Amount");
                        "Remaining Pmt. Disc. Possible" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Pmt. Disc. Possible");
                        "Amount to Apply" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Amount to Apply");
                      END;
        
                      IF "Amount to Apply" <> 0 THEN
                        AppliedAmount := ROUND("Amount to Apply",AmountRoundingPrecision)
                      ELSE
                        AppliedAmount := ROUND("Remaining Amount",AmountRoundingPrecision);
        
                      IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(
                           GenJnlLine,AppliedCustLedgEntry,0,FALSE) AND
                         ((ABS(GenJnlLine.Amount) + ApplnRoundingPrecision >=
                           ABS(AppliedAmount - "Remaining Pmt. Disc. Possible")) OR
                          (GenJnlLine.Amount = 0))
                      THEN
                        PmtDiscAmount := "Remaining Pmt. Disc. Possible";
        
                      IF NOT DifferentCurrenciesInAppln THEN
                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";
                    END;
                    CheckRounding;
                  END;
                ApplnType::"Applies-to ID":
                  BEGIN
                    GenJnlLine2 := GenJnlLine;
                    AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                    AppliedCustLedgEntry.SETRANGE("Customer No.",GenJnlLine."Account No.");
                    AppliedCustLedgEntry.SETRANGE(Open,TRUE);
                    AppliedCustLedgEntry.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");
        
                    HandlChosenEntries(1,
                      GenJnlLine2.Amount,
                      GenJnlLine2."Currency Code",
                      GenJnlLine2."Posting Date");
                  END;
              END;
            END;
          CalcType::SalesHeader,CalcType::ServHeader:
            BEGIN
              FindAmountRounding;
        
              CASE ApplnType OF
                ApplnType::"Applies-to Doc. No.":
                  BEGIN
                    AppliedCustLedgEntry := Rec;
                    WITH AppliedCustLedgEntry DO BEGIN
                      CALCFIELDS("Remaining Amount");
        
                      IF "Currency Code" <> ApplnCurrencyCode THEN
                        "Remaining Amount" :=
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            ApplnDate,"Currency Code",ApplnCurrencyCode,"Remaining Amount");
        
                      AppliedAmount := ROUND("Remaining Amount",AmountRoundingPrecision);
        
                      IF NOT DifferentCurrenciesInAppln THEN
                        DifferentCurrenciesInAppln := ApplnCurrencyCode <> "Currency Code";
                    END;
                    CheckRounding;
                  END;
                ApplnType::"Applies-to ID":
                  BEGIN
                    AppliedCustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive);
                    IF CalcType = CalcType::SalesHeader THEN
                      AppliedCustLedgEntry.SETRANGE("Customer No.",SalesHeader."Bill-to Customer No.")
                    ELSE
                      AppliedCustLedgEntry.SETRANGE("Customer No.",ServHeader."Bill-to Customer No.");
                    AppliedCustLedgEntry.SETRANGE(Open,TRUE);
                    AppliedCustLedgEntry.SETRANGE("Applies-to ID",GetAppliesToID);
        
                    HandlChosenEntries(2,
                      ApplyingAmount,
                      ApplnCurrencyCode,
                      ApplnDate);
                  END;
              END;
            END;
        END;
        */

    end;

    local procedure CalcApplnRemainingAmount(Amount: Decimal): Decimal
    var
        ApplnRemainingAmount: Decimal;
    begin
        /*
        ValidExchRate := TRUE;
        IF ApplnCurrencyCode = "Currency Code" THEN
          EXIT(Amount);
        
        IF ApplnDate = 0D THEN
          ApplnDate := "Posting Date";
        ApplnRemainingAmount :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate,"Currency Code",ApplnCurrencyCode,Amount,ValidExchRate);
        EXIT(ApplnRemainingAmount);
        */
        ApplnRemainingAmount := Amount;
        EXIT(ApplnRemainingAmount);

    end;

    local procedure CalcApplnAmounttoApply(AmounttoApply: Decimal): Decimal
    var
        ApplnAmounttoApply: Decimal;
    begin
        /*
        ValidExchRate := TRUE;
        
        IF ApplnCurrencyCode = "Currency Code" THEN
          EXIT(AmounttoApply);
        
        IF ApplnDate = 0D THEN
          ApplnDate := "Posting Date";
        ApplnAmounttoApply :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate,"Currency Code",ApplnCurrencyCode,AmounttoApply,ValidExchRate);
        EXIT(ApplnAmounttoApply);
        */

    end;

    local procedure FindAmountRounding()
    begin
        IF ApplnCurrencyCode = '' THEN BEGIN
            Currency.INIT;
            Currency.Code := '';
            Currency.InitRoundingPrecision;
        END ELSE
            IF ApplnCurrencyCode <> Currency.Code THEN
                Currency.GET(ApplnCurrencyCode);

        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    end;

    local procedure CheckRounding()
    begin
        /*
        ApplnRounding := 0;
        
        CASE CalcType OF
          CalcType::SalesHeader,CalcType::ServHeader:
            EXIT;
          CalcType::GenJnlLine:
            IF (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) AND
               (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Refund)
            THEN
              EXIT;
        END;
        
        IF ApplnCurrencyCode = '' THEN
          ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision"
        ELSE BEGIN
          IF ApplnCurrencyCode <> "Currency Code" THEN
            Currency.GET(ApplnCurrencyCode);
          ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
        END;
        
        IF (ABS((AppliedAmount - PmtDiscAmount) + ApplyingAmount) <= ApplnRoundingPrecision) AND DifferentCurrenciesInAppln THEN
          ApplnRounding := -((AppliedAmount - PmtDiscAmount) + ApplyingAmount);
        */

    end;

    // [Scope('Internal')]
    procedure GetCustLedgEntry(var CustLedgEntry: Record 21)
    begin
        //CustLedgEntry := Rec;
    end;

    local procedure FindApplyingEntry()
    begin
        /*
        IF CalcType = CalcType::Direct THEN BEGIN
          CustEntryApplID := USERID;
          IF CustEntryApplID = '' THEN
            CustEntryApplID := '***';
        
          CustLedgEntry.SETCURRENTKEY("Customer No.","Applies-to ID",Open);
          CustLedgEntry.SETRANGE("Customer No.","Customer No.");
          CustLedgEntry.SETRANGE("Applies-to ID",CustEntryApplID);
          CustLedgEntry.SETRANGE(Open,TRUE);
          CustLedgEntry.SETRANGE("Applying Entry",TRUE);
          IF CustLedgEntry.FINDFIRST THEN BEGIN
            CustLedgEntry.CALCFIELDS(Amount,"Remaining Amount");
            ApplyingCustLedgEntry := CustLedgEntry;
            SETFILTER("Entry No.",'<>%1',CustLedgEntry."Entry No.");
            ApplyingAmount := CustLedgEntry."Remaining Amount";
            ApplnDate := CustLedgEntry."Posting Date";
            ApplnCurrencyCode := CustLedgEntry."Currency Code";
          END;
          CalcApplnAmount;
        END;
        */

    end;

    local procedure HandlChosenEntries(Type: Option Direct,GenJnlLine,SalesHeader; CurrentAmount: Decimal; CurrencyCode: Code[10]; "Posting Date": Date)
    var
        AppliedCustLedgEntryTemp: Record 21 temporary;
        PossiblePmtDisc: Decimal;
        OldPmtDisc: Decimal;
        CorrectionAmount: Decimal;
        RemainingAmountExclDiscounts: Decimal;
        CanUseDisc: Boolean;
        FromZeroGenJnl: Boolean;
    begin
        /*
        IF AppliedCustLedgEntry.FINDSET(FALSE,FALSE) THEN BEGIN
          REPEAT
            AppliedCustLedgEntryTemp := AppliedCustLedgEntry;
            AppliedCustLedgEntryTemp.INSERT;
          UNTIL AppliedCustLedgEntry.NEXT = 0;
        END ELSE
          EXIT;
        
        FromZeroGenJnl := (CurrentAmount = 0) AND (Type = Type::GenJnlLine);
        
        REPEAT
          IF NOT FromZeroGenJnl THEN
            AppliedCustLedgEntryTemp.SETRANGE(Positive,CurrentAmount < 0);
          IF AppliedCustLedgEntryTemp.FINDFIRST THEN BEGIN
            ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedCustLedgEntryTemp,"Posting Date");
        
            CASE Type OF
              Type::Direct:
                CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscCust(CustLedgEntry,AppliedCustLedgEntryTemp,0,FALSE,FALSE);
              Type::GenJnlLine:
                CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(GenJnlLine2,AppliedCustLedgEntryTemp,0,FALSE)
              ELSE
                CanUseDisc := FALSE;
            END;
        
            IF CanUseDisc AND
               (ABS(AppliedCustLedgEntryTemp."Amount to Apply") >= ABS(AppliedCustLedgEntryTemp."Remaining Amount" -
                  AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible"))
            THEN BEGIN
              IF (ABS(CurrentAmount) > ABS(AppliedCustLedgEntryTemp."Remaining Amount" -
                    AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible"))
              THEN BEGIN
                PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
                CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
                  AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
              END ELSE
                IF (ABS(CurrentAmount) = ABS(AppliedCustLedgEntryTemp."Remaining Amount" -
                      AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible"))
                THEN BEGIN
                  PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible" + PossiblePmtDisc;
                  CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
                    AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible" - PossiblePmtDisc;
                  PossiblePmtDisc := 0;
                  AppliedAmount := AppliedAmount + CorrectionAmount;
                END ELSE
                  IF FromZeroGenJnl THEN BEGIN
                    PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
                    CurrentAmount := CurrentAmount +
                      AppliedCustLedgEntryTemp."Remaining Amount" - AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
                  END ELSE BEGIN
                    PossiblePmtDisc := AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
                    RemainingAmountExclDiscounts := AppliedCustLedgEntryTemp."Remaining Amount" - PossiblePmtDisc -
                      AppliedCustLedgEntryTemp."Max. Payment Tolerance";
                    IF ABS(CurrentAmount) + ABS(CalcOppositeEntriesAmount(AppliedCustLedgEntryTemp)) >= ABS(RemainingAmountExclDiscounts)
                    THEN BEGIN
                      PmtDiscAmount := PmtDiscAmount + PossiblePmtDisc;
                      AppliedAmount := AppliedAmount + CorrectionAmount;
                    END;
                    CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Remaining Amount" -
                      AppliedCustLedgEntryTemp."Remaining Pmt. Disc. Possible";
                  END;
            END ELSE BEGIN
              IF ((CurrentAmount - PossiblePmtDisc + AppliedCustLedgEntryTemp."Amount to Apply") * CurrentAmount) <= 0 THEN
                AppliedAmount := AppliedAmount + CorrectionAmount;
              CurrentAmount := CurrentAmount + AppliedCustLedgEntryTemp."Amount to Apply";
            END;
          END ELSE BEGIN
            AppliedCustLedgEntryTemp.SETRANGE(Positive);
            AppliedCustLedgEntryTemp.FINDFIRST;
            ExchangeAmountsOnLedgerEntry(Type,CurrencyCode,AppliedCustLedgEntryTemp,"Posting Date");
          END;
        
          IF OldPmtDisc <> PmtDiscAmount THEN
            AppliedAmount := AppliedAmount + AppliedCustLedgEntryTemp."Remaining Amount"
          ELSE
            AppliedAmount := AppliedAmount + AppliedCustLedgEntryTemp."Amount to Apply";
          OldPmtDisc := PmtDiscAmount;
        
          IF PossiblePmtDisc <> 0 THEN
            CorrectionAmount := AppliedCustLedgEntryTemp."Remaining Amount" - AppliedCustLedgEntryTemp."Amount to Apply"
          ELSE
            CorrectionAmount := 0;
        
          IF NOT DifferentCurrenciesInAppln THEN
            DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedCustLedgEntryTemp."Currency Code";
        
          AppliedCustLedgEntryTemp.DELETE;
          AppliedCustLedgEntryTemp.SETRANGE(Positive);
        
        UNTIL NOT AppliedCustLedgEntryTemp.FINDFIRST;
        CheckRounding;
        */

    end;

    local procedure AmounttoApplyOnAfterValidate()
    begin
        IF ApplnType <> ApplnType::"Applies-to Doc. No." THEN BEGIN
            CalcApplnAmount;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure RecalcApplnAmount()
    begin
        CurrPage.UPDATE(TRUE);
        CalcApplnAmount;
    end;

    local procedure LookupOKOnPush()
    begin
        OK := TRUE;
    end;

    local procedure PostDirectApplication()
    var
        PostApplication: Page 579;
        ApplicationDate: Date;
        NewApplicationDate: Date;
        NewDocumentNo: Code[20];
        ApplyToGLApplEntry: Record 50057;
    begin
        IF ApplyingGLEntAppEntry."Entry No." <> 0 THEN BEGIN
            CLEAR(SelectionAppliedGLAppEnt);
            SelectionAppliedGLAppEnt.COPY(Rec);
            CurrPage.SETSELECTIONFILTER(SelectionAppliedGLAppEnt);

            CLEAR(SelectedAmountToApply);
            IF SelectionAppliedGLAppEnt.FINDSET THEN
                REPEAT
                    SelectionAppliedGLAppEnt.TESTFIELD("Applies-to ID");
                    SelectedAmountToApply += ABS(SelectionAppliedGLAppEnt."Amount to Apply");
                UNTIL SelectionAppliedGLAppEnt.NEXT = 0;

            IF SelectedAmountToApply > ABS(ApplyingGLEntAppEntry."Remaining Amount") THEN
                ERROR('Amount to Apply=%1 should not be greater than remaining amount=%2', SelectedAmountToApply, ApplyingGLEntAppEntry."Remaining Amount");

            AppliedGLEntAppEntry := Rec;
            Rec := ApplyingGLEntAppEntry;
            ApplicationDate := GetApplicationDate(Rec);

            PostApplication.SetValues(rec."Document No.", ApplicationDate);
            IF ACTION::OK = PostApplication.RUNMODAL THEN BEGIN
                PostApplication.GetValues(NewDocumentNo, NewApplicationDate);
                IF NewApplicationDate < ApplicationDate THEN
                    ERROR(Text013, rec.FIELDCAPTION("Posting Date"), rec.TABLECAPTION);
            END ELSE
                ERROR(Text019);

            IF NewApplicationDate = 0D THEN
                NewApplicationDate := GetApplicationDate(Rec)
            ELSE
                IF NewApplicationDate < GetApplicationDate(Rec) THEN
                    ERROR(MustNotBeBeforeErr);

            IF NewDocumentNo = '' THEN
                NewDocumentNo := Rec."Document No.";

            //CLEAR(GLApplEntryPost);
            //GLApplEntryPost.COPY(Rec);
            //CurrPage.SETSELECTIONFILTER(GLApplEntryPost);

            IF SelectionAppliedGLAppEnt.FINDSET THEN
                REPEAT
                    GLApplPostApplyGLApplEntry(Rec, SelectionAppliedGLAppEnt, NewDocumentNo, NewApplicationDate);
                UNTIL SelectionAppliedGLAppEnt.NEXT = 0;

            MESSAGE(Text012);
            PostingDone := TRUE;
            CurrPage.CLOSE;
        END ELSE
            ERROR(Text002);
    end;

    // [Scope('Internal')]
    procedure GetApplicationDate(GLApplEntry: Record 50057) ApplicationDate: Date
    var
        ApplyToGLApplEntry: Record 50057;
    begin
        WITH GLApplEntry DO BEGIN
            ApplicationDate := 0D;
            ApplyToGLApplEntry.SETCURRENTKEY("G/L Account No.", "Applies-to ID");
            ApplyToGLApplEntry.SETRANGE("G/L Account No.", rec."G/L Account No.");
            ApplyToGLApplEntry.SETRANGE("Applies-to ID", rec."Applies-to ID");
            ApplyToGLApplEntry.FINDSET;
            REPEAT
                IF ApplyToGLApplEntry."Posting Date" > ApplicationDate THEN
                    ApplicationDate := ApplyToGLApplEntry."Posting Date";
            UNTIL ApplyToGLApplEntry.NEXT = 0;
        END;
    end;

    local procedure GLApplPostApplyGLApplEntry(var NewGLApplEntry: Record 50057; var NewSelectionAppliedGLAppEnt: Record "50057"; DocumentNo: Code[20]; ApplicationDate: Date)
    var
        SourceCodeSetup: Record 242;
        GenJnlLine: Record 81;
        UpdateAnalysisView: Codeunit 410;
        GenJnlPostLine: Codeunit 12;
        GenJnlPostPreview: Codeunit 19;
        Window: Dialog;
        EntryNoBeforeApplication: Integer;
        EntryNoAfterApplication: Integer;
    begin
        WITH NewGLApplEntry DO BEGIN
            //Window.OPEN(PostingApplicationMsg);

            EntryNoBeforeApplication := FindLastApplDtldCustLedgEntry;

            InsertDetailGLApplicationEntry(NewGLApplEntry, NewSelectionAppliedGLAppEnt);
            InsertDetailGLAppliedEntry(NewGLApplEntry, NewSelectionAppliedGLAppEnt);
            NewGLApplEntry.CALCFIELDS("Remaining Amount", Amount);
            NewGLApplEntry."Applied Amount" := NewGLApplEntry.Amount - NewGLApplEntry."Remaining Amount";
            IF NewGLApplEntry."Remaining Amount" = 0 THEN
                NewGLApplEntry.Open := FALSE
            ELSE
                NewGLApplEntry.Open := TRUE;
            NewGLApplEntry.MODIFY;
            NewSelectionAppliedGLAppEnt.CALCFIELDS("Remaining Amount", Amount);
            NewSelectionAppliedGLAppEnt."Applied Amount" := NewSelectionAppliedGLAppEnt.Amount - NewSelectionAppliedGLAppEnt."Remaining Amount";
            IF NewSelectionAppliedGLAppEnt."Remaining Amount" = 0 THEN
                NewSelectionAppliedGLAppEnt.Open := FALSE
            ELSE
                NewSelectionAppliedGLAppEnt.Open := TRUE;
            NewSelectionAppliedGLAppEnt.MODIFY;

            EntryNoAfterApplication := FindLastApplDtldCustLedgEntry;
            IF EntryNoAfterApplication = EntryNoBeforeApplication THEN
                ERROR(STRSUBSTNO(NoEntriesAppliedErr, GenJnlLine.FIELDCAPTION("Applies-to ID")));

            COMMIT;
            //Window.CLOSE;
        END;
    end;

    local procedure FindLastApplDtldCustLedgEntry(): Integer
    var
        DtldGLApplEntry: Record 50058;
    begin
        DtldGLApplEntry.LOCKTABLE;
        IF DtldGLApplEntry.FINDLAST THEN
            EXIT(DtldGLApplEntry."Entry No.");

        EXIT(0);
    end;

    local procedure InsertDetailGLApplicationEntry(GLEntryAppl: Record 50057; AppliedGLEntSelect: Record 50057)
    var
        DetailGLApplEntry: Record 50058;
    begin
        DetailGLApplEntry.INIT;
        DetailGLApplEntry."G/L Application Entry No." := GLEntryAppl."Entry No.";
        DetailGLApplEntry."Entry Type" := DetailGLApplEntry."Entry Type"::Application;
        DetailGLApplEntry."Posting Date" := GLEntryAppl."Posting Date";
        DetailGLApplEntry."Document Type" := GLEntryAppl."Document Type";
        DetailGLApplEntry."Document No." := GLEntryAppl."Document No.";
        IF (ABS(AppliedGLEntSelect."Remaining Amount") >= ABS(AppliedGLEntSelect."Amount to Apply")) AND
              (ABS(AppliedGLEntSelect."Remaining Amount") <= ABS(GLEntryAppl."Remaining Amount")) THEN BEGIN
            DetailGLApplEntry.Amount := AppliedGLEntSelect."Amount to Apply";
            DetailGLApplEntry."Amount (LCY)" := AppliedGLEntSelect."Amount to Apply";
            AppliedGLEntSelect.CALCFIELDS("Debit Amount", "Credit Amount");
            IF AppliedGLEntSelect."Debit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Debit Amount" := AppliedGLEntSelect."Amount to Apply";
                DetailGLApplEntry."Debit Amount (LCY)" := AppliedGLEntSelect."Amount to Apply";
            END;
            IF AppliedGLEntSelect."Credit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Credit Amount" := AppliedGLEntSelect."Amount to Apply";
                DetailGLApplEntry."Credit Amount (LCY)" := AppliedGLEntSelect."Amount to Apply";
            END;
        END;
        IF (ABS(AppliedGLEntSelect."Remaining Amount") >= ABS(AppliedGLEntSelect."Amount to Apply")) AND
              (ABS(AppliedGLEntSelect."Remaining Amount") > ABS(GLEntryAppl."Remaining Amount")) THEN BEGIN
            DetailGLApplEntry.Amount := -GLEntryAppl."Remaining Amount";
            DetailGLApplEntry."Amount (LCY)" := -GLEntryAppl."Remaining Amount";
            AppliedGLEntSelect.CALCFIELDS("Debit Amount", "Credit Amount");
            IF AppliedGLEntSelect."Debit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Debit Amount" := ABS(GLEntryAppl."Remaining Amount");
                DetailGLApplEntry."Debit Amount (LCY)" := ABS(GLEntryAppl."Remaining Amount");
            END;
            IF AppliedGLEntSelect."Credit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Credit Amount" := GLEntryAppl."Remaining Amount";
                DetailGLApplEntry."Credit Amount (LCY)" := GLEntryAppl."Remaining Amount";
            END;
        END;
        DetailGLApplEntry."G/L Account No." := GLEntryAppl."G/L Account No.";
        DetailGLApplEntry."User ID" := GLEntryAppl."User ID";
        DetailGLApplEntry."Source Code" := GLEntryAppl."Source Code";
        DetailGLApplEntry."Transaction No." := GLEntryAppl."Transaction No.";
        DetailGLApplEntry."Initial Entry Global Dim. 1" := GLEntryAppl."Global Dimension 1 Code";
        DetailGLApplEntry."Initial Entry Global Dim. 2" := GLEntryAppl."Global Dimension 2 Code";
        DetailGLApplEntry."Gen. Bus. Posting Group" := GLEntryAppl."Gen. Bus. Posting Group";
        DetailGLApplEntry."Gen. Prod. Posting Group" := GLEntryAppl."Gen. Prod. Posting Group";
        DetailGLApplEntry."VAT Bus. Posting Group" := GLEntryAppl."VAT Bus. Posting Group";
        DetailGLApplEntry."VAT Prod. Posting Group" := GLEntryAppl."VAT Prod. Posting Group";
        DetailGLApplEntry."Initial Document Type" := GLEntryAppl."Document Type";
        DetailGLApplEntry."Applied G/L Appl Entry No." := AppliedGLEntSelect."Entry No.";
        DetailGLApplEntry.INSERT;
    end;

    local procedure InsertDetailGLAppliedEntry(GLEntryAppl: Record 50057; AppliedGLAppEntSelectNew: Record 50057)
    var
        DetailGLApplEntry: Record 50058;
    begin
        DetailGLApplEntry.INIT;
        DetailGLApplEntry."G/L Application Entry No." := AppliedGLAppEntSelectNew."Entry No.";
        DetailGLApplEntry."Entry Type" := DetailGLApplEntry."Entry Type"::Application;
        DetailGLApplEntry."Posting Date" := GLEntryAppl."Posting Date";
        DetailGLApplEntry."Document Type" := GLEntryAppl."Document Type";
        DetailGLApplEntry."Document No." := GLEntryAppl."Document No.";
        IF (ABS(AppliedGLAppEntSelectNew."Remaining Amount") >= ABS(AppliedGLAppEntSelectNew."Amount to Apply")) AND
              (ABS(AppliedGLAppEntSelectNew."Remaining Amount") <= ABS(GLEntryAppl."Remaining Amount")) THEN BEGIN
            DetailGLApplEntry.Amount := -AppliedGLAppEntSelectNew."Amount to Apply";
            DetailGLApplEntry."Amount (LCY)" := -AppliedGLAppEntSelectNew."Amount to Apply";
            IF GLEntryAppl."Debit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Debit Amount" := ABS(AppliedGLAppEntSelectNew."Amount to Apply");
                DetailGLApplEntry."Debit Amount (LCY)" := ABS(AppliedGLAppEntSelectNew."Amount to Apply");
            END;
            IF GLEntryAppl."Credit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Credit Amount" := ABS(AppliedGLAppEntSelectNew."Amount to Apply");
                DetailGLApplEntry."Credit Amount (LCY)" := ABS(AppliedGLAppEntSelectNew."Amount to Apply");
            END;
        END;
        IF (ABS(AppliedGLAppEntSelectNew."Remaining Amount") >= ABS(AppliedGLAppEntSelectNew."Amount to Apply")) AND
              (ABS(AppliedGLAppEntSelectNew."Remaining Amount") > ABS(GLEntryAppl."Remaining Amount")) THEN BEGIN
            DetailGLApplEntry.Amount := GLEntryAppl."Remaining Amount";
            DetailGLApplEntry."Amount (LCY)" := GLEntryAppl."Remaining Amount";
            IF GLEntryAppl."Debit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Debit Amount" := ABS(GLEntryAppl."Remaining Amount");
                DetailGLApplEntry."Debit Amount (LCY)" := ABS(GLEntryAppl."Remaining Amount");
            END;
            IF GLEntryAppl."Credit Amount" <> 0 THEN BEGIN
                DetailGLApplEntry."Credit Amount" := ABS(GLEntryAppl."Remaining Amount");
                DetailGLApplEntry."Credit Amount (LCY)" := ABS(GLEntryAppl."Remaining Amount");
            END;
        END;
        DetailGLApplEntry."G/L Account No." := GLEntryAppl."G/L Account No.";
        DetailGLApplEntry."User ID" := GLEntryAppl."User ID";
        DetailGLApplEntry."Source Code" := GLEntryAppl."Source Code";
        DetailGLApplEntry."Transaction No." := GLEntryAppl."Transaction No.";
        DetailGLApplEntry."Initial Entry Global Dim. 1" := GLEntryAppl."Global Dimension 1 Code";
        DetailGLApplEntry."Initial Entry Global Dim. 2" := GLEntryAppl."Global Dimension 2 Code";
        DetailGLApplEntry."Gen. Bus. Posting Group" := GLEntryAppl."Gen. Bus. Posting Group";
        DetailGLApplEntry."Gen. Prod. Posting Group" := GLEntryAppl."Gen. Prod. Posting Group";
        DetailGLApplEntry."VAT Bus. Posting Group" := GLEntryAppl."VAT Bus. Posting Group";
        DetailGLApplEntry."VAT Prod. Posting Group" := GLEntryAppl."VAT Prod. Posting Group";
        DetailGLApplEntry."Initial Document Type" := GLEntryAppl."Document Type";
        DetailGLApplEntry."Applied G/L Appl Entry No." := GLEntryAppl."Entry No.";
        DetailGLApplEntry.INSERT;
    end;
}


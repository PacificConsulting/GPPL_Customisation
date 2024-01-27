page 60113 "Payroll Journal"
{
    AutoSplitKey = true;
    Caption = 'General Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = 81;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = all;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(control1)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                // field("Consignment Note No."; rec."Consignment Note No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Declaration Form (GTA)"; rec."Declaration Form (GTA)")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Party Type"; rec."Party Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Party Code"; rec."Party Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Account Type"; rec."Account Type")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("T.A.N. No."; rec."T.A.N. No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field("E.C.C. No."; rec."E.C.C. No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Cheque No."; rec."Cheque No.")
                {
                    ApplicationArea = all;
                }
                field("Cheque Date"; rec."Cheque Date")
                {
                    ApplicationArea = all;
                }
                // field("TDS Nature of Deduction"; rec."TDS Nature of Deduction")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Assessee Code"; rec."Assessee Code")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("TDS/TCS %"; rec."TDS/TCS %")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("TDS/TCS Amount"; rec."TDS/TCS Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Surcharge %"; rec."Surcharge %")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Surcharge Amount"; rec."Surcharge Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("eCESS %"; rec."eCESS %")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("eCESS on TDS/TCS Amount"; rec."eCESS on TDS/TCS Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Total TDS/TCS Incl. SHE CESS"; rec."Total TDS/TCS Incl. SHE CESS")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                field("Work Tax Nature Of Deduction"; rec."Work Tax Nature Of Deduction")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field("Work Tax Base Amount"; rec."Work Tax Base Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Work Tax %"; rec."Work Tax %")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Work Tax Amount"; rec."Work Tax Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field(PLA; rec.PLA)
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Excise Charge"; rec."Excise Charge")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field(Deferred; rec.Deferred)
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                field("Business Unit Code"; rec."Business Unit Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Campaign No."; rec."Campaign No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        /*
                        ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                        */
                    end;
                }
                field("Gen. Posting Type"; rec."Gen. Posting Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Debit Amount"; rec."Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount"; rec."Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("VAT Amount"; rec."VAT Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VAT Difference"; rec."VAT Difference")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bal. VAT Amount"; rec."Bal. VAT Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bal. VAT Difference"; rec."Bal. VAT Difference")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Bal. Gen. Posting Type"; rec."Bal. Gen. Posting Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bal. Gen. Bus. Posting Group"; rec."Bal. Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bal. Gen. Prod. Posting Group"; rec."Bal. Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bal. VAT Bus. Posting Group"; rec."Bal. VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bal. VAT Prod. Posting Group"; rec."Bal. VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to/Pay-to No."; rec."Bill-to/Pay-to No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to/Order Address Code"; rec."Ship-to/Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("On Hold"; "On Hold")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bank Payment Type"; "Bank Payment Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            group(General)
            {
                field(AccName; AccName)
                {
                    ApplicationArea = all;
                    Caption = 'Account Name';
                    Editable = false;
                }
                field(BalAccName; BalAccName)
                {
                    ApplicationArea = all;
                    Caption = 'Bal. Account Name';
                    Editable = false;
                }
                field(Balance; Balance + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = all;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Visible = BalanceVisible;
                }
                field(TotalBalance; TotalBalance + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    ApplicationArea = all;
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Visible = TotalBalanceVisible;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Codeunit 15;
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = all;
                    Caption = 'Ledger E&ntries';
                    RunObject = Codeunit 14;
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    RunObject = Codeunit 225;
                    ShortCutKey = 'Shift+F11';
                }
                action("Insert Conv. LCY Rndg. Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    RunObject = Codeunit 407;
                }
                separator("-")
                {
                    Caption = '-';
                }
                action("&Get Standard Journals")
                {
                    ApplicationArea = all;
                    Caption = '&Get Standard Journals';
                    Ellipsis = true;
                    Image = GetStandardJournal;

                    trigger OnAction()
                    var
                        StdGenJnl: Record "750";
                    begin
                        StdGenJnl.FILTERGROUP := 2;
                        StdGenJnl.SETRANGE("Journal Template Name", "Journal Template Name");
                        StdGenJnl.FILTERGROUP := 0;

                        IF PAGE.RUNMODAL(PAGE::"Standard General Journals", StdGenJnl) = ACTION::LookupOK THEN BEGIN
                            StdGenJnl.CreateGenJnlFromStdJnl(StdGenJnl, CurrentJnlBatchName);
                            MESSAGE(Text000, StdGenJnl.Code);
                        END;

                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action("&Save as Standard Journal")
                {
                    Caption = '&Save as Standard Journal';
                    Ellipsis = true;
                    Image = SaveasStandardJournal;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        GenJnlBatch: Record "232";
                        GeneralJnlLines: Record "81";
                        StdGenJnl: Record "750";
                        SaveAsStdGenJnl: Report "750";
                    begin
                        GeneralJnlLines.SETFILTER("Journal Template Name", "Journal Template Name");
                        GeneralJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(GeneralJnlLines);
                        GeneralJnlLines.COPYFILTERS(Rec);

                        GenJnlBatch.GET("Journal Template Name", CurrentJnlBatchName);
                        SaveAsStdGenJnl.Initialise(GeneralJnlLines, GenJnlBatch);
                        SaveAsStdGenJnl.RUNMODAL;
                        IF NOT SaveAsStdGenJnl.GetStdGeneralJournal(StdGenJnl) THEN
                            EXIT;

                        MESSAGE(Text001, StdGenJnl.Code);
                    end;
                }
                // separator()
                // {
                // }
                group(Payment1)
                {
                    Caption = 'Payment';
                    action(TDS)
                    {
                        Caption = 'TDS';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            //PaymentofTaxes.PayTDS(Rec);
                        end;
                    }
                    action(Worktax)
                    {
                        Caption = 'Worktax';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            //PaymentofTaxes.PayWorkTax(Rec);
                        end;
                    }
                    action(Salestax)
                    {
                        Caption = 'Salestax';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            //PaymentofTaxes.PaySalesTax(Rec);
                        end;
                    }
                    action(Excise)
                    {
                        Caption = 'Excise';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            //PaymentofTaxes.PayExcise(Rec);
                        end;
                    }
                    group(VAT)
                    {
                        Caption = 'VAT';
                        action(Payment)
                        {
                            Caption = 'Payment';
                            ApplicationArea = all;
                            trigger OnAction()
                            begin
                                // PaymentofTaxes.PayVAT(Rec);
                            end;
                        }
                        action(Refund)
                        {
                            Caption = 'Refund';
                            ApplicationArea = all;
                            trigger OnAction()
                            begin
                                //PaymentofTaxes.RefundVAT(Rec);
                            end;
                        }
                    }
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Reconcile)
                {
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.RUN;
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        // VE-021 >>

                        /*IF FIND('-') THEN
                        REPEAT
                          AUZSetup.INIT;
                          AUZSetup.SETRANGE(AUZSetup.Type,AUZSetup.Type::"Journal Voucher");
                          AUZSetup.SETRANGE(AUZSetup."From User Id","User ID");
                          IF AUZSetup.FIND('-') THEN
                             IF ( Amount > AUZSetup."From Amount" ) AND
                                ( Amount <= AUZSetup."To Amount")    OR
                                ( Authorised = TRUE) THEN
                                IsValid:=TRUE
                             ELSE
                                ERROR(Text16354,"Document Type","Document No.");
                        UNTIL NEXT=0; */  //EBT Paramita

                        //VE-021 <<

                        IF IsValid THEN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := TRUE;
        BalanceVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance;
        SetUpNewLine(xRec, Balance, BelowxRec);
        CLEAR(ShortcutDimCode);
        CLEAR(AccName);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        BalAccName := '';
        GenJnlManagement.TemplateSelection(PAGE::"Interview Subform", 0, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        GenJnlManagement: Codeunit 230;
        //ReportPrint: Codeunit 228;
        CurrentJnlBatchName: Code[10];
        AccName: Text[30];
        BalAccName: Text[30];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        Text000: Label 'General Journal lines have been successfully inserted from Standard General Journal %1.';
        Text001: Label 'Standard General Journal %1 has been successfully created.';
        Text13700: Label 'Select the TDS payable account against payment is to be made.';
        Text13701: Label 'There are no tds entries for account %1.';
        Text13702: Label 'Select the Work Tax payable account against payment is to be made.';
        Text13703: Label 'There are no work tax entries for account %1.';
        Text13704: Label 'Select the Sales tax payable account against which payment is to be made.';
        Text13705: Label 'There are no Sales tax entries for Account %1.';
        Text13706: Label 'Select the Excise payable account against which payment is to be made.';
        Text13707: Label 'There are no excise entries for account %1.';
        Text16350: Label 'Select the VAT Payable Account against which payment is to be made.';
        Text16351: Label 'There are no VAT Entries for Account No. %1.';
        Text16352: Label 'There are no VAT Entries available for Refund.';
        Text16353: Label 'Account Type must be G/L Account or Bank Account,';
        //PaymentofTaxes: Codeunit 13705;
        MLTransactionType: Option "Journal Voucher";
        i: Integer;
        IsValid: Boolean;
        Text16354: Label 'You need Authorization...\\ Document Type = %1,Document No.=%2';
        Window: Dialog;
        Text16355: Label 'Records are sending for Authorization...\';
        Text16356: Label 'Do you want to send the Record/s for Authorization?';
        GenLedgSetup: Record 98;
        //wscript: Automation;
        Flag: Boolean;
        //[InDataSet]
        BalanceVisible: Boolean;
        //[InDataSet]
        TotalBalanceVisible: Boolean;
        GLReconcile: Page 345;
    //ChangeExchangeRate: Page 511;

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    //  [Scope('Internal')]
    procedure MonthAttVar(TempFlag: Boolean)
    begin
        Flag := TempFlag;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance;
    end;

    local procedure OnTimer()
    begin
        /*
        CREATE(wscript);
        wscript.SendKeys('{F11}');
        CLEAR(wscript);
        SLEEP(500);
        
        CREATE(wscript);
        wscript.SendKeys('%Y');
        CLEAR(wscript);
        SLEEP(500);
        
        CREATE(wscript);
        wscript.SendKeys('{ENTER}');
        CLEAR(wscript);
        
        SLEEP(1000);
        CurrForm.CLOSE;
        */

    end;
}


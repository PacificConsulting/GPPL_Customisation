page 60032 "Loan Card"
{
    // B2B Software Technologies
    // ---------------------------
    // Project : Human Resource
    // 
    // B2B No. sign      Date
    // ---------------------------
    // 01   B2B    14-dec-05

    PageType = Card;
    SourceTable = 60039;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Id; rec.Id)
                {

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Loan Type"; rec."Loan Type")
                {
                    ApplicationArea = all;
                }
                field("Interest Method"; rec."Interest Method")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF rec."Interest Method" = rec."Interest Method"::"Interest Free" THEN
                            "Interest RateEditable" := FALSE
                        ELSE
                            "Interest RateEditable" := TRUE;
                    end;
                }
                field("Interest Rate"; rec."Interest Rate")
                {
                    ApplicationArea = all;
                    Editable = "Interest RateEditable";
                }
                field("Loan Amount"; rec."Loan Amount")
                {
                    ApplicationArea = all;

                    Caption = 'Loan Amount';
                    DecimalPlaces = 3 : 3;
                }
                field("Loan Start Date"; rec."Loan Start Date")
                {
                    ApplicationArea = all;
                }
                field("No of Installments"; rec."No of Installments")
                {
                    ApplicationArea = all;
                    Editable = "No of InstallmentsEditable";
                }
                field("Loan End Date"; rec."Loan End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Balance"; rec."Loan Balance")
                {
                    ApplicationArea = all;
                }
                field("Loan Priority No"; rec."Loan Priority No")
                {

                    ApplicationArea = all;
                }
                field("Loan Posting Group"; rec."Loan Posting Group")
                {

                    ApplicationArea = all;
                }
                field("Effective Amount"; rec."Effective Amount")
                {
                    ApplicationArea = all;
                    Caption = 'EMI Amount';
                }
                field("No Deduction Request"; rec."No Deduction Request")
                {
                    ApplicationArea = all;
                }
                field("Partial Deduction"; rec."Partial Deduction")
                {
                    ApplicationArea = all;
                }
                field(Closed; rec.Closed)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Loan")
            {
                Caption = '&Loan';
                action("&Details")
                {
                    ApplicationArea = all;
                    Caption = '&Details';
                    RunObject = Page 60034;
                    RunPageLink = "Employee No." = FIELD("Employee Code"),
                                  "Loan Id" = FIELD(Id);
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create &Installments")
                {
                    Caption = 'Create &Installments';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.TESTFIELD(rec."Loan Posting Group"); //VE-003
                        LoanCalculation.LoanInstallments(Rec);
                    end;
                }
                action("Loan &Repayment")
                {
                    ApplicationArea = all;
                    Caption = 'Loan &Repayment';
                    RunObject = Page 60035;
                    RunPageLink = "Loan Id" = FIELD(Id),
                                  "Employee No." = FIELD("Employee Code"),
                                  Paid = CONST(false);
                }
                action("Delete Installments")
                {
                    Caption = 'Delete Installments';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //EBT Paramita
                        LoanDetails.RESET;
                        LoanDetails.SETRANGE(LoanDetails."Employee No.", rec."Employee Code");
                        LoanDetails.SETRANGE(LoanDetails."Loan Id", rec.Id);
                        LoanDetails.SETFILTER(LoanDetails."EMI Deducted", '<>0');
                        IF LoanDetails.FINDFIRST THEN
                            ERROR('The Installment cannot be deleted as Loan cycle already been started');
                        LoanDetails.RESET;
                        LoanDetails.SETRANGE(LoanDetails."Employee No.", rec."Employee Code");
                        LoanDetails.SETRANGE(LoanDetails."Loan Id", rec.Id);
                        LoanDetails.SETFILTER(LoanDetails."Paid Month", '<>0');
                        IF LoanDetails.FINDFIRST THEN
                            ERROR('The Installment cannot be deleted as Loan cycle already been started');
                        LoanDetails.RESET;
                        LoanDetails.SETRANGE(LoanDetails."Employee No.", rec."Employee Code");
                        LoanDetails.SETRANGE(LoanDetails."Loan Id", rec.Id);
                        LoanDetails.SETFILTER(LoanDetails."Paid Year", '<>0');
                        IF LoanDetails.FINDFIRST THEN
                            ERROR('The Installment cannot be deleted as Loan cycle already been started');
                        LoanDetails.RESET;
                        LoanDetails.SETRANGE(LoanDetails."Employee No.", rec."Employee Code");
                        LoanDetails.SETRANGE(LoanDetails."Loan Id", rec.Id);
                        IF LoanDetails.FINDSET THEN
                            LoanDetails.DELETEALL;
                        MESSAGE('Loan Installments have been deleted');
                        //EBT Paramita
                    end;
                }
                separator(separator1)
                {
                }
                action("Installments for &All")
                {
                    ApplicationArea = all;
                    Caption = 'Installments for &All';
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanCalculation.LoanInstallmentsAll;
                    end;
                }
                action("Create Inst for ExistingLoans")
                {
                    Caption = 'Create Inst for ExistingLoans';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        LoanCalculation.ExistingLoanInstallmentsAll;
                    end;
                }
                separator(separator2)
                {
                }
                action(Installments)
                {
                    ApplicationArea = all;
                    Caption = 'Installments';
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanCalculation.ExistingLoanInstallments(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF rec.Type = Type::Loan THEN BEGIN
            "No of InstallmentsEditable" := FALSE;
            //CurrForm."Loan Balance".EDITABLE := FALSE;
        END ELSE BEGIN
            "No of InstallmentsEditable" := TRUE;
            //CurrForm."Loan Balance".EDITABLE := TRUE;
        END;
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Interest RateEditable" := TRUE;
        "No of InstallmentsEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        //VE-026 >>
        /*RecRef.GETTABLE(Rec);
        FILTERGROUP(2);
        SETVIEW(SecurityF.GetSecurityFilters(RecRef));
        FILTERGROUP(0);*/
        //VE-026 <<
        IF rec."Interest Method" = rec."Interest Method"::"Interest Free" THEN
            "Interest RateEditable" := FALSE
        ELSE
            "Interest RateEditable" := TRUE;

    end;

    var
        LoanCalculation: Codeunit 60006;
        LoanPayment: Record 60041;
        LoanDetails: Record 60040;
        RecRef: RecordRef;
        //[InDataSet]
        "No of InstallmentsEditable": Boolean;
        //[InDataSet]
        "Interest RateEditable": Boolean;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF rec."Interest Method" = rec."Interest Method"::"Interest Free" THEN
            "Interest RateEditable" := FALSE
        ELSE
            "Interest RateEditable" := TRUE;
    end;
}


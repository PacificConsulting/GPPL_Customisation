pageextension 50006 GLAccountCardExt extends "G/L Account Card"
{
    //SourceTableView=WHERE(Blocked=FILTER(No));
    layout
    {
        modify(Balance)
        {
            Visible = BalanceVisible;
        }
        // Add changes to page layout here
        addafter(Totaling)
        {
            field("Sub Expense"; Rec."Sub Expense")
            {
                ApplicationArea = all;
            }
            field("Transport Entries"; Rec."Transport Entries")
            {
                ApplicationArea = all;
            }
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = all;
            }
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Co&mments")
        {
            action("Ledger Entries")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    AccessControl.RESET;
                    AccessControl.SETRANGE("User Name", USERID);
                    AccessControl.SETFILTER("Role ID", '%1|%2', 'SUPER', 'LEDGER ENTRIES VIEW');
                    IF NOT (AccessControl.FINDFIRST) THEN BEGIN
                        ERROR('You do not have permission to View Ledger Entries');
                    END;
                    //RSPL-TC -
                    LEDGER.FILTERGROUP := 2;
                    LEDGER.SETRANGE(LEDGER."G/L Account No.", Rec."No.");
                    LEDGER.FILTERGROUP := 0;

                    PAGE.RUNMODAL(PAGE::"General Ledger Entries", LEDGER);
                END;
            }

        }

    }

    var
        AccessControl: Record 2000000053;
        BalanceVisible: Boolean;
        LEDGER: Record 17;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //  {
        //          //EBT STIVAN ---(121212)--- To Make the Balance Field Visible As per the Role -----START
        //          Memberof.RESET;
        //          Memberof.SETRANGE(Memberof."User ID",USERID);
        //          Memberof.SETFILTER(Memberof."Role ID",'%1|%2','SUPER','LEDGER ENTRIES VIEW');
        //          IF Memberof.FINDFIRST THEN
        //          BEGIN
        //           CurrForm.Balance.VISIBLE := TRUE
        //          END ELSE
        //           CurrForm.Balance.VISIBLE := FALSE;
        //          //EBT STIVAN ---(121212)--- To Make the Balance Field Visible As per the Role -------END
        //          }
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETFILTER("Role ID", '%1|%2', 'SUPER', 'LEDGER ENTRIES VIEW');
        IF AccessControl.FINDFIRST THEN BEGIN
            BalanceVisible := TRUE;
        END ELSE
            BalanceVisible := FALSE;
        //RSPL-TC -
    END;



}
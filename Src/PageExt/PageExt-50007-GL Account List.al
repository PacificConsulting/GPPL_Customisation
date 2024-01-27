pageextension 50007 GLAccountListExt extends "G/L Account List"
{

    // SourceTableView=WHERE(Blocked=FILTER(No),
    //                       Direct Posting=CONST(Yes));
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field(Blocked; Rec.Blocked)
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
                    //              {
                    //              Memberof.RESET;
                    // Memberof.SETRANGE(Memberof."User ID", USERID);
                    // Memberof.SETFILTER(Memberof."Role ID", '%1|%2', 'SUPER', 'LEDGER ENTRIES VIEW');
                    // IF NOT (Memberof.FINDFIRST) THEN BEGIN
                    //     ERROR('You do not have permission to View Ledger Entries');
                    // END;
                    //              //GLedger.RUN;
                    //              }
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
        AccVisible: Boolean;
        BalVisible: Boolean;
        LEDGER: Record 17;

    trigger OnOpenPage()
    var
        myInt: Integer;
    BEGIN
        //          {
        //          //EBT STIVAN ---(121212)--- To Make the Account & Balance Menu Visible As per the Role -----START
        //          Memberof.RESET;
        // Memberof.SETRANGE(Memberof."User ID", USERID);
        // Memberof.SETFILTER(Memberof."Role ID", '%1|%2', 'SUPER', 'LEDGER ENTRIES VIEW');
        // IF Memberof.FINDFIRST THEN BEGIN
        //     CurrForm.Account.VISIBLE := TRUE;
        //     CurrForm.Balance.VISIBLE := TRUE;
        // END ELSE BEGIN
        //     CurrForm.Account.VISIBLE := FALSE;
        //     CurrForm.Balance.VISIBLE := FALSE;
        // END;
        //          //EBT STIVAN ---(121212)--- To Make the Account & Balance Menu Visible As per the Role -------END
        //          }
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETFILTER("Role ID", '%1|%2', 'SUPER', 'LEDGER ENTRIES VIEW');
        IF AccessControl.FINDFIRST THEN BEGIN
            AccVisible := TRUE;
            BalVisible := TRUE;
        END ELSE BEGIN
            AccVisible := FALSE;
            BalVisible := FALSE;
        END;
        //RSPL-TC -
    END;
}
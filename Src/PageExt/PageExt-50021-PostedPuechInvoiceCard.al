pageextension 50021 PosPucInvCardCstm extends "Posted Purchase Invoice"
{
    layout
    {
        addbefore("Posting Date")
        {
            field(Comment1; Comment1)
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        // MY PC 11 01 2024
        addafter("Ship-to Contact")
        {
            field("Full Name"; rec."Full Name")
            {
                ApplicationArea = all;
            }
            field("Handover Date"; rec."Handover Date")
            {
                ApplicationArea = all;
            }
            field("Handover To"; rec."Handover To")
            {
                ApplicationArea = all;
            }
            field("Date of Receipt"; rec."Date of Receipt")
            {
                ApplicationArea = all;
            }
            field("Date of Issue"; rec."Date of Issue")
            {
                ApplicationArea = all;
            }
            field("Total No. of Invoices"; rec."Total No. of Invoices")
            {
                ApplicationArea = all;
            }
            field("Period Form"; rec."Period Form")
            {
                ApplicationArea = all;
            }
            field("Period To"; rec."Period To")
            {
                ApplicationArea = all;
            }
            field("Form Issued Amount"; rec."Form Issued Amount")
            {
                ApplicationArea = all;
            }
            field("Form Issued No."; rec."Form Issued No.")
            {
                ApplicationArea = all;
            }
            field("Department Code"; rec."Department Code")
            {
                ApplicationArea = all;
            }
            field("Deal Sheet No."; rec."Deal Sheet No.")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        addafter("&Navigate")
        {
            action(Details)
            {
                ApplicationArea = All;
                RunObject = page 20;
                RunPageLink = "Exp/Purchase Invoice Doc. No." = FIELD("No.");
                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        recGLentry: Record "G/L Entry";
    begin
        Clear(Comment1);
        //EBT STIVAN -(14/04/2012)- To update if JV has been posted ---START
        recGLentry.RESET;
        recGLentry.SETRANGE(recGLentry."Exp/Purchase Invoice Doc. No.", Rec."No.");
        IF recGLentry.FINDFIRST THEN BEGIN
            Comment1 := 'JV POSTED';
        END ELSE BEGIN
            Comment1 := '';
        END;
        //EBT STIVAN -(14/04/2012)- To update if JV has been posted ---START
    end;

    var
        Comment1: Text;
}
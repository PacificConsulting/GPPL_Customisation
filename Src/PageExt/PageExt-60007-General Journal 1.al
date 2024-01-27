pageextension 60007 General_Journal_Ext extends "General Journal"
{
    layout
    {
        addafter("Document No.")
        {
            // field(PLA; rec.PLA)
            // {
            //     ApplicationArea = all;
            // }
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = all;
            }
            /* field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = all;
            } */
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("Account No.")
        {/* 
            field("Tax Type"; Rec."Tax Type")
            {
                ApplicationArea = all;
            } */
        }
        addafter(Description)
        {
            // field("Excise Posting"; rec."Excise Posting")
            // {
            //     ApplicationArea = all;
            // }
            // field("Excise Charge"; rec."Excise Charge")
            // {
            //     ApplicationArea = all;
            // }

        }
        addafter("Credit Amount")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = all;
            }
            /*   field("Location Code"; Rec."Location Code")
              {
                  ApplicationArea = all;
              }
              field("GST Group Code"; Rec."GST Group Code")
              {
                  ApplicationArea = all;
              }
              field("GST Group Type"; Rec."GST Group Type")
              {
                  ApplicationArea = all;
              } */
            // field("GST Base Amount"; rec."GST Base Amount")
            // {
            //     ApplicationArea = alll;
            // }
        }

        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {

            trigger OnBeforeAction()

            begin
                IF rec."Posting Date" >= 20180107D THEN BEGIN
                    User02.RESET;
                    User02.SETRANGE("User ID", USERID);
                    User02.SETRANGE("JV Posting", TRUE);
                    IF NOT User02.FINDFIRST THEN
                        ERROR('You dont have permission to post General Journal');
                END;
                //<<02Jul2018
            end;//>>02Jul2018

        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                //>>02Jul2018
                IF rec."Posting Date" >= 20180107D THEN BEGIN
                    User02.RESET;
                    User02.SETRANGE("User ID", USERID);
                    User02.SETRANGE("JV Posting", TRUE);
                    IF NOT User02.FINDFIRST THEN
                        ERROR('You dont have permission to post General Journal');
                END;
                //<<02Jul2018
            end;
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        User02: Record 91;

}
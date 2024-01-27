page 50032 "Item Version Parameter Result"
{
    Caption = '<Item Version Parameter Result>';
    Editable = true;
    PageType = List;
    SourceTable = 50015;
    SourceTableView = WHERE("Test Result Approved" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Version Code"; rec."Version Code")
                {
                    ApplicationArea = all;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = all;
                }
                field("Typical Value"; rec."Typical Value")
                {
                    ApplicationArea = all;
                }
                field("Min Value"; rec."Min Value")
                {
                    ApplicationArea = all;
                }
                field("Max Value"; rec."Max Value")
                {
                    ApplicationArea = all;
                }
                field(Mandatory; rec.Mandatory)
                {
                    ApplicationArea = all;
                }
                field(Result; rec.Result)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Batch No./DC No"; rec."Batch No./DC No")
                {
                    ApplicationArea = all;
                }
                field("Testing Method"; rec."Testing Method")
                {
                    ApplicationArea = all;
                }
                field("Blend Order No"; rec."Blend Order No")
                {
                    ApplicationArea = all;
                }
                field("Tested By"; rec."Tested By")
                {
                    ApplicationArea = all;
                }
                field("QC Test Report Generated"; rec."QC Test Report Generated")
                {
                    ApplicationArea = all;
                }
                field("Approved By"; rec."Approved By")
                {
                    ApplicationArea = all;
                }
                field("Test Result Approved"; rec."Test Result Approved")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Remarks 1"; rec."Remarks 1")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Post QC")
            {
                Caption = '&Post QC';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Posted := FALSE;
                    ParameterResult.RESET;
                    ParameterResult.SETRANGE(ParameterResult."Item No.", rec."Item No.");
                    ParameterResult.SETRANGE(ParameterResult."Blend Order No", rec."Blend Order No");
                    IF ParameterResult.FINDSET THEN
                        REPEAT
                            ParameterResult.TESTFIELD(Result);
                            ParameterResult."Posting Date" := WORKDATE;
                            UserSetup.GET(USERID);
                            ParameterResult."Tested By" := UserSetup.Name;
                            IF ParameterResult.MODIFY THEN
                                Posted := TRUE
                            ELSE
                                Posted := FALSE;
                        UNTIL ParameterResult.NEXT = 0;
                    IF Posted THEN
                        MESSAGE('QC has been posted');
                    //CLEAR(ParameterForm);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.SETCURRENTKEY("Item No.", "Version Code", "Batch No./DC No", "Line No.");
    end;

    var
        ParameterResult: Record 50015;
        Posted: Boolean;
        UserSetup: Record 91;
}


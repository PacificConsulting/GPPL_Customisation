page 50030 "Item Version Parameter Final"
{
    PageType = Card;
    SourceTable = 50015;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Certificate No."; rec."Certificate No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Blend Order No"; rec."Blend Order No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Batch No./DC No"; rec."Batch No./DC No")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Version Code"; rec."Version Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Typical Value"; rec."Typical Value")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Min Value"; rec."Min Value")
                {
                    Editable = false;
                }
                field("Max Value"; rec."Max Value")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Mandatory; rec.Mandatory)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Result; rec.Result)
                {
                    ApplicationArea = all;
                    Editable = ResultEditable;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Testing Method"; rec."Testing Method")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Tested By"; rec."Tested By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("QC Test Report Generated"; rec."QC Test Report Generated")
                {
                    Editable = false;
                }
                field("Approved By"; rec."Approved By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Test Result Approved"; rec."Test Result Approved")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remarks 1"; rec."Remarks 1")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(EDIT)
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = EDITVisible;
                ApplicationArea = ll;
                trigger OnAction()
                begin
                    /*
                    //EBT STIVAN ---(01082012)--- To make the Result Field Uneditable while EDIT Command Button is Clicked -----START
                    user.GET(USERID);
                    memberof.RESET;
                    memberof.SETRANGE(memberof."User ID",USERID);
                    memberof.SETRANGE(memberof."Role ID",'TC MODIFICATION');
                    IF memberof.FINDFIRST THEN */
                    //RSPL-TC +
                    AccessControl.RESET;
                    AccessControl.SETRANGE("User Name", USERID);
                    AccessControl.SETRANGE("Role ID", 'TC MODIFICATION');
                    IF AccessControl.FINDFIRST THEN //RSPL-TC -
                    BEGIN
                        ResultEditable := TRUE;
                    END;
                    //EBT STIVAN ---(01082012)--- To make the Result Field Uneditable while EDIT Command Button is Clicked -------END

                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        //EBT STIVAN ---(01082012)--- To make the Result Field Uneditable while closing the Form -----START
        ResultEditable := FALSE;
        //EBT STIVAN ---(01082012)--- To make the Result Field Uneditable while closing the Form -------END
    end;

    trigger OnInit()
    begin
        EDITVisible := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //EBT STIVAN ---(01082012)--- To make he Command Button (EDIT) Visible to the USer who have role specified -----START
        user.GET(USERID);
        /*  //RSPL-TC
        memberof.RESET;
        memberof.SETRANGE(memberof."User ID",USERID);
        memberof.SETRANGE(memberof."Role ID",'TC MODIFICATION');
        IF memberof.FINDFIRST THEN*/
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'TC MODIFICATION');
        IF AccessControl.FINDFIRST THEN //RSPL-TC -
        BEGIN
            EDITVisible := TRUE;
        END ELSE BEGIN
            EDITVisible := FALSE;
        END;
        //EBT STIVAN ---(01082012)--- To make he Command Button (EDIT) Visible to the USer who have role specified -------END

    end;

    var
        //  [InDataSet] 
        EDITVisible: Boolean;
        //  [InDataSet]
        ResultEditable: Boolean;
        user: Record 91;
        AccessControl: Record 2000000053;
}


pageextension 50032 WhseRcptListExtCstm extends "Warehouse Receipts"
{
    layout
    {
        addafter("Zone Code")
        {
            field("QC Status"; Rec."QC Status")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        RecUserPersonlization: Record "User Personalization";
    begin
        //RSPLSUM28688


        RecUserPersonlization.RESET;
        RecUserPersonlization.SETRANGE("User ID", USERID);
        RecUserPersonlization.SETRANGE("Profile ID", 'QC');
        IF RecUserPersonlization.FINDFIRST THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("QC Status", Rec."QC Status"::"Pending for Approval");
            Rec.FILTERGROUP(0);
        END;
        //RSPLSUM28688
    end;

    var
        myInt: Integer;
}
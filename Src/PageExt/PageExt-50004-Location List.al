pageextension 50004 LocationListExt extends "Location List"
{
    // SourceTableView=WHERE(Closed=CONST(No));
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field(City; Rec.City)
            {
                ApplicationArea = all;
            }
            field("Post Code"; Rec."Post Code")
            {
                ApplicationArea = all;
            }
            field(County; Rec.County)
            {
                ApplicationArea = all;
            }
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = all;
            }
            field(Closed; Rec.Closed)
            {
                ApplicationArea = all;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = all;
            }
            field("Trading Location"; Rec."Trading Location")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
            }
            field("Include in Valuation Report"; Rec."Include in Valuation Report")
            {
                ApplicationArea = all;
            }


        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Location")
        {
            action("Dispatch Location List")
            {
                //CaptionML = ENU ="Dispatch Location List";
                Promoted = true;
                Image = List;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    DispatchLocationList: Page 50134;
                    DispatchFromLocation: Record 50042;
                BEGIN
                    //RSPLAM30595 ++
                    Rec.TESTFIELD(Code);
                    DispatchFromLocation.SETRANGE("Dispatch Location Code", Rec.Code);
                    DispatchLocationList.SETTABLEVIEW(DispatchFromLocation);
                    DispatchLocationList.RUNMODAL;
                    //RSPLAM30595 --
                END;
            }



        }
    }

    var
        myInt: Integer;
}
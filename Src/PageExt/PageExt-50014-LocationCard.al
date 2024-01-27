pageextension 50014 LocationcardExtcstm extends "Location Card"
{
    layout
    {
        addafter(Contact)
        {
            field("Location Type"; Rec."Location Type")
            {
                ApplicationArea = all;
            }
            // field(City; Rec.City)
            // {
            //     ApplicationArea = all;
            // }
            // field("Post Code"; Rec."Post Code")
            // {
            //     ApplicationArea = all;
            // }
            field(County; Rec.County)
            {
                ApplicationArea = all;
            }
            // field("State Code"; Rec."State Code")
            // {
            //     ApplicationArea = all;
            // }
            field(Closed; Rec.Closed)
            {
                ApplicationArea = all;
            }
            field("Closing Date"; Rec."Closing Date")
            {
                ApplicationArea = all;
            }
            field("W.e.f. Date(T.I.N No.)"; Rec."W.e.f. Date(T.I.N No.)")
            {
                ApplicationArea = all;
            }
            field("W.e.f. Date(C.S.T No.)"; Rec."W.e.f. Date(C.S.T No.)")
            {
                ApplicationArea = all;
            }
            field("Destination Days"; Rec."Destination Days")
            {
                ApplicationArea = all;
            }
            field("EWB UserName"; Rec."EWB UserName")
            {
                ApplicationArea = all;
            }
            field("EWB Password"; Rec."EWB Password")
            {
                ApplicationArea = all;
            }
            field("E-Inv Token"; Rec."E-Inv Token")
            {
                ApplicationArea = all;
            }
            field("E-Inv ClientId"; Rec."E-Inv ClientId")
            {
                ApplicationArea = all;
            }
            field("E-Inv Client_Secret"; Rec."E-Inv Client_Secret")
            {
                ApplicationArea = all;
            }
            field("E-Inv Sek"; Rec."E-Inv Sek")
            {
                ApplicationArea = all;
            }
            field("E-Inv Public Key"; Rec."E-Inv Public Key")
            {
                ApplicationArea = all;
            }
            field("E-Inv Token Expiry"; Rec."E-Inv Token Expiry")
            {
                ApplicationArea = all;
            }
            field("E-Inv UserName"; Rec."E-Inv UserName")
            {
                ApplicationArea = all;
            }
            field("E-Inv Password"; Rec."E-Inv Password")
            {
                ApplicationArea = all;
            }
            field("E-Inv ForceRefreshAccessToken"; Rec."E-Inv ForceRefreshAccessToken")
            {
                ApplicationArea = all;
            }
            // field(Address; Rec.Address)
            // {
            //     ApplicationArea = all;
            // }
            // field("Address 2"; Rec."Address 2")
            // {
            //     ApplicationArea = all;
            // }
            // field("Trading Location"; Rec."Trading Location")
            // {
            //     ApplicationArea = all;
            // }
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
            field("Storage Capacity"; Rec."Storage Capacity")
            {
                ApplicationArea = all;
            }
            field("FM Prod. Order No."; Rec."FM Prod. Order No.")
            {
                ApplicationArea = all;
            }
            field("Release Prod. Order No."; Rec."Release Prod. Order No.")
            {
                ApplicationArea = all;

            }
            field("Post Excise Details"; Rec."Post Excise Details")
            {
                ApplicationArea = all;
            }
            field("Production Bin"; Rec."Production Bin")
            {
                ApplicationArea = all;
            }
            field("Opening Date"; Rec."Opening Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("LUT Registration No."; Rec."LUT Registration No.")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
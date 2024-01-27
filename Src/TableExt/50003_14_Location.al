tableextension 50003 LocationExtCutm extends Location
{
    fields
    {
        field(50000; "Location Type"; Option)
        {
            Description = 'EBT/LOC/0001';
            OptionMembers = " ",Stores,Tank,Kettle,"Pre Packing Tank","F G Storage",Depot,Bonded,"High Seas";
        }
        field(50001; "Bonded Store for ER Updation"; Boolean)
        {
            Description = 'EBT/LOC/0001';
        }
        field(50002; "Plant Code"; Option)
        {
            Description = 'EBT/LOC/0001';
            Editable = false;
            OptionCaption = ' ,Plant 1,Plant 2,Plant 3,Plant 4,Plant 5';
            OptionMembers = " ","Plant 1","Plant 2","Plant 3","Plant 4","Plant 5";
        }
        field(50003; "Storage Capacity"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'EBT/LOC/0001';
        }
        field(50004; "Under Bond"; Boolean)
        {
            Description = 'EBT/LOC/0001';

            trigger OnValidate()
            begin
                //EBT/LOC/0001
                TESTFIELD("Location Type", "Location Type"::Tank);
                //EBT/LOC/0001
            end;
        }
        field(50005; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50006; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50007; "FM Prod. Order No."; Code[20])
        {
            Description = 'EBT/MFG/0001';
            TableRelation = "No. Series";
        }
        field(50008; "Release Prod. Order No."; Code[20])
        {
            Description = 'EBT/MFG/0001';
            TableRelation = "No. Series";
        }
        field(50009; "Post Excise Details"; Boolean)
        {
            Description = 'EBT/Excise/0001';
        }
        field(50010; "Production Bin"; Code[20])
        {
            Description = 'EBT0002';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD(Code));
        }
        field(50011; Closed; Boolean)
        {
            Description = 'EBT STIVAN (02/05/2013) - For Filtertation Purpose in Card and List Form';

            trigger OnValidate()
            begin
                // EBT MILAN to update closing date 290114-------------------------------------START
                IF Closed = TRUE THEN
                    "Closing Date" := TODAY;
                IF Closed = FALSE THEN
                    "Closing Date" := 0D;
                // EBT MILAN to update closing date 290114---------------------------------------END
            end;
        }
        field(50012; "Strorage Capacity Industrial"; Code[10])
        {
            Description = 'EBT MILAN (12122013) - For Capacity in Report 50148';
        }
        field(50013; "Opening Date"; Date)
        {
            Description = 'EBT MILAN 290114';
        }
        field(50014; "Closing Date"; Date)
        {
            Description = 'EBT MILAN 290114';
        }
        field(50015; "W.e.f. Date(T.I.N No.)"; Date)
        {
            Description = 'RSPL 251114';
        }
        field(50016; "W.e.f. Date(C.S.T No.)"; Date)
        {
            Description = 'RSPL 251114';
        }
        field(50017; "Destination Days"; Integer)
        {
            Description = 'RB-N 20Jun2018';
        }
        field(50018; "Include in Valuation Report"; Boolean)
        {
            Description = 'RB-N 16Jul2018';
        }
        field(50019; "EWB UserName"; Text[20])
        {
            Description = 'EWBYSR';
        }
        field(50020; "EWB Password"; Text[20])
        {
            Description = 'EWBYSR';
        }
        field(50290; "E-Inv Token"; Text[50])
        {
            Description = 'eInvYSR';
            Editable = false;
        }
        field(50291; "E-Inv Sek"; Text[100])
        {
            Description = 'eInvYSR';
            Editable = false;
        }
        field(50292; "E-Inv Public Key"; Text[250])
        {
            Description = 'eInvYSR';
            Editable = false;
        }
        field(50293; "E-Inv Token Expiry"; DateTime)
        {
            Description = 'eInvYSR';
            Editable = false;
        }
        field(50294; "E-Inv UserName"; Text[20])
        {
            Description = 'eInvYSR';
        }
        field(50295; "E-Inv Password"; Text[20])
        {
            Description = 'eInvYSR';
        }
        field(50296; "E-Inv ForceRefreshAccessToken"; Boolean)
        {
            Description = 'eInvYSR';
        }
        field(50297; "E-Inv ClientId"; Text[35])
        {
            Description = 'eInvYSR';
        }
        field(50298; "E-Inv Client_Secret"; Text[40])
        {
            Description = 'eInvYSR';
        }
        field(50350; "LUT Registration No."; Text[50])
        {
            Description = 'RSPLSUM28742 26Feb21';
        }
        field(50351; "GSP E-Inv Token"; BLOB)
        {
            Description = 'GSPEINVDJ';
        }

    }

    trigger OnInsert()
    var
    begin
        Rec.Validate("Opening Date", WorkDate());
        Rec.Validate("Include in Valuation Report", true);
    end;
}
tableextension 50035 ShipToAddExtCutm extends 222
{
    fields
    {
        field(50001; "GST Customer Type"; Option)
        {
            Caption = 'GST Customer Type';
            Description = 'RB-N 20Oct2019';
            OptionCaption = ' ,Registered,Unregistered,Export,Deemed Export,Exempted,SEZ Development,SEZ Unit';
            OptionMembers = " ",Registered,Unregistered,Export,"Deemed Export",Exempted,"SEZ Development","SEZ Unit";

            trigger OnValidate()
            var
            //GSTRegistrationNos: Record 16400;
            begin
                //>>20Oct2019
                /*
                                IF "GST Customer Type" = "GST Customer Type"::" " THEN BEGIN
                                    "GST Registration No." := '';
                                    EXIT;
                                END;
                                TESTFIELD(Address);
                                IF "GST Customer Type" = "GST Customer Type"::Registered THEN
                                    TESTFIELD("GST Registration No.");
                                IF ("GST Customer Type" IN ["GST Customer Type"::Registered,
                                                            "GST Customer Type"::Unregistered,
                                                            "GST Customer Type"::Exempted,
                                                            "GST Customer Type"::"SEZ Development",
                                                            "GST Customer Type"::"SEZ Unit"])
                                THEN
                                    TESTFIELD(State)
                                ELSE
                                    IF "GST Customer Type" <> "GST Customer Type"::"Deemed Export" THEN
                                        TESTFIELD(State, '');
                                IF NOT ("GST Customer Type" IN ["GST Customer Type"::Registered,
                                                                "GST Customer Type"::Exempted,
                                                                "GST Customer Type"::"Deemed Export",
                                                                "GST Customer Type"::"SEZ Development",
                                                                "GST Customer Type"::"SEZ Unit"])
                                THEN
                                    "GST Registration No." := '';
                                */
                //>>20Oct2019
            end;
        }
        field(55000; "T.I.N. No."; Code[20])
        {
            Caption = 'T.I.N. No.';

            trigger OnValidate()
            var
                //recState: Record 13762;
                Text16501: Label 'T.I.N. no. should be of 11 characters.';
                Text16502: Label 'T.I.N. No. for the State %1 should  start with %2''.';
            begin
                //TESTFIELD(State);
                TESTFIELD(Address);
                //GSTRegistrationNos.CheckGSTRegistrationNo(State, "GST Registration No.");
                /*
                IF (STRLEN("T.I.N. No.") < 11) AND ("T.I.N. No." <> '') THEN;
                  ERROR(Text16501);
                
                IF State.GET("State Code") THEN BEGIN
                  IF (COPYSTR((State."State Code for TIN"),1,2) <> COPYSTR(("T.I.N. No."),1,2)) AND  ("T.I.N. No." <> '')THEN
                    ERROR(Text16502,"State Code",COPYSTR((State."State Code for TIN"),1,2));
                END;
                */
                //EBT STIVAN (31012012)---------------------------------------------------------------------------------------------START
                IF ("T.I.N. No." <> '') THEN BEGIN
                    IF (STRLEN("T.I.N. No.") < 11) OR (STRLEN("T.I.N. No.") > 11) AND ("T.I.N. No." <> '') THEN
                        ERROR(Text16501);
                END;

                /*
                IF recState.GET("State Code") THEN BEGIN
                    IF (COPYSTR((recState."State Code for TIN"), 1, 2) <> COPYSTR(("T.I.N. No."), 1, 2)) AND ("T.I.N. No." <> '') THEN
                        ERROR(Text16502, "State Code", COPYSTR((recState."State Code for TIN"), 1, 2));
                END;
                */
                //EBT STIVAN (31012012)-----------------------------------------------------------------------------------------------END

            end;
        }
        field(55010; "Tax Exemption No."; Text[30])
        {
            Caption = 'Tax Exemption No.';
        }
        field(55020; "L.S.T. No."; Code[40])
        {
            Caption = 'L.S.T. No.';
        }
        field(55030; "C.S.T. No."; Code[40])
        {
            Caption = 'C.S.T. No.';
        }
        field(55040; "P.A.N. No."; Code[20])
        {
            Caption = 'P.A.N. No.';

            trigger OnValidate()
            begin
                /*IF "P.A.N. No." <> xRec."P.A.N. No." THEN
                  UpdatePartyPAN; */

            end;
        }
        field(55050; "E.C.C. No."; Code[20])
        {
            Caption = 'E.C.C. No.';
        }
        field(55060; Range; Code[20])
        {
            Caption = 'Range';
        }
        field(55070; Collectorate; Code[20])
        {
            Caption = 'Collectorate';
        }
        field(55080; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //TableRelation = "Excise Bus. Posting Group";Azhar Pending
        }
        field(55090; "State Code"; Code[10])
        {
            Caption = 'State Code';
            TableRelation = State;//Azhar Pending
        }
        field(55100; Structure; Code[20])
        {
            Caption = 'Structure';
            //TableRelation = "Structure Header".Code;Azhar Pending
        }
        field(55110; "P.A.N. Reference No."; Code[20])
        {
            Caption = 'P.A.N. Reference No.';

            trigger OnValidate()
            begin
                /*IF ("P.A.N. Reference No." <> xRec."P.A.N. Reference No.") THEN
                  UpdatePartyPANRefNo; */

            end;
        }
        field(55120; "P.A.N. Status"; Option)
        {
            Caption = 'P.A.N. Status';
            OptionCaption = ' ,PANAPPLIED,PANINVALID,PANNOTAVBL';
            OptionMembers = " ",PANAPPLIED,PANINVALID,PANNOTAVBL;

            trigger OnValidate()
            begin
                "P.A.N. No." := FORMAT("P.A.N. Status");
            end;
        }
        field(55130; "Export or Deemed Export"; Boolean)
        {
            Caption = 'Export or Deemed Export';
        }
        field(55140; "VAT Exempted"; Boolean)
        {
            Caption = 'VAT Exempted';
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}
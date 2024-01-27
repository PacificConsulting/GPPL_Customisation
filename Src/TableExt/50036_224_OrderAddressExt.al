tableextension 50036 OrderAddExtCustm extends 224
{
    fields
    {
        // field(50100; State; Code[10])
        // {
        //     TableRelation = State; Azhar Pending
        // }
        field(50101; "T.I.N. No."; Code[11])
        {
            Caption = 'T.I.N. No.';
            Description = 'EBT STIVAN 31012012';

            trigger OnValidate()
            var
                Text16501: Label 'T.I.N. no. should not be less then 11 characters.';
            //recState: Record 13762;
            begin
                //EBT STIVAN (31012012)---------------------------------------------------------------------------------------------START
                IF (STRLEN("T.I.N. No.") < 11) AND ("T.I.N. No." <> '') THEN
                    ERROR(Text16501);
                /*
                                IF recState.GET(State) THEN BEGIN
                                    IF (COPYSTR((recState."State Code for TIN"), 1, 2) <> COPYSTR(("T.I.N. No."), 1, 2)) AND ("T.I.N. No." <> '') THEN
                                        ERROR('The T.I.N. no. for the state %1 should be start with %2', State, COPYSTR((recState."State Code for TIN"), 1, 2));
                                END;
                                */
                //EBT STIVAN (31012012)-----------------------------------------------------------------------------------------------END
            end;
        }
        field(50102; "L.S.T. No."; Code[20])
        {
            Caption = 'L.S.T. No.';
            Description = 'EBT STIVAN 31012012';
        }
        field(50103; "C.S.T. No."; Code[20])
        {
            Caption = 'C.S.T. No.';
            Description = 'EBT STIVAN 31012012';
        }
        field(50104; "E.C.C. No."; Code[20])
        {
            Caption = 'E.C.C. No.';
            Description = 'EBT STIVAN 31012012';
        }
        field(50106; "GST Vendor Type"; Option)
        {
            Caption = 'GST Vendor Type';
            Editable = false;
            OptionCaption = ' ,Registered,Composite,Unregistered,Import,Exempted';
            OptionMembers = " ",Registered,Composite,Unregistered,Import,Exempted;

            trigger OnValidate()
            var
                Vendor: Record 23;
            //GSTRegistrationNos: Record 16400;
            begin

                //>>10July2017
                IF "GST Vendor Type" = "GST Vendor Type"::" " THEN BEGIN
                    "GST Registration No." := '';
                    EXIT;
                END;
                IF "GST Vendor Type" IN ["GST Vendor Type"::Registered, "GST Vendor Type"::Composite] THEN
                    TESTFIELD("GST Registration No.")
                ELSE BEGIN
                    IF "GST Vendor Type" <> "GST Vendor Type"::Exempted THEN
                        "GST Registration No." := '';
                    IF "GST Vendor Type" = "GST Vendor Type"::Import THEN
                        TESTFIELD(State, '')
                    ELSE
                        IF "GST Vendor Type" = "GST Vendor Type"::Unregistered THEN
                            TESTFIELD(State);

                END;

                IF ("GST Registration No." <> '') THEN BEGIN
                    TESTFIELD(State);
                    //GSTRegistrationNos.CheckGSTRegistrationNo(State, "GST Registration No.");
                END;
                //<<10July2017
            end;
        }
        // field(50107; "GST Registration No."; Code[15])
        // {

        //     trigger OnValidate()
        //     var
        //     //GSTRegistrationNos: Record 16400;
        //     begin
        //         //>>10July2017

        //         IF "GST Registration No." <> '' THEN BEGIN
        //             TESTFIELD(State);
        //             //GSTRegistrationNos.CheckGSTRegistrationNo(State, "GST Registration No.");
        //             IF "GST Vendor Type" = "GST Vendor Type"::" " THEN
        //                 "GST Vendor Type" := "GST Vendor Type"::Registered
        //             ELSE
        //                 IF NOT ("GST Vendor Type" IN ["GST Vendor Type"::Registered, "GST Vendor Type"::Composite, "GST Vendor Type"::Exempted]) THEN
        //                     "GST Vendor Type" := "GST Vendor Type"::Registered
        //         END ELSE
        //             "GST Vendor Type" := "GST Vendor Type"::" ";

        //         //<<10July2017
        //     end;
        // }
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
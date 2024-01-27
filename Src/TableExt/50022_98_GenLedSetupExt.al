tableextension 50022 GenledSetExtCustm extends 98
{
    fields
    {
        field(50001; "Ecess Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50002; "She Cess"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50003; "Custom Ecess Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50004; "Custom She Cess Acc"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50005; "ADE Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50006; "CVD Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50007; "BCD Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50008; "Excise Recovarable"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50009; "Excise Payable"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50010; "Transport Subsidy Acc"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50011; "Email Notification On JV"; Boolean)
        {
            Description = 'RB-N 31Oct2018';
        }
        field(50012; "OCL Over Due days"; DateFormula)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50013; "Exchange Master Company"; Text[30])
        {
            Description = 'RSPLSUM-BUNKER';
            TableRelation = Company.Name;
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
        }
        field(50293; "E-Inv Token Expiry"; DateTime)
        {
            Description = 'eInvYSR';
            Editable = true;
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
        field(50297; "E-Inv ClientId"; Text[30])
        {
            Description = 'eInvYSR';
        }
        field(50298; "E-Inv Client_Secret"; Text[30])
        {
            Description = 'eInvYSR';
        }
        field(50300; "TDS Nature Of Deduction"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
            //TableRelation = "TDS Nature of Deduction";
        }
        field(50301; "GST TDS Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
        }
        field(50302; "TDS Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
        }
        field(50330; "EWB UserName"; Text[20])
        {
            Description = 'EWBYSR';
        }
        field(50331; "EWB Password"; Text[20])
        {
            Description = 'EWBYSR';
        }
        field(50332; "TCS Threshold Starting Date"; Date)
        {
            Description = 'RSPLSUM-TCS';
        }
        field(50333; "TCS Threshold Amount"; Decimal)
        {
            Description = 'RSPLSUM-TCS';
        }
        field(50400; "MKey ID"; Text[100])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50401; "MSecret Key"; Text[100])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50402; MPicture; BLOB)
        {
            Description = '#Mintify,Mintifi_SUM';
            SubType = Bitmap;
        }
        field(50403; MHomepage; Text[50])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50404; MDescription; Text[250])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50405; "MInvoice URL"; Text[50])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50406; "MPayment URL"; Text[50])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50407; "MCredit Memo URL"; Text[50])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50408; "MJson File Path"; Text[50])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50409; "MIs Invoice"; Boolean)
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50410; "MIs Payment"; Boolean)
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50411; "MIs Credit Memo"; Boolean)
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50412; "MAuthorization Key"; Text[250])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50413; MJournalURL; Text[50])
        {
            Description = '#Mintify,Mintifi_SUM';
        }
        field(50414; "MIs Journal"; Boolean)
        {
            Description = '#Mintify,Mintifi_SUM';
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
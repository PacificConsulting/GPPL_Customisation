tableextension 50017 CompInfoExtCutm extends 79
{
    fields
    {
        field(50000; "System Indicator 1"; Option)
        {
            Caption = 'System Indicator';
            Description = 'RSPL-TC have to remove after data migration';
            OptionCaption = 'None,Custom Text,Company Information,Company,Database,Company+Database';
            OptionMembers = "None","Custom Text","Company Information",Company,Database,"Company+Database";
        }
        field(50001; "Custom System Indicator Text 1"; Text[250])
        {
            Caption = 'Custom System Indicator Text';
            Description = 'RSPL-TC have to remove after data migration';
        }
        field(50002; "System Indicator Style 1"; Option)
        {
            Caption = 'System Indicator Style';
            Description = 'RSPL-TC have to remove after data migration';
            OptionCaption = 'Standard,Accent1,Accent2,Accent3,Accent4,Accent5,Accent6,Accent7,Accent8,Accent9';
            OptionMembers = Standard,Accent1,Accent2,Accent3,Accent4,Accent5,Accent6,Accent7,Accent8,Accent9;
        }
        field(50003; "Insurance No."; Code[30])
        {
            Description = 'EBT 0001';
        }
        field(50004; "Policy Expiration Date"; Date)
        {
            Description = 'EBT 0001';
        }
        field(50005; "LBT No."; Code[20])
        {
            Description = 'EBT STIVAN 05/07/2012';
        }
        field(50009; "Insurance Provider"; Text[50])
        {
            Description = 'EBT STIVAN 30/03/2012';
        }
        field(50010; "Shaded Box"; BLOB)
        {
            Description = 'Pratyusha';
        }
        field(50011; "CIN No."; Text[50])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50012; "Customer Credit Validation"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50300; "Turnover Above 10 Crores"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
        }
        field(55000; "Name Picture"; BLOB)
        {
            Description = 'added for hotfix';
            SubType = Bitmap;
        }
        field(55001; "Repsol Logo"; BLOB)
        {
            Description = '21Aug2017 RB-N';
            SubType = Bitmap;
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
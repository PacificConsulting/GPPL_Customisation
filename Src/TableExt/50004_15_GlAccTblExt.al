tableextension 50004 GLAccTblExtCustom extends "G/L Account"
{
    fields
    {
        field(50000; "Created Date"; Date)
        {
            Description = 'RB-N 08Mar2018';
            Editable = false;
        }
        field(50001; "Created Time"; Time)
        {
            Description = 'RB-N 08Mar2018';
            Editable = false;
        }
        field(50002; "Sub Expense"; Boolean)
        {
            Description = 'RB-N 06Jul2018';
        }
        field(50003; "Transport Entries"; Boolean)
        {
            Description = 'RB-N 02Jan2019';
        }

    }
    trigger OnInsert()
    var
    begin
        Rec.Validate("Created Date", Today);
        Rec.Validate("Created Time", Time);
    end;

}
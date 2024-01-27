page 60003 "LookUp List"
{
    // B2B Software Technologies
    // ----------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // ----------------------------
    // 01   B2B    13-dec-05

    Caption = 'LookUp List';
    DataCaptionFields = "Lookup Id";
    Editable = true;
    PageType = List;
    SourceTable = 60018;
    SourceTableView = SORTING("Lookup Name")
                      ORDER(Ascending);
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Lookup Name"; Rec."Lookup Name")
                {
                    ApplicationArea = all;
                    Caption = 'Lookup Name';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        SearchName: Text[250];
        LookupRec: Record 60018;
        TempLookup: Text[30];
}


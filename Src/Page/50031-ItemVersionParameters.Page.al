page 50031 "Item Version Parameters"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = 50025;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Version Code"; rec."Version Code")
                {
                    ApplicationArea = all;
                }
                field("Test Method"; rec."Test Method")
                {
                    ApplicationArea = all;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = all;
                }
                field("Typical Value"; rec."Typical Value")
                {
                    ApplicationArea = all;
                }
                field("Min Value"; rec."Min Value")
                {
                    ApplicationArea = all;
                }
                field("Max Value"; rec."Max Value")
                {
                    ApplicationArea = all;
                }
                field(Result; rec.Result)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.SETCURRENTKEY("Item No.", "Version Code", "Line No.");
    end;

    // [Scope('Internal')]
    procedure GetSelectionFilterVarinat(): Code[80]
    var
        ItemVarParmeter: Record 50025;
        FirstItem: Code[30];
        LastItem: Code[30];
        SelectionFilter: Code[250];
        ItemCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(ItemVarParmeter);
        ItemCount := ItemVarParmeter.COUNT;
        IF ItemCount > 0 THEN BEGIN
            ItemVarParmeter.FIND('-');
            WHILE ItemCount > 0 DO BEGIN
                ItemCount := ItemCount - 1;
                ItemVarParmeter.MARKEDONLY(FALSE);
                FirstItem := ItemVarParmeter."Version Code";
                LastItem := FirstItem;
                More := (ItemCount > 0);
                WHILE More DO
                    IF ItemVarParmeter.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT ItemVarParmeter.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastItem := ItemVarParmeter."Version Code";
                            ItemCount := ItemCount - 1;
                            IF ItemCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstItem = LastItem THEN
                    SelectionFilter := SelectionFilter + FirstItem
                ELSE
                    SelectionFilter := SelectionFilter + FirstItem + '..' + LastItem;
                IF ItemCount > 0 THEN BEGIN
                    ItemVarParmeter.MARKEDONLY(TRUE);
                    ItemVarParmeter.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    //   [Scope('Internal')]
    procedure SetSelectionVarinat(var ItemVarParameter: Record 50025)
    begin
        CurrPage.SETSELECTIONFILTER(ItemVarParameter);
    end;
}


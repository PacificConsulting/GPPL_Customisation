page 50043 "Transfer Indent List"
{
    // Date        Version      Remarks
    // .....................................................................................
    // 09Mar2018   RB-N         Division Code & Division Name
    // 

    CardPageID = "Transfer indent";
    Editable = false;
    PageType = List;
    SourceTable = 50022;
    SourceTableView = SORTING("No.")
                      WHERE("Short Closed" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(group1)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'Indent No.';
                }
                field("Transfer indent Date"; rec."Transfer indent Date")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Name"; rec."Transfer-from Name")
                {
                    ApplicationArea = all;
                    Caption = 'Transfer-from Location';
                }
                field("Transfer-to Name"; rec."Transfer-to Name")
                {
                    ApplicationArea = all;
                    Caption = 'Transfer-to Location';
                }
                field(Approve; rec.Approve)
                {
                    ApplicationArea = all;
                }
                field("Short Closed"; rec."Short Closed")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Divsion Name"; DimName)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Print Order")
                {
                    ApplicationArea = all;
                    Caption = '&Print Order';
                    Image = Print;

                    trigger OnAction()
                    var
                        DocPrint: Codeunit 229;
                    begin
                        rectransferindent.RESET;
                        rectransferindent := Rec;
                        rectransferindent.SETRECFILTER;
                        REPORT.RUN(50148, TRUE, FALSE, rectransferindent);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        //>>RB-N 09Mar2018
        CLEAR(DimName);
        DimValue.RESET;
        IF DimValue.GET('DIVISION', rec."Shortcut Dimension 1 Code") THEN BEGIN
            DimName := DimValue.Name;
        END;
        //<<RB-N 09Mar2018
    end;

    trigger OnOpenPage()
    begin
        //>>10July2017 ShortClosed Code Added

        YearPart := DATE2DMY(TODAY, 3);
        MonthPart := DATE2DMY(TODAY, 2);

        TIndentHeader.RESET();
        TIndentHeader.SETFILTER(TIndentHeader."Short Closed", '=%1', FALSE);
        TIndentHeader.SETFILTER(TIndentHeader."Transfer indent Date", '<>%1', 0D);
        IF TIndentHeader.FINDFIRST THEN
            REPEAT
                NewDate := CALCDATE('-CM', TODAY) + 5;     //EBT091
                IF NewDate <= TODAY THEN                   //EBT091
                BEGIN
                    IF (DATE2DMY(TIndentHeader."Transfer indent Date", 3) <> YearPart) OR
                        (DATE2DMY(TIndentHeader."Transfer indent Date", 2) <> MonthPart)
                        AND (TIndentHeader."Transfer indent Date" < NewDate) THEN       //EBT091
                        BEGIN
                        TIndentHeader."Short Closed" := TRUE;
                        TIndentHeader.MODIFY();
                    END;
                END;
            UNTIL TIndentHeader.NEXT = 0;
        //<<10July2017 ShortClosed Code Added

        //EBT0001
        CSOMapping2.RESET;
        CSOMapping2.SETRANGE(CSOMapping2."User Id", UPPERCASE(USERID));
        IF CSOMapping2.FINDFIRST THEN BEGIN
            rec.FILTERGROUP(2);
            TIH.RESET;
            TIH.SETFILTER(TIH."Short Closed", '%1', FALSE);
            IF TIH.FINDSET THEN
                REPEAT
                    CSOMapping.RESET;
                    CSOMapping.SETRANGE(CSOMapping."User Id", UPPERCASE(USERID));
                    CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::"Responsibility Center");
                    CSOMapping.SETRANGE(CSOMapping.Value, TIH."Responsibility Center");
                    IF CSOMapping.FINDFIRST THEN
                        TIH.MARK := TRUE
                    ELSE BEGIN
                        CSOMapping1.RESET;
                        CSOMapping1.SETRANGE("User Id", UPPERCASE(USERID));
                        CSOMapping1.SETRANGE(Type, CSOMapping.Type::Location);
                        CSOMapping1.SETFILTER(Value, '%1|%2', TIH."Transfer-from Code", TIH."Transfer-to Code");
                        IF CSOMapping1.FINDFIRST THEN
                            TIH.MARK := TRUE
                    END;
                UNTIL TIH.NEXT = 0;
            TIH.MARKEDONLY(TRUE);
            rec.COPY(TIH);
            rec.FILTERGROUP(2);
        END;
        //EBT0001
    end;

    var
        //UserMgt: Codeunit 5700;
        Location: Record 14;
        Usersetup: Record 91;
        TrasnHdr: Record 50022;
        TransLine: Record 50023;
        i: Integer;
        TransferHeader: Record 50022;
        YearPart: Integer;
        MonthPart: Integer;
        RecordMarked: Boolean;
        Approve: Boolean;
        SalesSetup: Record 311;
        TransLineAppr: Record 5741;
        reclocationfrom: Record 14;
        reclocationto: Record 14;
        fromresp: Code[20];
        toresp: Code[20];
        recTransferIndentHeader: Record 50022;
        rectransferindent: Record 50022;
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        CSOMapping2: Record 50006;
        TIH: Record 50022;
        "---10July2017": Integer;
        TIndentHeader: Record 50022;
        NewDate: Date;
        "------09Mar2018": Integer;
        DimValue: Record 349;
        DimName: Text;
}


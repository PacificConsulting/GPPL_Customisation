table 50023 "Transfer Indent Line"
{
    // RSPL-CAS-04663-V8J3G6    Sourav Dey   Code added to modify the Salesperson only when the Indent is open

    DrillDownPageID = 50040;
    LookupPageID = 50040;

    fields
    {
        field(1; "Document No."; Code[30])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item WHERE("Inventory Posting Group" = FIELD("Inventory Posting Group"));

            trigger OnValidate()
            var
                TempTransferLine: Record "5741" temporary;
                InvSetup: Record "313";
            begin
                TransIndHeader.GET("Document No.");
                TransIndHeader.TESTFIELD("Transfer-from Code");
                TransIndHeader.TESTFIELD("Transfer-to Code");
                TransIndHeader.TESTFIELD("In-Transit Code");

                IF NOT (UPPERCASE(USERID) = 'SA') THEN BEGIN
                    IF Approve THEN BEGIN
                        ERROR('You cannot modify, its already Approved');
                    END;
                END;

                TESTFIELD("Inventory Posting Group");    //EBT/TRO/Item Filter/0001
                TESTFIELD("Qty Shipped", 0);

                item.GET("Item No.");
                item.TESTFIELD(Blocked, FALSE);
                VALIDATE(Description, item.Description);
                VALIDATE("Unit of Measure Code", item."Base Unit of Measure");
                VALIDATE("Description 2", item."Description 2");
                "Transfer-from Code" := TransIndHeader."Transfer-from Code";
                "Transfer-to Code" := TransIndHeader."Transfer-to Code";
                "In-Transit Code" := TransIndHeader."In-Transit Code";
                "Shortcut Dimension 1 Code" := TransIndHeader."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := TransIndHeader."Shortcut Dimension 2 Code";
                "Inventory Posting Group" := item."Inventory Posting Group";        //EBT/TRO/Item Filter/0001

                //pratyusha
                recItem.GET("Item No.");
                "Unit of Measure Code" := recItem."Sales Unit of Measure";
                //pratyusha
            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                TESTFIELD("Item No.");

                IF NOT (UPPERCASE(USERID) = 'SA') THEN BEGIN
                    IF Approve THEN BEGIN
                        ERROR('You cannot modify, its already Approved');
                    END;
                END;

                IF "Qty Shipped" = 0 THEN
                    "Outstanding Quantity" := Quantity;

                IF "Qty Shipped" > 0 THEN
                    ERROR('you cannot change the quantity');
            end;
        }
        field(6; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                TESTFIELD("Item No.");
                //  IF "Qty. to Ship">Quantity-"Qty Shipped" THEN     //Commented by EBT STIVAN (05072012)
                IF "Qty. to Ship" > Quantity - "Quantity Shipped" THEN  //EBT STIVAN (05072012)
                    ERROR('Please reduce the Quantity');
            end;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            var
                UnitOfMeasure: Record "204";
                UOMMgt: Codeunit "5402";
            begin
            end;
        }
        field(12; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
        field(13; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(14; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            Editable = true;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
        }
        field(15; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            Editable = true;
            TableRelation = Location WHERE("Closed" = CONST(false));
        }
        field(16; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            Editable = true;
            TableRelation = Location WHERE("Closed" = CONST(false));
        }
        field(17; Approve; Boolean)
        {
        }
        field(18; "Inventory To Location"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Transfer-to Code")));
            FieldClass = FlowField;
        }
        field(19; "Transfer Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Transfer Price';

            trigger OnValidate()
            begin
                TESTFIELD(Quantity);
                TESTFIELD("Item No.");

                IF NOT (UPPERCASE(USERID) = 'SA') THEN BEGIN
                    IF Approve THEN BEGIN
                        ERROR('You cannot modify, its already Approved');
                    END;
                END;
            end;
        }
        field(20; "Qty Shipped"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(21; "Qty to Adjust"; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Quantity);
                TESTFIELD("Item No.");

                IF (UPPERCASE(USERID) = 'SA') OR (UPPERCASE(USERID) = 'GT297') OR (UPPERCASE(USERID) = 'GT192')

                OR (UPPERCASE(USERID) = 'GT314') OR (UPPERCASE(USERID) = 'GT261') OR (UPPERCASE(USERID) = 'GT388') OR (UPPERCASE(USERID) = 'GT397') THEN
                    IF "Qty to Adjust" <= Quantity THEN BEGIN
                        "Outstanding Quantity" := "Outstanding Quantity" + "Qty to Adjust";
                        "Qty Shipped" := "Qty Shipped" - "Qty to Adjust";

                    END;
            end;
        }
        field(22; "Addition date"; Date)
        {
        }
        field(50000; "Quantity Shipped"; Decimal)
        {
            //CalcFormula = Sum("Transfer Shipment Line".Quantity WHERE("Transfer Indent No." = FIELD("Document No."),
            //                                                                       "Transfer Indent Line No." = FIELD("Line No.")));
            Description = 'EBT/TROIndent/0001';
            //   FieldClass = FlowField;
        }
        field(50008; "Package Qty"; Decimal)
        {
            Description = 'RSPL022';

            trigger OnValidate()
            begin
                //RSPL022 ++
                item.RESET;
                item.SETRANGE(item."No.", "Item No.");
                IF item.FINDFIRST THEN BEGIN
                    Quantity := item."No of Packages" * "Package Qty";
                END;
                //RSPL022 --
            end;
        }
        field(50154; "Approve User ID"; Code[50])
        {
            Description = 'EBT STIVAN 110112';
            Editable = false;
        }
        field(50155; "Approval Date"; Date)
        {
            Description = 'EBT STIVAN 110112';
            Editable = false;
        }
        field(50156; "Approval Time"; Time)
        {
            Description = 'EBT STIVAN 110112';
            Editable = false;
        }
        field(50157; Closed; Boolean)
        {
            Description = 'EBT STIVAN 110112';

            trigger OnValidate()
            begin
                /* //RSPL-TC
                //SN-BEGIN
                Memberof.RESET;
                Memberof.SETRANGE(Memberof."User ID",USERID);
                Memberof.SETRANGE(Memberof."Role ID",'INDENT APPROVAL');
                IF Memberof.FINDFIRST THEN
                */
                //RSPL-TC +
                AccessControl.RESET;
                AccessControl.SETRANGE("User Name", USERID);
                AccessControl.SETRANGE("Role ID", 'INDENT APPROVAL');
                IF AccessControl.FINDFIRST THEN //RSPL-TC -
                BEGIN
                    IF USERID <> 'sa' THEN BEGIN
                        RecSaleApproval.RESET;
                        RecSaleApproval.SETRANGE(RecSaleApproval."Approvar ID", USERID);
                        IF RecSaleApproval.FINDFIRST THEN BEGIN
                            "Approve User ID" := USERID;
                            "Approval Date" := TODAY;
                            "Approval Time" := TIME;
                        END ELSE
                            ERROR('You Dont have Permission for Transfer Indent Close');
                    END;
                END
                ELSE
                    ERROR('You Dont have Permission for Transfer Indent Close');

                //SN-END

                //RSPLSUM19Mar21>>
                CALCFIELDS("Quantity Shipped");
                IF ("Quantity Shipped" <> 0) AND ("Quantity Shipped" < Quantity) THEN
                    ERROR('This line cannot be closed, because Quantity is already shipped');
                //RSPLSUM19Mar21<<

            end;
        }
        field(50158; "Inventory Posting Group"; Code[10])
        {
            Description = '//EBT/TRO/Item Filter/0001';
            TableRelation = "Inventory Posting Group";

            trigger OnValidate()
            begin
                //EBT/TRO/Item Filter/0001
                //IF "Item No." <> '' THEN
                //   ERROR('You cannot change the Inventory Posting Group while Item is already selected');

                EBTTransferLine.RESET;
                EBTTransferLine.SETRANGE(EBTTransferLine."Document No.", "Document No.");
                EBTTransferLine.SETFILTER(EBTTransferLine."Line No.", '<>%1', "Line No.");
                IF EBTTransferLine.FINDFIRST THEN
                    IF EBTTransferLine."Inventory Posting Group" <> "Inventory Posting Group" THEN
                        ERROR('You cannot select %1 Inventory Group as you have selected %2 Inventory Group in PO %3, Line No. %4',
                              "Inventory Posting Group", EBTTransferLine."Inventory Posting Group",
                              EBTTransferLine."Document No.", EBTTransferLine."Line No.");
                //EBT/TRO/Item Filter/0001

                // EBT MILAN (301113)----TO Select Proper Inv. Posting Group Based on DIVISION----------START
                RecTransIndHdr.RESET;
                RecTransIndHdr.SETRANGE(RecTransIndHdr."No.", "Document No.");
                IF RecTransIndHdr.FINDFIRST THEN BEGIN
                    IF RecTransIndHdr."Shortcut Dimension 1 Code" = '' THEN
                        ERROR('Please Select Division Code');
                END;

                RecTransIndHdr.RESET;
                RecTransIndHdr.SETRANGE(RecTransIndHdr."No.", "Document No.");
                IF RecTransIndHdr.FINDFIRST THEN BEGIN
                    IF RecTransIndHdr."Shortcut Dimension 1 Code" = 'DIV-03' THEN BEGIN
                        IF "Inventory Posting Group" = 'AUTOOILS' THEN
                            ERROR('Selected Inventry Posting Group is Invalid, Select Proper Group');
                    END;
                    IF RecTransIndHdr."Shortcut Dimension 1 Code" = 'DIV-04' THEN BEGIN
                        IF "Inventory Posting Group" = 'INDOILS' THEN
                            ERROR('Selected Inventry Posting Group is Invalid, Select Proper Group');
                    END;
                END;
                // EBT MILAN (301113)----TO Select Proper Inv. Posting Group Based on DIVISION------------END
            end;
        }
        field(50159; "Salesperson Code"; Code[10])
        {
            Description = 'RSPL-CAS-04663-V8J3G6';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                TESTFIELD(Closed, FALSE); //RSPL-CAS-04663-V8J3G6
            end;
        }
        field(50160; "Trading Location"; Boolean)
        {
            //   CalcFormula = Lookup(Location."Trading Location" WHERE(Code = FIELD("Transfer-from Code")));
            // FieldClass = FlowField;
        }
        field(50161; MERCH; Code[20])
        {
            Description = 'RSPL-CAS-14103-P4B8D6';
            FieldClass = Normal;
            TableRelation = "Item wise Dimension Mapping"."Dimension Value" WHERE("Dimension Code" = CONST('MERCH'),
                                                                                   "Item Code" = FIELD("Item No."));
        }
        field(50162; "Merch Name"; Text[50])
        {
            Editable = false;
        }
        field(50163; Remarks; Text[100])
        {
            Description = 'RSPLSUM19Mar21';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Quantity;
        }
        key(Key2; "Item No.", "Outstanding Quantity")
        {
            SumIndexFields = "Outstanding Quantity";
        }
        key(Key3; "Item No.", "Transfer-from Code", "Outstanding Quantity")
        {
            SumIndexFields = "Outstanding Quantity";
        }
        key(Key4; "Unit of Measure Code")
        {
        }
        key(Key5; "Transfer-to Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Status = Status::Released THEN
            ERROR('You cannot delete this line');

        IF NOT (UPPERCASE(USERID) = 'SA') THEN BEGIN
            IF Approve THEN BEGIN
                ERROR('You cannot delete this line');
            END;
        END;
    end;

    trigger OnInsert()
    begin
        TransIndLine.RESET;
        TransIndLine.SETFILTER("Document No.", "Document No.");
        IF TransIndLine.FIND('+') THEN
            "Line No." := TransIndLine."Line No." + 10000;

        "Addition date" := TODAY;
    end;

    var
        item: Record 27;
        TransIndLine: Record 50023;
        TransIndHeader: Record 50022;
        recItem: Record 27;
        EBTTransferLine: Record 50023;
        RecTransIndHdr: Record 50022;
        RecSaleApproval: Record 50008;
        AccessControl: Record 2000000053;
}


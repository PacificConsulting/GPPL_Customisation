tableextension 50010 ItemExtCustm extends Item
{
    fields
    {
        field(50000; "QC Applicable"; Boolean)
        {
            Description = 'EBT/QC Func/0001';

            trigger OnValidate()
            var
                QCParameters: Record 50001;
                QCMaster1: Record 50000;
                QCMaster: Record 50000;
            begin
                //pm 01
                //EBT/QC Func/0001
                IF "Inventory Posting Group" <> 'BULK' THEN BEGIN
                    IF "QC Applicable" = FALSE THEN BEGIN
                        QCParameters.RESET;
                        QCParameters.SETRANGE("Item No.", "No.");
                        IF QCParameters.FINDFIRST THEN
                            IF CONFIRM('QC parameters already exists for this Item. Do you want to delete the parameters?', TRUE) THEN BEGIN
                                QCParameters.RESET;
                                QCParameters.SETRANGE("Item No.", "No.");
                                IF QCParameters.FINDSET THEN
                                    QCParameters.DELETEALL;
                            END
                            ELSE
                                ERROR('QC parameters already exists for this Item.');
                    END
                    ELSE BEGIN
                        IF "Inventory Posting Group" <> '' THEN BEGIN
                            QCMaster.RESET;
                            QCMaster.SETRANGE("Inventory Posting Group", "Inventory Posting Group");
                            IF QCMaster.FINDFIRST THEN BEGIN
                                IF CONFIRM('Do you want to copy the QC Parameter for this Item?', TRUE) THEN BEGIN
                                    REPEAT
                                        QCParameters.INIT;
                                        QCParameters.VALIDATE("Item No.", "No.");
                                        QCParameters."Inventory Posting Group" := "Inventory Posting Group";
                                        QCParameters.VALIDATE("Parameter Code", QCMaster."Parameter Code");
                                        QCParameters.Description := QCMaster.Description;
                                        QCParameters."Test Method" := QCMaster."Test Methods";
                                        QCParameters.INSERT;
                                    UNTIL QCMaster.NEXT = 0;
                                    MESSAGE('QC parameter has been copied');
                                END;
                            END;
                        END;
                    END;
                END;
                //EBT/QC Func/0001
            end;
        }
        field(50001; "Qty. on Indent"; Decimal)
        {
            CalcFormula = Sum("Transfer Indent Line"."Outstanding Quantity" WHERE("Item No." = FIELD("No."),
                                                                                   "Transfer-from Code" = FIELD("Location Filter"),
                                                                                   "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Outstanding Quantity" = FILTER(<> 0)));
            Description = 'EBT Indent/0001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Production Order Type"; Option)
        {
            OptionCaption = 'Primary,Secondary';
            OptionMembers = Primary,Secondary;
        }
        field(50003; "Density Factor Applicable"; Boolean)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50004; "Pack UOM Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50006; "Document Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo";
        }
        field(50007; "Created Date"; Date)
        {
            Description = 'EBT Milan Item Created Date';
        }
        field(50008; "Packing Material Weight in KG"; Decimal)
        {
            DecimalPlaces = 0 : 4;
            Description = 'RSPL';
        }
        field(50009; "No of Packages"; Integer)
        {
            Description = 'RSPL022';
        }
        field(50010; "FOC Applicable"; Boolean)
        {
            Description = '26Mar2019';
        }
        field(50020; Editable; Boolean)
        {
            Description = 'RSPLSUM 15Jun2020 to allow description editable';
        }
        field(50021; "Description 3"; Text[100])
        {
            Caption = 'Description 3';
            Description = 'RSPLSUM 29Dec2020';
        }
        field(50022; "Standard Yield"; Decimal)
        {
            Description = 'RSPLSUM 28Jan21';
        }
        field(50215; "Expected Output Quantity"; Decimal)
        {
            Description = 'DJ27739';
        }
        field(50300; "GST TDS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
            Editable = false;
        }
        field(52005; "Entry Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(52013; "Inventory Change"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Posting Date" = FIELD("Date Filter"),
                                                                  "Entry Type" = FIELD("Entry Type Filter"),
                                                                  "Document Type" = FIELD("Document Type Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(52014; "Next Counting Period"; Text[250])
        {
            Description = 'Migration/2016';
        }
        field(52015; "Parent SKU"; Boolean)
        {
            Description = 'RSPLDP';
        }
        field(52016; ParentItemCode; Code[50])
        {
            Description = 'RSPLDP';
        }
        modify("Inventory Posting Group")
        {
            trigger OnAfterValidate()
            var
                QCParameters: Record 50001;
                QCMaster: Record 50000;
                QCMaster1: Record 50000;
                QCParameters1: Record 50001;
            begin
                //EBT/QC Func/0001
                QCParameters.RESET;
                QCParameters.SETRANGE(QCParameters."Item No.", "No.");
                IF QCParameters.FINDSET THEN
                    QCParameters.DELETEALL;
                IF "QC Applicable" = TRUE THEN BEGIN
                    QCMaster.RESET;
                    QCMaster.SETRANGE(QCMaster."Inventory Posting Group", "Inventory Posting Group");
                    IF QCMaster.FINDFIRST THEN BEGIN
                        IF CONFIRM('Do you want to copy the QC parameters for this Item?', TRUE) THEN BEGIN
                            QCMaster1.RESET;
                            QCMaster1.SETRANGE("Inventory Posting Group", "Inventory Posting Group");
                            IF QCMaster1.FINDSET THEN
                                REPEAT
                                    QCParameters1.INIT;
                                    QCParameters1.VALIDATE("Item No.", "No.");
                                    QCParameters1."Parameter Code" := QCMaster1."Parameter Code";
                                    QCParameters1.Description := QCMaster1.Description;
                                    QCParameters1."Test Method" := QCMaster1."Test Methods";
                                    //QCParameters1.VALIDATE("Parameter Code",QCMaster1."Parameter Code");
                                    QCParameters1.INSERT;
                                UNTIL QCMaster1.NEXT = 0;
                            MESSAGE('QC parameters for this Item have been copied.');
                        END;
                    END;
                    //ELSE
                    //ERROR('QC parameter has not been defined for this Inventory Posting Group');
                END;
                //EBT/QC Func/0001

            end;
        }

    }
    trigger OnAfterInsert()
    var

    begin
        Rec.Validate("Created Date", Today);
        Rec.Validate("GST TDS", true);
    end;

    var
        myInt: Integer;
}
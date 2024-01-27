pageextension 60004 Item_Card_Ext extends "Item Card"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = EditableByRole;
        }
        modify("Base Unit of Measure")
        {
            Editable = EditableByRole;
        }
        modify("Shelf No.")
        {
            Editable = EditableByRole;
        }
        modify("Automatic Ext. Texts")
        {
            Editable = EditableByRole;
        }
        modify("Created From Nonstock Item")
        {
            Editable = EditableByRole;
        }
        modify("Item Category Code")
        {
            Editable = EditableByRole;
        }
        modify("Search Description")
        {
            Editable = EditableByRole;
        }
        modify(Inventory)
        {
            Editable = EditableByRole;
        }
        modify("Qty. on Prod. Order")
        {
            Editable = EditableByRole;
        }
        modify("Qty. on Purch. Order")
        {
            Editable = EditableByRole;
        }
        modify("Qty. on Component Lines")
        {
            Editable = EditableByRole;
        }
        modify("Qty. on Sales Order")
        {
            Editable = EditableByRole;
        }
        modify("Qty. on Service Order")
        {
            Editable = EditableByRole;
        }
        addafter("Qty. on Service Order")
        {
            field("Qty. on Indent"; rec."Qty. on Indent")
            {
                ApplicationArea = all;
                Editable = EditableByRole;
            }
        }
        modify("Service Item Group")
        {
            Editable = EditableByRole;
        }
        modify(Blocked)
        {
            Editable = EditableByRole;
        }

        modify("Last Date Modified")
        {
            Editable = EditableByRole;
        }
        addafter("Last Date Modified")
        {
            field("Created Date"; rec."Created Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter(PreventNegInventoryDefaultNo)
        {
            field("FOC Applicable"; rec."FOC Applicable")
            {
                ApplicationArea = all;
            }
            field(Editable; rec.Editable)
            {
                ApplicationArea = all;
                //Caption = 'Editable Description';
                CaptionML = ENU = 'Editable Description';
            }
            field("GST TDS"; rec."GST TDS")
            {
                ApplicationArea = all;
            }
            field(ParentItemCode; rec.ParentItemCode)
            {
                ApplicationArea = all;
            }
            field("Parent SKU"; rec."Parent SKU")
            {
                ApplicationArea = all;
            }
        }
        modify("Costing Method")
        {
            Editable = EditableByRole;
        }
        modify("Cost is Adjusted")
        {
            Editable = EditableByRole;
        }
        modify("Cost is Posted to G/L")
        {
            Editable = EditableByRole;
        }
        modify("Standard Cost")
        {
            Editable = EditableByRole;
        }
        modify("Unit Cost")
        {
            Editable = EditableByRole;
        }
        modify("Overhead Rate")
        {
            Editable = EditableByRole;
        }
        modify("Indirect Cost %")
        {
            Editable = EditableByRole;
        }
        modify("Last Direct Cost")
        {
            Editable = EditableByRole;
        }
        modify("Price/Profit Calculation")
        {
            Editable = EditableByRole;
        }
        modify("Profit %")
        {
            Editable = EditableByRole;
        }
        modify("Unit Price")
        {
            Editable = EditableByRole;
        }
        addafter("Unit Price")
        {
            field("No of Packages"; rec."No of Packages")
            {
                ApplicationArea = all;
            }

        }

        modify("Gen. Prod. Posting Group")
        {
            Editable = EditableByRole;
        }
        modify("Tax Group Code")
        {
            Editable = EditableByRole;
        }
        addafter(Exempted)
        {
            field("Density Factor Applicable"; rec."Density Factor Applicable")
            {
                ApplicationArea = all;
                Editable = EditableByRole;
                Style = Attention;
                StyleExpr = TRUE;
            }
            field("QC Applicable"; rec."QC Applicable")
            {
                ApplicationArea = all;
                Editable = EditableByRole;
                Style = Attention;
                StyleExpr = TRUE;
            }
        }
        addafter("Lot Size")
        {
            field("Production Order Type"; rec."Production Order Type")
            {
                ApplicationArea = all;
                Editable = EditableByRole;
            }
            field("Standard Yield"; rec."Standard Yield")
            {
                Editable = EditableByRole;
            }
        }
        addafter("Reordering Policy")
        {
            // field("Include Inventory"; rec."Include Inventory")
            // {
            //     ApplicationArea = all;
            //     Editable = EditableByRole;
            // }
        }
        addafter("Stockkeeping Unit Exists")
        {
            // field("Reorder Point"; rec."Reorder Point")
            // {
            //     ApplicationArea = all;
            //     Editable = EditableByRole;
            // }
            // field("Reorder Quantity"; rec."Reorder Quantity")
            // {
            //     ApplicationArea = all;
            //     Editable = EditableByRole;

            // }
        }

        addafter(Inventory)
        {
            field("Inventory in Sales UOM"; rec.Inventory / ItemUOM."Qty. per Unit of Measure")
            {
                ApplicationArea = all;
                Editable = false;
                Style = Attention;
                StyleExpr = TRUE;
                trigger OnDrillDown()
                begin
                    ILE.RESET;
                    ILE.SETRANGE(ILE."Item No.", rec."No.");
                    IF rec."Location Filter" <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", rec."Location Filter");
                    IF rec."Global Dimension 1 Filter" <> '' THEN
                        ILE.SETFILTER(ILE."Global Dimension 1 Code", rec."Global Dimension 1 Filter");
                    IF rec."Global Dimension 2 Filter" <> '' THEN
                        ILE.SETFILTER(ILE."Global Dimension 2 Code", rec."Global Dimension 2 Filter");
                    IF rec."Date Filter" <> 0D THEN
                        ILE.SETFILTER(ILE."Posting Date", '%1', rec."Date Filter");
                    PAGE.RUNMODAL(0, ILE);
                end;
            }
        }
        addafter("Item Category Code")
        {
            field("Inventory Change"; rec."Inventory Change")
            {
                ApplicationArea = all;
            }
            field("Location Filter"; rec."Location Filter")
            {
                ApplicationArea = all;
            }
            field("Date Filter"; rec."Date Filter")
            {
                ApplicationArea = all;
            }
            field("Packing Material Weight in KG"; rec."Packing Material Weight in KG")
            {
                ApplicationArea = all;
            }
            // field("Created Date"; rec."Created Date")
            // {
            //     ApplicationArea = all;
            // }
        }
        addafter(Description)
        {
            field("Description 3"; rec."Description 3")
            {
                ApplicationArea = all;
            }
        }
        addafter("Expiration Calculation")
        {
            // field("Common Item No."; rec."Common Item No.")
            // {
            //     ApplicationArea = all;
            //     Editable = EditableByRole;
            // }
        }

        // Add changes to page layout here
    }

    actions
    {
        // modify(Orders)
        // {
        //     RunObject = Page 50059;
        //     RunPageView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending);
        //     RunPageLink = "Document Type"=CONST("Blanket Order"),Type=CONST('Item');
        // }
        addafter("Return Orders")
        {
            action("QC Parameters")
            {
                ApplicationArea = all;
                RunObject = Page 50001;
                RunPageLink = "Item No." = FIELD("No.");
            }
        }
        addafter(ApplyTemplate)
        {
            action("Copy &QC Parameters")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    //pm 01
                    //EBT/QC Func/0001
                    IF rec."QC Applicable" = TRUE THEN BEGIN
                        QCMaster.RESET;
                        QCMaster.SETRANGE(QCMaster."Inventory Posting Group", rec."Inventory Posting Group");
                        IF QCMaster.FINDFIRST THEN BEGIN
                            IF CONFIRM('Do you want to copy the QC parameters for this Item?', TRUE) THEN BEGIN
                                QCParameters.RESET;
                                QCParameters.SETRANGE("Item No.", rec."No.");
                                IF QCParameters.FINDSET THEN
                                    QCParameters.DELETEALL;
                                QCMaster.RESET;
                                QCMaster.SETRANGE("Inventory Posting Group", rec."Inventory Posting Group");
                                IF QCMaster.FINDSET THEN
                                    REPEAT
                                        QCParameters.INIT;
                                        QCParameters.VALIDATE("Item No.", rec."No.");
                                        QCParameters.VALIDATE("Parameter Code", QCMaster."Parameter Code");
                                        QCParameters.INSERT;
                                    UNTIL QCMaster.NEXT = 0;
                                MESSAGE('QC parameters for this Item have been copied.');
                            END;
                        END
                        ELSE
                            ERROR('QC parameter has not been defined for this Item');
                    END
                    ELSE
                        ERROR('QC is not applicable for this Item');
                    //EBT/QC Func/0001
                end;
            }
            action("&Delete QC")
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    //pm 01
                    //EBT/QC Func/0001
                    IF rec."QC Applicable" = TRUE THEN BEGIN
                        IF CONFIRM('Do you want to delete the QC parameters for this Item?', TRUE) THEN BEGIN
                            QCParameters.RESET;
                            QCParameters.SETRANGE("Item No.", rec."No.");
                            IF QCParameters.FINDSET THEN BEGIN
                                QCParameters.DELETEALL;
                                MESSAGE('QC parameters for this Item have been deleted.');
                            END
                            ELSE
                                ERROR('No QC Parameter has been defined for this Item');
                        END;
                    END;
                    //EBT/QC Func/0001
                end;
            }
        }

        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        /*  {
                 //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Item Form will get Editable ----START
                 User.GET(USERID);
                 Memberof.RESET;
                 Memberof.SETRANGE(Memberof."User ID",User."User ID");
                 Memberof.SETRANGE(Memberof."Role ID",'ITEMCREATION');
                 IF NOT(Memberof.FINDFIRST) THEN
                 CurrForm.EDITABLE(FALSE);
                 //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Item Form will get Editable ------END
                 } */
        CurrPage.EDITABLE(FALSE);
        //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Item Form will get Editable ------END
        //RSPL-TC -

        //EBT STIVAN ---(07082012)--- A new Role has been created,as per the role the 2 field from Item Form will get Editable ----START
        AccessControl1.RESET;
        AccessControl1.SETRANGE("User Name", USERID);
        AccessControl1.SETFILTER("Role ID", '%1', 'ITEM MODIFY');
        IF NOT (AccessControl1.FINDFIRST) THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            EditableByRole := FALSE;
            EditableByRoleFalse := FALSE;
        END ELSE BEGIN
            EditableByRoleFalse := TRUE;
            EditableByRole := TRUE;
            CurrPage.EDITABLE(TRUE);

            //EBT STIVAN ---(07082012)--- A new Role has been created,as per the role the 2 field from Item Form will get Editable ------END

            //RSPLSUM 29Dec2020>>
            IF User."Description 3 Visible" THEN
                Desc3Visible := TRUE
            ELSE
                Desc3Visible := FALSE;
            //RSPLSUM 29Dec2020<<
        END;
    end;

    trigger OnClosePage()
    begin

        //EBT STIVAN ---(26042012)--- For ERROR MESSAGE For below Fields --------------START
        IF (rec."Item Category Code" = 'CAT03') OR (rec."Item Category Code" = 'CAT02') THEN BEGIN
            rec.TESTFIELD("Item Tracking Code");
            rec.TESTFIELD("Lot Nos.");
            rec.TESTFIELD("Item Category Code");
            rec.TESTFIELD("Sales Unit of Measure");
            //TESTFIELD("Tax Group Code"); //Commented as Per UNI SIR 20Jun2018
            rec.TESTFIELD("Gen. Prod. Posting Group");
            //TESTFIELD("Excise Prod. Posting Group"); //Commented asPer UNI SIR 13July2017

            // IF "MRP Value" <> TRUE THEN
            //     ERROR('MRP VALUE must be TRUE');

            IF rec."QC Applicable" <> TRUE THEN
                ERROR('QC Applicable must be TRUE');
        END;
        //EBT STIVAN ---(26042012)--- For ERROR MESSAGE For below Fields ----------------END
    END;

    trigger OnAfterGetRecord()
    begin
        //RSPLSUM 24Aug2020>>
        AccessControl2.RESET;
        AccessControl2.SETRANGE("User Name", USERID);
        AccessControl2.SETFILTER("Role ID", '%1', 'ITEM MODIFY');
        IF AccessControl2.FINDFIRST THEN
            EditableByRole := TRUE
        ELSE
            EditableByRole := FALSE;
        //RSPLSUM 24Aug2020<<

        //RSPLSUM 29Dec2020>>
        User.GET(USERID);
        IF User."Description 3 Visible" THEN
            Desc3Visible := TRUE
        ELSE
            Desc3Visible := FALSE;
        //RSPLSUM 29Dec2020<<

        IF ItemUOM.GET(rec."No.", rec."Sales Unit of Measure") THEN;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //RSPLSUM 28Dec2020>>
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETFILTER("Role ID", '%1', 'ITEMCREATION');
        IF NOT (AccessControl.FINDFIRST) THEN
            ERROR('You do not have permission, please contact system administrator');
        //RSPLSUM 28Dec2020<<

    end;



    var
        myInt: Integer;
        EditableByRole: Boolean;
        EditableByRoleFalse: Boolean;
        ItemUOM: Record 5404;
        QCParameters: Record 50001;
        ILE: Record 32;
        QCMaster: Record 50000;
        AccessControl1: Record 2000000053;
        AccessControl: Record 2000000053;
        User: Record 91;
        AccessControl2: Record 2000000053;
        Desc3Visible: Boolean;
}
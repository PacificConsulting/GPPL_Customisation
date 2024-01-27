page 50042 "Transfer Indent Subform"
{
    // EBT091  29.04.2014  Validation added while inserting lines.

    AutoSplitKey = true;
    Caption = 'Transfer Order Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    Permissions = TableData 32 = rimd;
    SourceTable = 50023;
    SourceTableView = WHERE(Closed = FILTER(false));
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(group1)
            {
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    applicationarea = all;

                    trigger OnValidate()
                    begin
                        //EBT091---Start
                        MonthPart := DATE2DMY(TODAY, 2);

                        TIndentHeader.RESET;
                        TIndentHeader.SETRANGE(TIndentHeader."No.", rec."Document No.");
                        IF TIndentHeader.FINDFIRST THEN BEGIN
                            IF DATE2DMY(TIndentHeader."Transfer indent Date", 2) <> MonthPart THEN
                                ERROR('You cannot insert line as this transfer indent belongs to previous month');
                        END;
                        //EBT091---End
                    end;
                }
                field("Item No."; rec."Item No.")
                {
                    applicationarea = all;

                    trigger OnValidate()
                    begin
                        //RSPLNC
                        recitem.SETRANGE("No.", rec."Item No.");
                        IF recitem.FINDSET THEN BEGIN
                            ParentItemCode := recitem.ParentItemCode;
                        END;
                        RemIn := 0;
                        IF recitem.GET(rec."Item No.") THEN BEGIN    //RSPLDP
                            ItemLeg.RESET;
                            ItemLeg.SETRANGE("Item No.", recitem.ParentItemCode);
                            ItemLeg.SETRANGE("Location Code", rec."Transfer-from Code");
                            IF ItemLeg.FINDSET THEN BEGIN
                                ItemLeg.CALCSUMS("Remaining Quantity");  //RSPLDP
                                RemIn := ItemLeg."Remaining Quantity";
                            END;
                        END;
                        IF RemIn <> 0 THEN BEGIN
                            MESSAGE(Text002 + '%1\' + Text003 + '%2\', RemIn, ParentItemCode);
                            IF CONFIRM('Do you still want to proceed?', TRUE) THEN BEGIN
                                MESSAGE('Kindly take approval from the Business Head.');
                                rec."Item No." := rec."Item No."
                            END
                            ELSE BEGIN
                                rec."Item No." := '';
                            END;
                        END;
                        //RSPLNC
                    end;
                }
                field("Line No."; rec."Line No.")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Quantity; rec.Quantity)
                {
                    applicationarea = all;
                }
                field("Package Qty"; rec."Package Qty")
                {
                    applicationarea = all;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    applicationarea = all;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Addition date"; rec."Addition date")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    applicationarea = all;
                }
                field("Transfer Price"; rec."Transfer Price")
                {
                    applicationarea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                    applicationarea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Description 2"; rec."Description 2")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("In-Transit Code"; rec."In-Transit Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Approve; rec.Approve)
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Inventory To Location"; rec."Inventory To Location")
                {
                    applicationarea = all;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    applicationarea = all;
                }
                field(MERCH; rec.MERCH)
                {
                    applicationarea = all;

                    trigger OnValidate()
                    begin
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE(DimensionValue.Code, 'MERCH');
                        IF DimensionValue.FINDSET THEN
                            rec."Merch Name" := DimensionValue.Name
                        ELSE
                            rec."Merch Name" := '';
                    end;
                }
                field("Merch Name"; rec."Merch Name")
                {
                    applicationarea = all;
                }
                field(Closed; rec.Closed)
                {
                    applicationarea = all;

                    trigger OnValidate()
                    begin
                        /*Usersetup.GET(USERID);
                        Memberof.RESET;
                        Memberof.SETRANGE(Memberof."User ID",Usersetup."User ID");
                        IF Memberof.FINDFIRST THEN
                        BEGIN
                        IF Memberof."Role ID" <> 'sales order approval' THEN
                        ERROR ('You do not have permission to close the line');
                        END;
                        */
                        //EBT STIVAN ---(18012012)--- TO Validate Error Message when user is closing the Particular line
                        //                              when user does not have rights to closed the Line----------------------------START

                        /*
                        Usersetup.GET(USERID);
                        Memberof.RESET;
                        Memberof.SETRANGE(Memberof."User ID",Usersetup."User ID");
                        Memberof.SETRANGE(Memberof."Role ID",'SALES ORDER APPROVAL');
                        IF Memberof.ISEMPTY THEN
                        ERROR ('You do not have permission to close the line');
                        */

                        //EBT STIVAN ---(18012012)--- TO Validate Error Message when user is closing the Particular line
                        //                              when user does not have rights to closed the Line------------------------------END


                        //Approval sales
                        Usersetup.GET(USERID);
                        Approval.SETRANGE(Approval."User ID", Usersetup."User ID");
                        IF NOT Approval.FINDFIRST THEN
                            ERROR('You do not have permission to close the line');

                    end;
                }
                field(Remarks; rec.Remarks)
                {
                    applicationarea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //EBT0002
        rec.CALCFIELDS("Quantity Shipped");
        rec."Outstanding Quantity" := rec.Quantity - rec."Quantity Shipped";
        //EBT0002


        DimensionValue.RESET;
        DimensionValue.SETRANGE(DimensionValue.Code, 'MERCH');
        IF DimensionValue.FINDSET THEN
            rec."Merch Name" := DimensionValue.Name
        ELSE
            rec."Merch Name" := '';
        CLEAR(QtyEdit);
        CLEAR(PackageQtyEdit);
        IF UPPERCASE(USERID) <> 'SA' THEN BEGIN
            IF rec.Approve = TRUE THEN BEGIN
                QtyEdit := FALSE;
                PackageQtyEdit := FALSE;
            END ELSE BEGIN
                QtyEdit := TRUE;
                PackageQtyEdit := TRUE;
            END;
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        rec.TESTFIELD("Item No.");//09Mar2018
        rec.TESTFIELD(Quantity);//09Mar2018
    end;

    trigger OnOpenPage()
    begin
        IF rec.Quantity <> 0 THEN
            rec.SETFILTER("Outstanding Quantity", '<>%1', 0);

        DimensionValue.RESET;
        DimensionValue.SETRANGE(DimensionValue.Code, 'MERCH');
        IF DimensionValue.FINDSET THEN
            rec."Merch Name" := DimensionValue.Name
        ELSE
            rec."Merch Name" := '';
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        //recRG23D: Record "16537";
        recitem: Record 27;
        Usersetup: Record 91;
        SalesSetup: Record 311;
        Approval: Record 50008;
        MonthPart: Integer;
        TIndentHeader: Record 50022;
        DimensionValue: Record 349;
        QtyEdit: Boolean;
        PackageQtyEdit: Boolean;
        ItemLeg: Record 32;
        ParentItemCode: Code[50];
        RemIn: Decimal;
        Text002: Label 'The remaining quantity ';
        Text003: Label 'is available in the old Item code';

    //[Scope('Internal')]
    procedure ShowDimensions()
    begin
    end;

    //  [Scope('Internal')]
    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location)
    begin
    end;

    // [Scope('Internal')]
    procedure ShowReservation()
    begin
    end;

    // [Scope('Internal')]
    procedure OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
    end;

    //  [Scope('Internal')]
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
    end;

    //[Scope('Internal')]
    procedure ShowStrDetailsForm()
    var
    //StrOrderLineDetails: Record 13795;
    begin
    end;
}


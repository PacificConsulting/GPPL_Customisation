// page 50028 "Item Card New"
// {
//     // 02/01/2012 //EBT/QC Func/0001 For QC Functionality

//     Caption = 'Item Card';
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = 27;
//     SourceTableView = WHERE(Blocked = FILTER(false));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     applicationarea = all;
//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     ShowMandatory = true;
//                 }
//                 field("Base Unit of Measure"; rec."Base Unit of Measure")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                 }
//                 field("Assembly BOM"; rec."Assembly BOM")
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//                 field("Shelf No."; "Shelf No.")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Automatic Ext. Texts"; "Automatic Ext. Texts")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Created From Nonstock Item"; rec."Created From Nonstock Item")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Item Category Code"; rec."Item Category Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;

//                     trigger OnValidate()
//                     begin
//                         EnableCostingControls;
//                     end;
//                 }
//                 field("Product Group Code"; rec."Product Group Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Inventory Change"; rec."Inventory Change")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Location Filter"; rec."Location Filter")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Date Filter"; rec."Date Filter")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Packing Material Weight in KG"; rec."Packing Material Weight in KG")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Search Description"; rec."Search Description")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field(Inventory; Inventory)
//                 {
//                     applicationarea = all;
//                     Caption = 'Inventory in Base UOM';
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field(Inventory/ItemUOM."Qty. per Unit of Measure";
//                     rec.Inventory/ItemUOM."Qty. per Unit of Measure")
//                 {
//                     applicationarea = all;
//                     Caption = 'Inventory in Sales UOM';
//                     Editable = false;
//                     Style = Attention;
//                     StyleExpr = TRUE;

//                     trigger OnDrillDown()
//                     begin
//                         ILE.RESET;
//                         ILE.SETRANGE(ILE."Item No.", "No.");
//                         IF "Location Filter" <> '' THEN
//                             ILE.SETFILTER(ILE."Location Code", "Location Filter");
//                         IF "Global Dimension 1 Filter" <> '' THEN
//                             ILE.SETFILTER(ILE."Global Dimension 1 Code", "Global Dimension 1 Filter");
//                         IF "Global Dimension 2 Filter" <> '' THEN
//                             ILE.SETFILTER(ILE."Global Dimension 2 Code", "Global Dimension 2 Filter");
//                         IF "Date Filter" <> 0D THEN
//                             ILE.SETFILTER(ILE."Posting Date", '%1', "Date Filter");
//                         PAGE.RUNMODAL(0, ILE);
//                     end;
//                 }
//                 field("Qty. on Purch. Order"; rec."Qty. on Purch. Order")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Qty. on Prod. Order"; rec."Qty. on Prod. Order")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Qty. on Component Lines"; rec."Qty. on Component Lines")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Qty. on Sales Order"; rec."Qty. on Sales Order")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Qty. on Service Order"; rec."Qty. on Service Order")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Qty. on Indent"; rec."Qty. on Indent")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Service Item Group"; rec."Service Item Group")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field(Blocked; rec.Blocked)
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Qty. on Assembly Order"; rec."Qty. on Assembly Order")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Qty. on Asm. Component"; rec."Qty. on Asm. Component")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Last Date Modified"; rec."Last Date Modified")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field(StockoutWarningDefaultYes; rec."Stockout Warning")
//                 {
//                     applicationarea = all;
//                     Caption = 'Stockout Warning';
//                     OptionCaption = 'Default (Yes),No,Yes';
//                     Visible = ShowStockoutWarningDefaultYes;
//                 }
//                 field(StockoutWarningDefaultNo; rec."Stockout Warning")
//                 {
//                     applicationarea = all;
//                     Caption = 'Stockout Warning';
//                     OptionCaption = 'Default (No),No,Yes';
//                     Visible = ShowStockoutWarningDefaultNo;
//                 }
//                 field(PreventNegInventoryDefaultYes; "Prevent Negative Inventory")
//                 {
//                     applicationarea = all;
//                     Caption = 'Prevent Negative Inventory';
//                     OptionCaption = 'Default (Yes),No,Yes';
//                     Visible = ShowPreventNegInventoryDefaultYes;
//                 }
//                 field(PreventNegInventoryDefaultNo; rec."Prevent Negative Inventory")
//                 {
//                     applicationarea = all;
//                     Caption = 'Prevent Negative Inventory';
//                     OptionCaption = 'Default (No),No,Yes';
//                     Visible = ShowPreventNegInventoryDefaultNo;
//                 }
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Costing Method"; rec."Costing Method")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         EnableCostingControls;
//                     end;
//                 }
//                 field("Cost is Adjusted"; rec."Cost is Adjusted")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Cost is Posted to G/L"; rec."Cost is Posted to G/L")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Standard Cost"; rec."Standard Cost")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Enabled = StandardCostEnable;

//                     trigger OnDrillDown()
//                     var
//                         ShowAvgCalcItem: Codeunit "5803";
//                     begin
//                         ShowAvgCalcItem.DrillDownAvgCostAdjmtPoint(Rec)
//                     end;
//                 }
//                 field("Unit Cost"; rec."Unit Cost")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Enabled = UnitCostEnable;

//                     trigger OnDrillDown()
//                     var
//                         ShowAvgCalcItem: Codeunit "5803";
//                     begin
//                         ShowAvgCalcItem.DrillDownAvgCostAdjmtPoint(Rec)
//                     end;
//                 }
//                 field("Overhead Rate"; rec."Overhead Rate")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Indirect Cost %"; rec."Indirect Cost %")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Last Direct Cost"; rec."Last Direct Cost")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Price/Profit Calculation"; rec."Price/Profit Calculation")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Profit %"; rec."Profit %")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Unit Price"; rec."Unit Price")
//                 {

//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field("No of Packages"; rec."No of Packages")
//                 {

//                     applicationarea = all;
//                 }
//                 field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                 }
//                 field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     ShowMandatory = true;
//                 }
//                 field("Excise Prod. Posting Group"; rec."Excise Prod. Posting Group")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field("Tax Group Code"; rec."Tax Group Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field("Density Factor Applicable"; rec."Density Factor Applicable")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//                 field("QC Applicable"; rec."QC Applicable")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//                 field("Inventory Posting Group"; rec."Inventory Posting Group")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                 }
//                 field("Default Deferral Template Code"; rec."Default Deferral Template Code")
//                 {
//                     applicationarea = all;
//                     Caption = 'Default Deferral Template';
//                 }
//                 field("Net Invoiced Qty."; rec."Net Invoiced Qty.")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Item Disc. Group"; rec."Item Disc. Group")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Sales Unit of Measure"; rec."Sales Unit of Measure")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Application Wksh. User ID"; rec."Application Wksh. User ID")
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//             }
//             group(Replenishment)
//             {
//                 Caption = 'Replenishment';
//                 field("Replenishment System"; rec."Replenishment System")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 group(Purchase)
//                 {
//                     Caption = 'Purchase';
//                     Editable = EditableByRole;
//                     field("Vendor No."; rec."Vendor No.")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Vendor Item No."; rec."Vendor Item No.")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Purch. Unit of Measure"; rec."Purch. Unit of Measure")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Lead Time Calculation"; rec."Lead Time Calculation")
//                     {
//                         Editable = EditableByRole;
//                     }
//                 }
//                 group(Production)
//                 {
//                     Caption = 'Production';
//                     field("Manufacturing Policy"; rec."Manufacturing Policy")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Routing No."; rec."Routing No.")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRoleFalse;
//                     }
//                     field("Production BOM No."; rec."Production BOM No.")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRoleFalse;
//                     }
//                     field("Rounding Precision"; rec."Rounding Precision")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Flushing Method"; rec."Flushing Method")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Scrap %"; rec."Scrap %")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Lot Size"; rec."Lot Size")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Production Order Type"; rec."Production Order Type")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                 }
//                 group(Assembly)
//                 {
//                     Caption = 'Assembly';
//                     field("Assembly Policy"; rec."Assembly Policy")
//                     {
//                         applicationarea = all;
//                     }
//                 }
//             }
//             group(Planning)
//             {
//                 Caption = 'Planning';
//                 field("Reordering Policy"; rec."Reordering Policy")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         EnablePlanningControls
//                     end;
//                 }
//                 field("Include Inventory"; rec."Include Inventory")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field(Reserve; Reserve)
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field("Order Tracking Policy"; rec."Order Tracking Policy")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Stockkeeping Unit Exists"; rec."Stockkeeping Unit Exists")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field(Critical; rec.Critical)
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Safety Lead Time"; rec."Safety Lead Time")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Enabled = SafetyLeadTimeEnable;
//                 }
//                 field("Safety Stock Quantity"; rec."Safety Stock Quantity")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Enabled = SafetyStockQtyEnable;
//                 }
//                 field("Reorder Point"; rec."Reorder Point")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Reorder Quantity"; rec."Reorder Quantity")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Maximum Inventory"; rec."Maximum Inventory")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Enabled = MaximumInventoryEnable;
//                 }
//                 field("Dampener Period"; rec."Dampener Period")
//                 {
//                     applicationarea = all;
//                     Enabled = DampenerPeriodEnable;
//                     Visible = false;
//                 }
//                 field("Dampener Quantity"; rec."Dampener Quantity")
//                 {
//                     applicationarea = all;
//                     Enabled = DampenerQtyEnable;
//                     Visible = false;
//                 }
//                 group("Lot-for-Lot Parameters")
//                 {
//                     Caption = 'Lot-for-Lot Parameters';
//                     field("Lot Accumulation Period"; rec."Lot Accumulation Period")
//                     {
//                         applicationarea = all;
//                         Enabled = LotAccumulationPeriodEnable;
//                     }
//                     field("Rescheduling Period"; rec."Rescheduling Period")
//                     {
//                         applicationarea = all;
//                         Enabled = ReschedulingPeriodEnable;
//                     }
//                 }
//                 group("Reorder-Point Parameters")
//                 {
//                     Caption = 'Reorder-Point Parameters';
//                     grid(grid1)
//                     {
//                         GridLayout = Rows;
//                         group(group1)
//                         {
//                         }
//                     }
//                     field("Overflow Level"; rec."Overflow Level")
//                     {
//                         applicationarea = all;
//                         Enabled = OverflowLevelEnable;
//                         Importance = Additional;
//                     }
//                     field("Time Bucket"; rec."Time Bucket")
//                     {
//                         applicationarea = all;
//                         Enabled = TimeBucketEnable;
//                         Importance = Additional;
//                     }
//                 }
//                 group("Order Modifiers")
//                 {
//                     Caption = 'Order Modifiers';
//                     grid(grid2)
//                     {
//                         GridLayout = Rows;
//                         group(group2)
//                         {
//                             field("Minimum Order Quantity"; rec."Minimum Order Quantity")
//                             {
//                                 applicationarea = all;
//                                 Editable = EditableByRole;
//                                 Enabled = MinimumOrderQtyEnable;
//                             }
//                             field("Maximum Order Quantity"; rec."Maximum Order Quantity")
//                             {
//                                 applicationarea = all;
//                                 Enabled = MaximumOrderQtyEnable;
//                             }
//                             field("Order Multiple"; rec."Order Multiple")
//                             {
//                                 applicationarea = all;
//                                 Editable = EditableByRole;
//                                 Enabled = OrderMultipleEnable;
//                             }
//                         }
//                     }
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field(GTIN; rec.GTIN)
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//                 field("Tariff No."; rec."Tariff No.")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Country/Region of Origin Code"; rec."Country/Region of Origin Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Net Weight"; rec."Net Weight")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Gross Weight"; rec."Gross Weight")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//             }
//             group("Item Tracking")
//             {
//                 Caption = 'Item Tracking';
//                 field("Item Tracking Code"; rec."Item Tracking Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field("Serial Nos."; rec."Serial Nos.")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Lot Nos."; rec."Lot Nos.")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Expiration Calculation"; rec."Expiration Calculation")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//             }
//             group("E-Commerce")
//             {
//                 Caption = 'E-Commerce';
//                 group(BiZTalk)
//                 {
//                     Caption = 'BiZTalk';
//                     field("Common Item No."; rec."Common Item No.")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 field("Special Equipment Code"; rec."Special Equipment Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Put-away Template Code"; rec."Put-away Template Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Put-away Unit of Measure Code"; rec."Put-away Unit of Measure Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field("Phys Invt Counting Period Code"; rec."Phys Invt Counting Period Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                     Importance = Promoted;
//                 }
//                 field("Last Phys. Invt. Date"; rec."Last Phys. Invt. Date")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Last Counting Period Update"; rec."Last Counting Period Update")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Next Counting Start Date"; rec."Next Counting Start Date")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Next Counting End Date"; rec."Next Counting End Date")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Identifier Code"; rec."Identifier Code")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Use Cross-Docking"; rec."Use Cross-Docking")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//             }
//             group("Tax Information")
//             {
//                 Caption = 'Tax Information';
//                 field("MRP Value"; rec."MRP Value")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("MRP Price"; rec."MRP Price")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Abatement %"; rec."Abatement %")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Price Inclusive of Tax"; rec."Price Inclusive of Tax")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("PIT Structure"; rec."PIT Structure")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 field("Unit Price2"; rec."Unit Price")
//                 {
//                     applicationarea = all;
//                     Editable = EditableByRole;
//                 }
//                 group("Sub Contracting")
//                 {
//                     Caption = 'Sub Contracting';
//                     field(Subcontracting; rec.Subcontracting)
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Sub. Comp. Location"; rec."Sub. Comp. Location")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                 }
//                 group(Excise)
//                 {
//                     Caption = 'Excise';
//                     field("Scrap Item"; rec."Scrap Item")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Capital Item"; rec."Capital Item")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Excise Accounting Type"; rec."Excise Accounting Type")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                     field("Assessable Value"; rec."Assessable Value")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                 }
//                 group(VAT)
//                 {
//                     Caption = 'VAT';
//                     field("Fixed Asset"; rec."Fixed Asset")
//                     {
//                         applicationarea = all;
//                         Editable = EditableByRole;
//                     }
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(part1; 875)
//             {
//                 SubPageLink = "Source Type" = CONST(Item),
//                               "Source No." = FIELD("No.");
//                 Visible = SocialListeningVisible;
//                 applicationarea = all;
//                 applicationarea = all;
//             }
//             part(part2; 876)
//             {
//                 SubPageLink = "Source Type" = CONST(Item),
//                               "Source No." = FIELD("No.");
//                 UpdatePropagation = Both;
//                 Visible = SocialListeningSetupVisible;
//                 applicationarea = all;
//                 applicationarea = all;
//             }
//             part(WorkflowStatus; 1528)
//             {
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//                 applicationarea = all;
//                 applicationarea = all;
//             }
//             systempart(part3; Links)
//             {
//                 Visible = true;
//                 applicationarea = all;
//                 applicationarea = all;
//             }
//             systempart(part4; Notes)
//             {
//                 Visible = true;
//                 applicationarea = all;
//                 applicationarea = all;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Master Data")
//             {
//                 Caption = 'Master Data';
//                 Image = "<DataEntry>";
//                 action("&Units of Measure")
//                 {
//                     Caption = '&Units of Measure';
//                     Image = UnitOfMeasure;
//                     RunObject = Page 5404;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//                 action("Va&riants")
//                 {
//                     Caption = 'Va&riants';
//                     Image = ItemVariant;
//                     RunObject = Page 5401;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//                 group(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                 }
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     RunObject = Page 540;
//                     RunPageLink = "Table ID" = CONST(27),
//                                   "No." = FIELD("No.");
//                     ShortCutKey = 'Shift+Ctrl+D';
//                 }
//                 action("Substituti&ons")
//                 {
//                     Caption = 'Substituti&ons';
//                     Image = ItemSubstitution;
//                     RunObject = Page 5716;
//                     RunPageLink = Type = CONST(Item),
//                                   "No." = FIELD("No.");
//                 }
//                 action("Cross Re&ferences")
//                 {
//                     Caption = 'Cross Re&ferences';
//                     Image = Change;
//                     RunObject = Page 5721;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//                 action("E&xtended Texts")
//                 {
//                     Caption = 'E&xtended Texts';
//                     applicationarea = all;
//                     Image = Text;
//                     RunObject = Page 391;
//                     RunPageLink = "Table Name" = CONST(Item),
//                                   "No." = FIELD("No.");
//                     RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
//                 }
//                 action(Translations)
//                 {
//                     Caption = 'Translations';
//                     Image = Translations;
//                     RunObject = Page 35;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//                 action("&Picture")
//                 {
//                     Caption = '&Picture';
//                     Image = Picture;
//                     RunObject = Page 346;
//                     RunPageLink = "No." = FIELD("No."),
//                                   "Date Filter" = FIELD("Date Filter"),
//                                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
//                                   "Location Filter" = FIELD("Location Filter"),
//                                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
//                                   "Variant Filter" = FIELD("Variant Filter");
//                     applicationarea = all;
//                 }
//                 action(Identifiers)
//                 {
//                     Caption = 'Identifiers';
//                     Image = BarCode;
//                     RunObject = Page 7706;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
//                     applicationarea = all;
//                 }
//                 action("ECC No./Item Categories")
//                 {
//                     Caption = 'ECC No./Item Categories';
//                     RunObject = Page 16494;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//             }
//             group(ActionGroupCRM)
//             {
//                 Caption = 'Dynamics CRM';
//                 Visible = CRMIntegrationEnabled;
//                 action(CRMGoToProduct)
//                 {
//                     Caption = 'Product';
//                     Image = CoupledItem;
//                     ToolTip = 'Open the coupled Microsoft Dynamics CRM product.';
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit 5330;
//                     begin
//                         CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
//                     end;
//                 }
//                 action(CRMSynchronizeNow)
//                 {
//                     AccessByPermission = TableData 5331 = IM;
//                     Caption = 'Synchronize Now';
//                     Image = Refresh;
//                     ToolTip = 'Send updated data to Microsoft Dynamics CRM.';
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit "5330";
//                     begin
//                         CRMIntegrationManagement.UpdateOneNow(RECORDID);
//                     end;
//                 }
//                 group(Coupling)
//                 {
//                     Caption = 'Coupling', Comment = 'Coupling is a noun';
//                     applicationarea = all;
//                     Image = LinkAccount;
//                     ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
//                     action(ManageCRMCoupling)
//                     {
//                         AccessByPermission = TableData 5331 = IM;
//                         applicationarea = all;
//                         Caption = 'Set Up Coupling';
//                         Image = LinkAccount;
//                         ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM product.';

//                         trigger OnAction()
//                         var
//                             CRMIntegrationManagement: Codeunit "5330";
//                         begin
//                             CRMIntegrationManagement.CreateOrUpdateCoupling(RECORDID);
//                         end;
//                     }
//                     action(DeleteCRMCoupling)
//                     {
//                         AccessByPermission = TableData 5331 = IM;
//                         applicationarea = all;
//                         Caption = 'Delete Coupling';
//                         Enabled = CRMIsCoupledToRecord;
//                         Image = UnLinkAccount;
//                         ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM product.';

//                         trigger OnAction()
//                         var
//                             CRMCouplingManagement: Codeunit "5331";
//                         begin
//                             CRMCouplingManagement.RemoveCoupling(RECORDID);
//                         end;
//                     }
//                 }
//             }
//             group(Availability)
//             {
//                 Caption = 'Availability';
//                 Image = ItemAvailability;
//                 action(ItemsByLocation)
//                 {
//                     AccessByPermission = TableData 14 = R;
//                     Caption = 'Items b&y Location';
//                     Image = ItemAvailbyLoc;
//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         ItemsByLocation: Page "491";
//                     begin
//                         ItemsByLocation.SETRECORD(Rec);
//                         ItemsByLocation.RUN;
//                     end;
//                 }
//                 group("&Item Availability by")
//                 {
//                     Caption = '&Item Availability by';
//                     Image = ItemAvailability;
//                     action("<Action110>")
//                     {
//                         Caption = 'Event';
//                         Image = "Event";
//                         applicationarea = all;
//                         trigger OnAction()
//                         begin
//                             ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByEvent);
//                         end;
//                     }
//                     action(Period)
//                     {
//                         Caption = 'Period';
//                         Image = Period;
//                         RunObject = Page 157;
//                         RunPageLink = "No." = FIELD("No."),
//                                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                                       "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
//                                       "Location Filter" = FIELD("Location Filter"),
//                                      " Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
//                                       "Variant Filter" = FIELD("Variant Filter");
//                         applicationarea = all;
//                     }
//                     action(Variant)
//                     {
//                         Caption = 'Variant';
//                         Image = ItemVariant;
//                         RunObject = Page 5414;
//                         RunPageLink = "No." = FIELD("No."),
//                                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                                       "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
//                                       "Location Filter" = FIELD("Location Filter"),
//                                       "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
//                                       "Variant Filter" = FIELD("Variant Filter");
//                         applicationarea = all;
//                     }
//                     action(Location)
//                     {
//                         Caption = 'Location';
//                         Image = Warehouse;
//                         RunObject = Page 492;
//                         RunPageLink = "No." = FIELD("No."),
//                                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                                       "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
//                                       "Location Filter" = FIELD("Location Filter"),
//                                       "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
//                                       "Variant Filter" = FIELD("Variant Filter");
//                         applicationarea = all;
//                     }
//                     action("BOM Level")
//                     {
//                         Caption = 'BOM Level';
//                         Image = BOMLevel;
//                         applicationarea = all;
//                         trigger OnAction()
//                         begin
//                             ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByBOM);
//                         end;
//                     }
//                     action(Timeline)
//                     {
//                         Caption = 'Timeline';
//                         Image = Timeline;
//                         applicationarea = all;
//                         trigger OnAction()
//                         begin
//                             ShowTimelineFromItem(Rec);
//                         end;
//                     }
//                 }
//             }
//             group(History)
//             {
//                 Caption = 'History';
//                 Image = History;
//                 group("E&ntries")
//                 {
//                     Caption = 'E&ntries';
//                     Image = Entries;
//                     action("Ledger E&ntries")
//                     {
//                         Caption = 'Ledger E&ntries';
//                         Image = ItemLedger;
//                         Promoted = false;
//                         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                         //PromotedCategory = Process;
//                         RunObject = Page 38;
//                         RunPageLink = "Item No." = FIELD("No.");
//                         RunPageView = SORTING("Item No.");
//                         ShortCutKey = 'Ctrl+F7';
//                         applicationarea = all;
//                     }
//                     action("&Reservation Entries")
//                     {
//                         applicationarea = all;
//                         Caption = '&Reservation Entries';
//                         Image = ReservationLedger;
//                         RunObject = Page 497;
//                         RunPageLink = "Reservation Status" = CONST(Reservation),
//                                       "Item No." = FIELD("No.");
//                         RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
//                     }
//                     action("&Phys. Inventory Ledger Entries")
//                     {
//                         applicationarea = all;
//                         Caption = '&Phys. Inventory Ledger Entries';
//                         Image = PhysicalInventoryLedger;
//                         RunObject = Page 390;
//                         RunPageLink = "Item No." = FIELD("No.");
//                         RunPageView = SORTING("Item No.");
//                     }
//                     action("&Value Entries")
//                     {
//                         applicationarea = all;
//                         Caption = '&Value Entries';
//                         Image = ValueLedger;
//                         RunObject = Page 5802;
//                         RunPageLink = "Item No." = FIELD("No.");
//                         RunPageView = SORTING("Item No.");
//                     }
//                     action("Item &Tracking Entries")
//                     {
//                         Caption = 'Item &Tracking Entries';
//                         Image = ItemTrackingLedger;
//                         applicationarea = all;
//                         trigger OnAction()
//                         var
//                             ItemTrackingDocMgt: Codeunit "6503";
//                         begin
//                             ItemTrackingDocMgt.ShowItemTrackingForMasterData(3, '', "No.", '', '', '', '');
//                         end;
//                     }
//                     action("&Warehouse Entries")
//                     {
//                         applicationarea = all;
//                         Caption = '&Warehouse Entries';
//                         Image = BinLedger;
//                         RunObject = Page 7318;
//                         RunPageLink = "Item No." = FIELD("No.");
//                         RunPageView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
//                     }
//                     action("Application Worksheet")
//                     {
//                         applicationarea = all;
//                         Caption = 'Application Worksheet';
//                         Image = ApplicationWorksheet;
//                         RunObject = Page 521;
//                         RunPageLink = "Item No." = FIELD("No.");
//                     }
//                 }
//                 group(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     action(Statistics)
//                     {
//                         Caption = 'Statistics';
//                         Image = Statistics;
//                         Promoted = true;
//                         PromotedCategory = Process;
//                         ShortCutKey = 'F7';
//                         applicationarea = all;

//                         trigger OnAction()
//                         var
//                             ItemStatistics: Page 5827;
//                         begin
//                             ItemStatistics.SetItem(Rec);
//                             ItemStatistics.RUNMODAL;
//                         end;
//                     }
//                     action("Entry Statistics")
//                     {
//                         Caption = 'Entry Statistics';
//                         Image = EntryStatistics;
//                         RunObject = Page 304;
//                         RunPageLink = "No." = FIELD("No."),
//                                       "Date Filter" = FIELD("Date Filter"),
//                                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                                       "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
//                                       "Location Filter" = FIELD("Location Filter"),
//                                       "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
//                                       "Variant Filter" = FIELD("Variant Filter");
//                         applicationarea = all;
//                     }
//                     action("T&urnover")
//                     {
//                         Caption = 'T&urnover';
//                         Image = Turnover;
//                         RunObject = Page 158;
//                         RunPageLink = "No." = FIELD("No."),
//                                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                                       "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
//                                       "Location Filter" = FIELD("Location Filter"),
//                                       "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
//                                       "Variant Filter" = FIELD("Variant Filter");
//                         applicationarea = all;
//                     }
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 124;
//                     RunPageLink = "Table Name" = CONST(Item),
//                                   "No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//             }
//             group("&Purchases")
//             {
//                 Caption = '&Purchases';
//                 Image = Purchasing;
//                 action("Ven&dors")
//                 {
//                     Caption = 'Ven&dors';
//                     Image = Vendor;
//                     RunObject = Page 114;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     RunPageView = SORTING("Item No.");
//                     applicationarea = all;
//                 }
//                 action(Prices1)
//                 {
//                     Caption = 'Prices';
//                     Image = Price;
//                     RunObject = Page 7012;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     RunPageView = SORTING("Item No.");
//                     applicationarea = all;
//                 }
//                 action("Line Discounts1")
//                 {
//                     Caption = 'Line Discounts';
//                     Image = LineDiscount;
//                     RunObject = Page 7014;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//                 action("Prepa&yment Percentages1")
//                 {
//                     Caption = 'Prepa&yment Percentages';
//                     Image = PrepaymentPercentages;
//                     RunObject = Page 665;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//                 separator(sep2)
//                 {
//                 }
//                 action(Orders1)
//                 {
//                     Caption = 'Orders';
//                     Image = Document;
//                     RunObject = Page 50059;
//                     RunPageLink = "Document Type" = CONST("Blanket Order"),
//                                   Type = CONST(Item),
//                                   "No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", "Document No.", "Line No.")
//                                   ORDER(Ascending);
//                     applicationarea = all;
//                 }
//                 action("Return Orders1")
//                 {
//                     Caption = 'Return Orders';
//                     Image = ReturnOrder;
//                     RunObject = Page 6643;
//                     RunPageLink = Type = CONST(Item),
//                                   "No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", Type, "No.");
//                     applicationarea = all;
//                 }
//                 action("Nonstoc&k Items")
//                 {
//                     Caption = 'Nonstoc&k Items';
//                     Image = NonStockItem;
//                     RunObject = Page 5726;
//                     applicationarea = all;
//                 }
//                 action("QC Parameters")
//                 {
//                     RunObject = Page 50001;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//             }
//             group("S&ales")
//             {
//                 Caption = 'S&ales';
//                 Image = Sales;
//                 action(Prices)
//                 {
//                     Caption = 'Prices';
//                     Image = Price;
//                     RunObject = Page 7002;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                     RunPageView = SORTING("Item No.");
//                 }
//                 action("Line Discounts")
//                 {
//                     Caption = 'Line Discounts';
//                     Image = LineDiscount;
//                     RunObject = Page 7004;
//                     RunPageLink = Type = CONST(Item),
//                                   Code = FIELD("No.");
//                     RunPageView = SORTING(Type, Code);
//                     applicationarea = all;
//                 }
//                 action("Prepa&yment Percentages")
//                 {
//                     Caption = 'Prepa&yment Percentages';
//                     Image = PrepaymentPercentages;
//                     RunObject = Page 664;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//                 separator(sep1)
//                 {
//                 }
//                 action(Orders)
//                 {
//                     Caption = 'Orders';
//                     Image = Document;
//                     RunObject = Page 48;
//                     RunPageLink = Type = CONST(Item),
//                                   "No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", Type, "No.");
//                     applicationarea = all;
//                 }
//                 action("Return Orders")
//                 {
//                     Caption = 'Return Orders';
//                     Image = ReturnOrder;
//                     RunObject = Page 6633;
//                     RunPageLink = Type = CONST(Item),
//                                   "No." = FIELD("No.");
//                     RunPageView = SORTING("Document Type", Type, "No.");
//                     applicationarea = all;
//                 }
//             }
//             group("Assembly/Production")
//             {
//                 Caption = 'Assembly/Production';
//                 Image = Production;
//                 action(Structure)
//                 {
//                     Caption = 'Structure';
//                     Image = Hierarchy;

//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         BOMStructure: Page 5870;
//                     begin
//                         BOMStructure.InitItem(Rec);
//                         BOMStructure.RUN;
//                     end;
//                 }
//                 action("Cost Shares")
//                 {
//                     Caption = 'Cost Shares';
//                     Image = CostBudget;

//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         BOMCostShares: Page 5872;
//                     begin
//                         BOMCostShares.InitItem(Rec);
//                         BOMCostShares.RUN;
//                     end;
//                 }
//                 group("Assemb&ly")
//                 {
//                     Caption = 'Assemb&ly';
//                     Image = AssemblyBOM;
//                     action("Assembly BOM")
//                     {
//                         Caption = 'Assembly BOM';
//                         Image = BOM;
//                         RunObject = Page 36;
//                         RunPageLink = "Parent Item No." = FIELD("No.");
//                         applicationarea = all;
//                     }
//                     action("Where-Used")
//                     {
//                         Caption = 'Where-Used';
//                         Image = Track;
//                         RunObject = Page 37;
//                         RunPageLink = Type = CONST(Item),
//                                       "No." = FIELD("No.");
//                         RunPageView = SORTING(Type, "No.");
//                         applicationarea = all;
//                     }
//                     action("Calc. Stan&dard Cost")
//                     {
//                         AccessByPermission = TableData 90 = R;
//                         Caption = 'Calc. Stan&dard Cost';
//                         Image = CalculateCost;
//                         applicationarea = all;

//                         trigger OnAction()
//                         begin
//                             CLEAR(CalculateStdCost);
//                             CalculateStdCost.CalcItem("No.", TRUE);
//                         end;
//                     }
//                     action("Calc. Unit Price")
//                     {
//                         AccessByPermission = TableData 90 = R;
//                         Caption = 'Calc. Unit Price';
//                         Image = SuggestItemPrice;
//                         applicationarea = all;

//                         trigger OnAction()
//                         begin
//                             CLEAR(CalculateStdCost);
//                             CalculateStdCost.CalcAssemblyItemPrice("No.")
//                         end;
//                     }
//                 }
//                 group(Production)
//                 {
//                     Caption = 'Production';
//                     Image = Production;
//                     action("Production BOM")
//                     {
//                         Caption = 'Production BOM';
//                         Image = BOM;
//                         RunObject = Page 99000786;
//                         RunPageLink = "No." = FIELD("Production BOM No.");
//                         applicationarea = all;
//                     }
//                     action("Where-Used")
//                     {
//                         AccessByPermission = TableData 99000771 = R;
//                         Caption = 'Where-Used';
//                         Image = "Where-Used";
//                         applicationarea = all;

//                         trigger OnAction()
//                         var
//                             ProdBOMWhereUsed: Page 99000811;
//                         begin
//                             ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
//                             ProdBOMWhereUsed.RUNMODAL;
//                         end;
//                     }
//                     action("Calc. Stan&dard Cost")
//                     {
//                         AccessByPermission = TableData 99000771 = R;
//                         Caption = 'Calc. Stan&dard Cost';
//                         Image = CalculateCost;
//                         applicationarea = all;

//                         trigger OnAction()
//                         begin
//                             CLEAR(CalculateStdCost);
//                             CalculateStdCost.CalcItem("No.", FALSE);
//                         end;
//                     }
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("&Bin Contents")
//                 {
//                     Caption = '&Bin Contents';
//                     Image = BinContent;
//                     RunObject = Page 7379;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     RunPageView = SORTING("Item No.");
//                     applicationarea = all;
//                 }
//                 action("Stockkeepin&g Units")
//                 {
//                     Caption = 'Stockkeepin&g Units';
//                     Image = SKU;
//                     RunObject = Page 5701;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     RunPageView = SORTING("Item No.");
//                     applicationarea = all;
//                 }
//             }
//             group(Service)
//             {
//                 Caption = 'Service';
//                 Image = ServiceItem;
//                 action("Ser&vice Items")
//                 {
//                     Caption = 'Ser&vice Items';
//                     Image = ServiceItem;
//                     RunObject = Page 5988;
//                     RunPageLink = "Item No." = FIELD("No.");
//                     RunPageView = SORTING("Item No.");
//                     applicationarea = all;
//                 }
//                 action(Troubleshooting)
//                 {
//                     AccessByPermission = TableData 5900 = R;
//                     Caption = 'Troubleshooting';
//                     Image = Troubleshoot;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         TroubleshootingHeader: Record 5943;
//                     begin
//                         TroubleshootingHeader.ShowForItem(Rec);
//                     end;
//                 }
//                 action("Troubleshooting Setup")
//                 {
//                     Caption = 'Troubleshooting Setup';
//                     Image = Troubleshoot;
//                     RunObject = Page 5993;
//                     RunPageLink = Type = CONST(Item),
//                                   "No." = FIELD("No.");
//                     applicationarea = all;
//                 }
//             }
//             group(Resources)
//             {
//                 Caption = 'Resources';
//                 Image = Resource;
//                 group("R&esource")
//                 {
//                     Caption = 'R&esource';
//                     Image = Resource;
//                     action("Resource Skills")
//                     {
//                         Caption = 'Resource Skills';
//                         Image = ResourceSkills;
//                         RunObject = Page 6019;
//                         RunPageLink = Type = CONST(Item),
//                                       "No." = FIELD("No.");
//                         applicationarea = all;
//                     }
//                     action("Skilled Resources")
//                     {
//                         AccessByPermission = TableData 5900 = R;
//                         Caption = 'Skilled Resources';
//                         Image = ResourceSkills;
//                         applicationarea = all;

//                         trigger OnAction()
//                         var
//                             ResourceSkill: Record 5956;
//                         begin
//                             CLEAR(SkilledResourceList);
//                             SkilledResourceList.Initialize(ResourceSkill.Type::Item, "No.", Description);
//                             SkilledResourceList.RUNMODAL;
//                         end;
//                     }
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistCurrUser;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistCurrUser;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistCurrUser;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 Image = SendApprovalRequest;
//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         IF ApprovalsMgmt.CheckItemApprovalsWorkflowEnabled(Rec) THEN
//                             ApprovalsMgmt.OnSendItemForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.OnCancelItemApprovalRequest(Rec);
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("&Create Stockkeeping Unit")
//                 {
//                     AccessByPermission = TableData 5700 = R;
//                     Caption = '&Create Stockkeeping Unit';
//                     Image = CreateSKU;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         Item: Record 27;
//                     begin
//                         Item.SETRANGE("No.", rec."No.");
//                         REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit", TRUE, FALSE, Item);
//                     end;
//                 }
//                 action(CalculateCountingPeriod)
//                 {
//                     AccessByPermission = TableData 7380 = R;
//                     Caption = 'C&alculate Counting Period';
//                     Image = CalculateCalendar;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         Item: Record 27;
//                         PhysInvtCountMgt: Codeunit 7380;
//                     begin
//                         Item.SETRANGE("No.", rec."No.");
//                         PhysInvtCountMgt.UpdateItemPhysInvtCount(Item);
//                     end;
//                 }
//                 separator(sep6)
//                 {
//                 }
//                 action("Apply Template")
//                 {
//                     Caption = 'Apply Template';
//                     Ellipsis = true;
//                     Image = ApplyTemplate;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         ConfigTemplateMgt: Codeunit 8612;
//                         RecRef: RecordRef;
//                     begin
//                         RecRef.GETTABLE(Rec);
//                         ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
//                     end;
//                 }
//                 separator(sep7)
//                 {
//                 }
//             }
//             action("Copy &QC Parameters")
//             {

//                 trigger OnAction()
//                 begin
//                     //pm 01
//                     //EBT/QC Func/0001
//                     IF "QC Applicable" = TRUE THEN BEGIN
//                         QCMaster.RESET;
//                         QCMaster.SETRANGE(QCMaster."Inventory Posting Group", "Inventory Posting Group");
//                         IF QCMaster.FINDFIRST THEN BEGIN
//                             IF CONFIRM('Do you want to copy the QC parameters for this Item?', TRUE) THEN BEGIN
//                                 QCParameters.RESET;
//                                 QCParameters.SETRANGE("Item No.", "No.");
//                                 IF QCParameters.FINDSET THEN
//                                     QCParameters.DELETEALL;
//                                 QCMaster.RESET;
//                                 QCMaster.SETRANGE("Inventory Posting Group", "Inventory Posting Group");
//                                 IF QCMaster.FINDSET THEN
//                                     REPEAT
//                                         QCParameters.INIT;
//                                         QCParameters.VALIDATE("Item No.", "No.");
//                                         QCParameters.VALIDATE("Parameter Code", QCMaster."Parameter Code");
//                                         QCParameters.INSERT;
//                                     UNTIL QCMaster.NEXT = 0;
//                                 MESSAGE('QC parameters for this Item have been copied.');
//                             END;
//                         END
//                         ELSE
//                             ERROR('QC parameter has not been defined for this Item');
//                     END
//                     ELSE
//                         ERROR('QC is not applicable for this Item');
//                     //EBT/QC Func/0001
//                 end;
//             }
//             action("&Delete QC")
//             {

//                 trigger OnAction()
//                 begin
//                     //pm 01
//                     //EBT/QC Func/0001
//                     IF "QC Applicable" = TRUE THEN BEGIN
//                         IF CONFIRM('Do you want to delete the QC parameters for this Item?', TRUE) THEN BEGIN
//                             QCParameters.RESET;
//                             QCParameters.SETRANGE("Item No.", "No.");
//                             IF QCParameters.FINDSET THEN BEGIN
//                                 QCParameters.DELETEALL;
//                                 MESSAGE('QC parameters for this Item have been deleted.');
//                             END
//                             ELSE
//                                 ERROR('No QC Parameter has been defined for this Item');
//                         END;
//                     END;
//                     //EBT/QC Func/0001
//                 end;
//             }
//             action("Requisition Worksheet")
//             {
//                 Caption = 'Requisition Worksheet';
//                 Image = Worksheet;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page 291;
//                 applicationarea = all;
//             }
//             action("Item Journal")
//             {
//                 Caption = 'Item Journal';
//                 Image = Journals;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page 40;
//                 applicationarea = all;
//             }
//             action("Item Reclassification Journal")
//             {
//                 Caption = 'Item Reclassification Journal';
//                 Image = Journals;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page 393;
//                 applicationarea = all;
//             }
//             action("Item Tracing")
//             {
//                 Caption = 'Item Tracing';
//                 Image = ItemTracing;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page 6520;
//                 applicationarea = all;
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     var
//         CRMCouplingManagement: Codeunit 5331;
//     begin
//         CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
//         OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         IF ItemUOM.GET("No.", "Sales Unit of Measure") THEN;
//         EnablePlanningControls;
//         EnableCostingControls;
//         SetSocialListeningFactboxVisibility;
//     end;

//     trigger OnClosePage()
//     begin
//         //PM 01
//         //EBT/QC Func/0001
//         /*IF "Inventory Posting Group" <> 'BULK' THEN
//         BEGIN
//         QCParameters.RESET;
//         QCParameters.SETRANGE(QCParameters."Item No.","No.");
//         IF NOT QCParameters.FINDFIRST THEN
//         BEGIN
//            "QC Applicable" := FALSE;
//            MODIFY;
//         END;
//         END;  */
//         //EBT/QC Func/0001.



//         //EBT STIVAN ---(26042012)--- For ERROR MESSAGE For below Fields --------------START
//         IF ("Item Category Code" = 'CAT03') OR ("Item Category Code" = 'CAT02') THEN BEGIN
//             rec.TESTFIELD("Item Tracking Code");
//             rec.TESTFIELD("Lot Nos.");
//             rec.TESTFIELD("Item Category Code");
//             rec.TESTFIELD("Sales Unit of Measure");
//             rec.TESTFIELD("Tax Group Code");
//             rec.TESTFIELD("Gen. Prod. Posting Group");
//             rec.TESTFIELD("Excise Prod. Posting Group");

//             IF "MRP Value" <> TRUE THEN
//                 ERROR('MRP VALUE must be TRUE');

//             IF "QC Applicable" <> TRUE THEN
//                 ERROR('QC Applicable must be TRUE');
//         END;
//         //EBT STIVAN ---(26042012)--- For ERROR MESSAGE For below Fields ----------------END

//     end;

//     trigger OnInit()
//     begin
//         UnitCostEnable := TRUE;
//         StandardCostEnable := TRUE;
//         OverflowLevelEnable := TRUE;
//         DampenerQtyEnable := TRUE;
//         DampenerPeriodEnable := TRUE;
//         LotAccumulationPeriodEnable := TRUE;
//         ReschedulingPeriodEnable := TRUE;
//         IncludeInventoryEnable := TRUE;
//         OrderMultipleEnable := TRUE;
//         MaximumOrderQtyEnable := TRUE;
//         MinimumOrderQtyEnable := TRUE;
//         MaximumInventoryEnable := TRUE;
//         ReorderQtyEnable := TRUE;
//         ReorderPointEnable := TRUE;
//         SafetyStockQtyEnable := TRUE;
//         SafetyLeadTimeEnable := TRUE;
//         TimeBucketEnable := TRUE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         EnablePlanningControls;
//         EnableCostingControls;
//     end;

//     trigger OnOpenPage()
//     var
//         CRMIntegrationManagement: Codeunit 5330;
//     begin
//         EnableShowStockOutWarning;
//         EnableShowShowEnforcePositivInventory;
//         CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
//         /*
//         //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Item Form will get Editable ----START
//         User.GET(USERID);
//         Memberof.RESET;
//         Memberof.SETRANGE(Memberof."User ID",User."User ID");
//         Memberof.SETRANGE(Memberof."Role ID",'ITEMCREATION');
//         IF NOT(Memberof.FINDFIRST) THEN
//         CurrForm.EDITABLE(FALSE);
//         //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Item Form will get Editable ------END
//         */

//         /*
//         //EBT STIVAN ---(07082012)--- A new Role has been created,as per the role the 2 field from Item Form will get Editable ----START
//         Memberof1.RESET;
//         Memberof1.SETRANGE(Memberof1."User ID",USERID);
//         Memberof1.SETRANGE(Memberof1."Role ID",'ITEM MODIFY');
//         IF Memberof1.FINDFIRST THEN BEGIN
//           */
//         CurrPage.EDITABLE(TRUE);
//         EditableByRole := FALSE;
//         EditableByRoleFalse := TRUE;
//         /*
//         CurrForm."No.".EDITABLE := FALSE;
//         CurrForm.Description.EDITABLE := FALSE;
//         CurrForm."Base Unit of Measure".EDITABLE := FALSE;
//         CurrForm."Bill of Materials".EDITABLE := FALSE;
//         CurrForm.Comment.EDITABLE := FALSE;
//         CurrForm."Shelf No.".EDITABLE := FALSE;
//         CurrForm."Search Description".EDITABLE := FALSE;
//         CurrForm.Inventory.EDITABLE := FALSE;
//         CurrForm."Qty. on Purch. Order".EDITABLE := FALSE;
//         CurrForm."Qty. on Sales Order".EDITABLE := FALSE;
//         CurrForm."Automatic Ext. Texts".EDITABLE := FALSE;
//         CurrForm."Created From Nonstock Item".EDITABLE := FALSE;
//         CurrForm."Qty. on Prod. Order".EDITABLE := FALSE;
//         CurrForm."Qty. on Component Lines".EDITABLE := FALSE;
//         CurrForm."Qty. on Service Order".EDITABLE := FALSE;
//         CurrForm."Service Item Group".EDITABLE := FALSE;
//         CurrForm."Last Date Modified".EDITABLE := FALSE;
//         CurrForm.Blocked.EDITABLE := FALSE;
//         CurrForm."Product Group Code".EDITABLE := FALSE;
//         CurrForm."Item Category Code".EDITABLE := FALSE;
//         CurrForm."Qty. on Indent".EDITABLE := FALSE;
//         CurrForm."Location Filter".EDITABLE := FALSE;
//         CurrForm."Inventory Change".EDITABLE := FALSE;
//         CurrForm."Date Filter".EDITABLE := FALSE;
//         CurrForm."Costing Method".EDITABLE := FALSE;
//         CurrForm."Standard Cost".EDITABLE := FALSE;
//         CurrForm."Unit Cost".EDITABLE := FALSE;
//         CurrForm."Last Direct Cost".EDITABLE := FALSE;
//         CurrForm."Price/Profit Calculation".EDITABLE := FALSE;
//         CurrForm."Profit %".EDITABLE := FALSE;
//         CurrForm."Unit Price".EDITABLE := FALSE;
//         CurrForm."Inventory Posting Group".EDITABLE := FALSE;
//         CurrForm."Net Invoiced Qty.".EDITABLE := FALSE;
//         CurrForm."Allow Invoice Disc.".EDITABLE := FALSE;
//         CurrForm."Item Disc. Group".EDITABLE := FALSE;
//         CurrForm."Gen. Prod. Posting Group".EDITABLE := FALSE;
//         CurrForm."VAT Prod. Posting Group".EDITABLE := FALSE;
//         CurrForm."Sales Unit of Measure".EDITABLE := FALSE;
//         CurrForm."Overhead Rate".EDITABLE := FALSE;
//         CurrForm."Indirect Cost %".EDITABLE := FALSE;
//         CurrForm."Cost is Adjusted".EDITABLE := FALSE;
//         CurrForm."Cost is Posted to G/L".EDITABLE := FALSE;
//         CurrForm."Excise Prod. Posting Group".EDITABLE := FALSE;
//         CurrForm."Tax Group Code".EDITABLE := FALSE;
//         CurrForm."QC Applicable".EDITABLE := FALSE;
//         CurrForm."Density Factor Applicable".EDITABLE := FALSE;
//         CurrForm."Replenishment System".EDITABLE := FALSE;
//         CurrForm."Rounding Precision".EDITABLE := FALSE;
//         CurrForm."Flushing Method".EDITABLE := FALSE;
//         CurrForm."Lot Size".EDITABLE := FALSE;
//         CurrForm."Scrap %".EDITABLE := FALSE;
//         CurrForm."Manufacturing Policy".EDITABLE := FALSE;
//         CurrForm."Vendor No.".EDITABLE := FALSE;
//         CurrForm."Vendor Item No.".EDITABLE := FALSE;
//         CurrForm."Lead Time Calculation".EDITABLE := FALSE;
//         CurrForm."Purch. Unit of Measure".EDITABLE := FALSE;
//         CurrForm."Production Order Type".EDITABLE := FALSE;
//         CurrForm.Reserve.EDITABLE := FALSE;
//         CurrForm."Reordering Policy".EDITABLE := FALSE;
//         CurrForm."Order Tracking Policy".EDITABLE := FALSE;
//         CurrForm.Critical.EDITABLE := FALSE;
//         CurrForm."Include Inventory".EDITABLE := FALSE;
//         CurrForm."Maximum Inventory".EDITABLE := FALSE;
//         CurrForm."Reorder Point".EDITABLE := FALSE;
//         CurrForm."Reorder Quantity".EDITABLE := FALSE;
//         CurrForm."Minimum Order Quantity".EDITABLE := FALSE;
//         CurrForm."Maximum Order Quantity".EDITABLE := FALSE;
//         CurrForm."Order Multiple".EDITABLE := FALSE;
//         CurrForm."Reorder Cycle".EDITABLE := FALSE;
//         CurrForm."Safety Stock Quantity".EDITABLE := FALSE;
//         CurrForm."Safety Lead Time".EDITABLE := FALSE;
//         CurrForm."Stockkeeping Unit Exists".EDITABLE := FALSE;
//         CurrForm."Country/Region of Origin Code".EDITABLE := FALSE;
//         CurrForm."Tariff No.".EDITABLE := FALSE;
//         CurrForm."Net Weight".EDITABLE := FALSE;
//         CurrForm."Gross Weight".EDITABLE := FALSE;
//         CurrForm."Expiration Calculation".EDITABLE := FALSE;
//         CurrForm."Lot Nos.".EDITABLE := FALSE;
//         CurrForm."Serial Nos.".EDITABLE := FALSE;
//         CurrForm."Item Tracking Code".EDITABLE := FALSE;
//         CurrForm."Common Item No.".EDITABLE := FALSE;
//         CurrForm."Identifier Code".EDITABLE := FALSE;
//         CurrForm."Next Counting Period".EDITABLE := FALSE;
//         CurrForm."Last Counting Period Update".EDITABLE := FALSE;
//         CurrForm."Last Phys. Invt. Date".EDITABLE := FALSE;
//         CurrForm."Phys Invt Counting Period Code".EDITABLE := FALSE;
//         CurrForm."Put-away Unit of Measure Code".EDITABLE := FALSE;
//         CurrForm."Put-away Template Code".EDITABLE := FALSE;
//         CurrForm."Special Equipment Code".EDITABLE := FALSE;
//         CurrForm."Use Cross-Docking".EDITABLE := FALSE;
//         CurrForm.Subcontracting.EDITABLE := FALSE;
//         CurrForm."Sub. Comp. Location".EDITABLE := FALSE;
//         CurrForm."Capital Item".EDITABLE := FALSE;
//         CurrForm."Excise Accounting Type".EDITABLE := FALSE;
//         CurrForm."Assessable Value".EDITABLE := FALSE;
//         CurrForm."Fixed Asset".EDITABLE := FALSE;
//         CurrForm."Scrap Item".EDITABLE := FALSE;
//         CurrForm."MRP Price".EDITABLE := FALSE;
//         CurrForm."Abatement %".EDITABLE := FALSE;
//         CurrForm."PIT Structure".EDITABLE := FALSE;
//         CurrForm."Unit Price".EDITABLE := FALSE;
//         CurrForm."MRP Value".EDITABLE := FALSE;
//         CurrForm."Price Inclusive of Tax".EDITABLE := FALSE;

//         CurrForm."Production BOM No.".EDITABLE := TRUE;
//         CurrForm."Routing No.".EDITABLE := TRUE;
//         */
//         //END;
//         //EBT STIVAN ---(07082012)--- A new Role has been created,as per the role the 2 field from Item Form will get Editable ------END

//     end;

//     var
//         SkilledResourceList: Page 6023;
//         CalculateStdCost: Codeunit 5812;
//         ItemAvailFormsMgt: Codeunit 353;
//         ApprovalsMgmt: Codeunit 1535;
//         ShowStockoutWarningDefaultYes: Boolean;
//         ShowStockoutWarningDefaultNo: Boolean;
//         ShowPreventNegInventoryDefaultYes: Boolean;
//         ShowPreventNegInventoryDefaultNo: Boolean;
//         [InDataSet]

//         TimeBucketEnable: Boolean;
//         [InDataSet]
//         SafetyLeadTimeEnable: Boolean;
//         [InDataSet]
//         SafetyStockQtyEnable: Boolean;
//         [InDataSet]
//         ReorderPointEnable: Boolean;
//         [InDataSet]
//         ReorderQtyEnable: Boolean;
//         [InDataSet]
//         MaximumInventoryEnable: Boolean;
//         [InDataSet]
//         MinimumOrderQtyEnable: Boolean;
//         [InDataSet]
//         MaximumOrderQtyEnable: Boolean;
//         [InDataSet]
//         OrderMultipleEnable: Boolean;
//         [InDataSet]
//         IncludeInventoryEnable: Boolean;
//         [InDataSet]
//         ReschedulingPeriodEnable: Boolean;
//         [InDataSet]
//         LotAccumulationPeriodEnable: Boolean;
//         [InDataSet]
//         DampenerPeriodEnable: Boolean;
//         [InDataSet]
//         DampenerQtyEnable: Boolean;
//         [InDataSet]
//         OverflowLevelEnable: Boolean;
//         [InDataSet]
//         StandardCostEnable: Boolean;
//         [InDataSet]
//         UnitCostEnable: Boolean;
//         [InDataSet]
//         SocialListeningSetupVisible: Boolean;
//         [InDataSet]
//         SocialListeningVisible: Boolean;
//         CRMIntegrationEnabled: Boolean;
//         CRMIsCoupledToRecord: Boolean;
//         OpenApprovalEntriesExistCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         ShowWorkflowStatus: Boolean;
//         EditableByRole: Boolean;
//         EditableByRoleFalse: Boolean;
//         ItemUOM: Record 5404;
//         QCParameters: Record 50001;
//         ILE: Record 32;
//         QCMaster: Record 50000;

//     local procedure EnableShowStockOutWarning()
//     var
//         SalesSetup: Record 311;
//     begin
//         SalesSetup.GET;
//         ShowStockoutWarningDefaultYes := SalesSetup."Stockout Warning";
//         ShowStockoutWarningDefaultNo := NOT ShowStockoutWarningDefaultYes;
//     end;

//     local procedure EnableShowShowEnforcePositivInventory()
//     var
//         InventorySetup: Record 313;
//     begin
//         InventorySetup.GET;
//         ShowPreventNegInventoryDefaultYes := InventorySetup."Prevent Negative Inventory";
//         ShowPreventNegInventoryDefaultNo := NOT ShowPreventNegInventoryDefaultYes;
//     end;

//     local procedure EnablePlanningControls()
//     var
//         PlanningGetParam: Codeunit 99000855;
//         TimeBucketEnabled: Boolean;
//         SafetyLeadTimeEnabled: Boolean;
//         SafetyStockQtyEnabled: Boolean;
//         ReorderPointEnabled: Boolean;
//         ReorderQtyEnabled: Boolean;
//         MaximumInventoryEnabled: Boolean;
//         MinimumOrderQtyEnabled: Boolean;
//         MaximumOrderQtyEnabled: Boolean;
//         OrderMultipleEnabled: Boolean;
//         IncludeInventoryEnabled: Boolean;
//         ReschedulingPeriodEnabled: Boolean;
//         LotAccumulationPeriodEnabled: Boolean;
//         DampenerPeriodEnabled: Boolean;
//         DampenerQtyEnabled: Boolean;
//         OverflowLevelEnabled: Boolean;
//     begin
//         PlanningGetParam.SetUpPlanningControls("Reordering Policy", "Include Inventory",
//           TimeBucketEnabled, SafetyLeadTimeEnabled, SafetyStockQtyEnabled,
//           ReorderPointEnabled, ReorderQtyEnabled, MaximumInventoryEnabled,
//           MinimumOrderQtyEnabled, MaximumOrderQtyEnabled, OrderMultipleEnabled, IncludeInventoryEnabled,
//           ReschedulingPeriodEnabled, LotAccumulationPeriodEnabled,
//           DampenerPeriodEnabled, DampenerQtyEnabled, OverflowLevelEnabled);

//         TimeBucketEnable := TimeBucketEnabled;
//         SafetyLeadTimeEnable := SafetyLeadTimeEnabled;
//         SafetyStockQtyEnable := SafetyStockQtyEnabled;
//         ReorderPointEnable := ReorderPointEnabled;
//         ReorderQtyEnable := ReorderQtyEnabled;
//         MaximumInventoryEnable := MaximumInventoryEnabled;
//         MinimumOrderQtyEnable := MinimumOrderQtyEnabled;
//         MaximumOrderQtyEnable := MaximumOrderQtyEnabled;
//         OrderMultipleEnable := OrderMultipleEnabled;
//         IncludeInventoryEnable := IncludeInventoryEnabled;
//         ReschedulingPeriodEnable := ReschedulingPeriodEnabled;
//         LotAccumulationPeriodEnable := LotAccumulationPeriodEnabled;
//         DampenerPeriodEnable := DampenerPeriodEnabled;
//         DampenerQtyEnable := DampenerQtyEnabled;
//         OverflowLevelEnable := OverflowLevelEnabled;
//     end;

//     local procedure EnableCostingControls()
//     begin
//         StandardCostEnable := "Costing Method" = "Costing Method"::Standard;
//         UnitCostEnable := "Costing Method" <> "Costing Method"::Standard;
//     end;

//     local procedure SetSocialListeningFactboxVisibility()
//     var
//         SocialListeningMgt: Codeunit 871;
//     begin
//         SocialListeningMgt.GetItemFactboxVisibility(Rec, SocialListeningSetupVisible, SocialListeningVisible);
//     end;
// }


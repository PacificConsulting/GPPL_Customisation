// page 50054 "Structure Header Order Details"
// {
//     AutoSplitKey = true;
//     Caption = 'Structure Order Details';
//     DelayedInsert = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "13794";
//UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(control01)
//             {
//                 field(Type; rec.Type)
//                 {
//                     applicationarea=all;
//                     Visible = false;
//                 }
//                 field("Document Type"; rec."Document Type")
//                 {
//                     applicationarea=all;
//                     Visible = rec.false;
//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     applicationarea=all;
//                     Visible = false;
//                 }
//                 field("Structure Code"; rec."Structure Code")
//                 {
//                     applicationarea=all;
//                     Visible = false;
//                 }
//                 field("Calculation Order"; rec."Calculation Order")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Tax/Charge Type"; rec."Tax/Charge Type")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Tax/Charge Group";rec. "Tax/Charge Group")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Tax/Charge Code";rec. "Tax/Charge Code")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Calculation Type";rec. "Calculation Type")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Calculation Value"; rec."Calculation Value")
//                 {
//                     applicationarea=all;

//                     trigger OnValidate()
//                     begin
//                         TotalValue := 0;
//                         SalesLine.RESET;
//                         SalesLine.SETRANGE("Document Type", "Document Type");
//                         SalesLine.SETRANGE("Document No.", "Document No.");
//                         SalesLine.SETRANGE(Type, SalesLine.Type::Item);
//                         IF SalesLine.FINDFIRST THEN
//                             REPEAT
//                                 TotalValue := TotalValue + SalesLine."Amount To Customer";
//                             UNTIL SalesLine.NEXT = 0;


//                         StrOrderDetails.RESET;
//                         StrOrderDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
//                         StrOrderDetails.SETRANGE(Type, Type);
//                         StrOrderDetails.SETRANGE("Document Type", "Document Type");
//                         StrOrderDetails.SETRANGE("Document No.", "Document No.");
//                         StrOrderDetails.SETFILTER("Document Line No.", '<>%1', 0);
//                         StrOrderDetails.SETRANGE("Structure Code", "Structure Code");
//                         StrOrderDetails.SETRANGE("Tax/Charge Type", "Tax/Charge Type");
//                         StrOrderDetails.SETRANGE("Tax/Charge Group", "Tax/Charge Group");
//                         StrOrderDetails.SETRANGE("Tax/Charge Code", "Tax/Charge Code");
//                         StrOrderDetails.SETRANGE("Calculation Order", "Calculation Order");
//                         StrOrderDetails.SETRANGE("Calculation Type", "Calculation Type");
//                         IF StrOrderDetails.FINDFIRST THEN
//                             REPEAT
//                                 LineValue := 0;
//                                 SalesLine.RESET;
//                                 SalesLine.SETRANGE("Document Type", StrOrderDetails."Document Type");
//                                 SalesLine.SETRANGE("Document No.", StrOrderDetails."Document No.");
//                                 SalesLine.SETRANGE(SalesLine."Line No.", StrOrderDetails."Document Line No.");
//                                 IF SalesLine.FINDFIRST THEN BEGIN
//                                     LineValue := ROUND(("Calculation Value" / TotalValue) * SalesLine."Amount To Customer", 2);
//                                     IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::"Fixed Value" THEN
//                                         StrOrderDetails."Calculation Value" := LineValue;

//                                     IF StrOrderDetails."Calculation Type" = StrOrderDetails."Calculation Type"::Percentage THEN
//                                         StrOrderDetails."Calculation Value" := "Calculation Value";

//                                     StrOrderDetails.MODIFY;
//                                 END;
//                             UNTIL StrOrderDetails.NEXT = 0;
//                     end;
//                 }
//                 field("Calculation Value UOM"; rec."Calculation Value UOM")
//                 {
//                     applicationarea=all;
//                     Caption = 'Calculation Value UOM';
//                 }
//                 field("Quantity Per"; rec."Quantity Per")
//                 {
//                     applicationarea=all;
//                 }
//                 field(LCY;rec. LCY)
//                 {
//                     applicationarea=all;
//                 }
//                 field("Base Formula";rec. "Base Formula")
//                 {
//                     applicationarea=all;
//                 }
//                 field(CVD; rec.CVD)
//                 {
//                     applicationarea=all;
//                 }
//                 field("CVD Payable to Third Party";rec. "CVD Payable to Third Party")
//                 {
//                     Editable = false;
//                 }
//                 field("CVD Third Party Code"; rec."CVD Third Party Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Charge Basis"; rec."Charge Basis")
//                 {
//                 }
//                 field("Include Line Discount"; rec."Include Line Discount")
//                 {
//                     applicationarea=all;

//                 }
//                 field("Include Invoice Discount"; rec."Include Invoice Discount")
//                 {
//                     applicationarea=all;

//                 }
//                 field("Include Base"; rec."Include Base")
//                 {
//                     applicationarea=all;

//                 }
//                 field("Price Inclusive of Tax";rec. "Price Inclusive of Tax")
//                 {
//                     applicationarea=all;

//                 }
//                 field("Include PIT Calculation";rec. "Include PIT Calculation")
//                 {
//                     applicationarea=all;

//                 }
//                 field("Loading on Inventory"; rec."Loading on Inventory")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Payable to Third Party";rec. "Payable to Third Party")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Third Party Code";rec.rec. "Third Party Code")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Account No."; rec.rec."Account No.")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Available for VAT Input";rec.rec. "Available for VAT Input")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Include in TDS Base"; rec."Include in TDS Base")
//                 {
//                     applicationarea=all;
//                 }
//                 field("Header/Line"; rec."Header/Line")
//                 {
//                     applicationarea=all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         StrOrderDetails: Record "13794";
//         SalesLine: Record "37";
//         TotalValue: Decimal;
//         LineValue: Decimal;
//         StrOrderDetails1: Record "13794";
// }


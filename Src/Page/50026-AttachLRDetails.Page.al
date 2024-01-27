// page 50026 "Attach LR Details"
// {
//     PageType = Card;
//UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//            // repeater(control01n)
//             //{
//                 field(InvoiceNo; InvoiceNo)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Invoice No.';
//                 }
//                 field(TransporterName; TransporterName)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Select Transporter';

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         IF InvoiceNo = '' THEN
//                             ERROR('You must provide the Invoice No.');
//                         IF PAGE.RUNMODAL(428, ShippingAgent) = ACTION::LookupOK THEN
//                             TransporterName := ShippingAgent.Code;
//                     end;
//                 }
//                 field(LRNo; LRNo)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Attach LR Details';

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         IF InvoiceNo = '' THEN
//                             ERROR('You must provide the Invoice No.');
//                         IF TransporterName = '' THEN
//                             ERROR('You have not selected any Transporter');
//                         CLEAR(LRPage);
//                         LRDetails.RESET;
//                         LRDetails.SETRANGE(LRDetails.Invoiced, FALSE);
//                         LRDetails.SETRANGE(LRDetails.Transporter, TransporterName);
//                         LRPage.SETTABLEVIEW(LRDetails);
//                         LRPage.SetDocNo(InvoiceNo);
//                         LRPage.RUNMODAL;
//                     end;
//                 }
//             //}
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Su&bmit")
//             {
//                 Caption = 'Su&bmit';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     IF InvoiceNo <> '' THEN BEGIN
//                         LRDetails.RESET;
//                         LRDetails.SETRANGE(Transporter, TransporterName);
//                         LRDetails.SETRANGE("Invoice No.", InvoiceNo);
//                         LRDetails.SETRANGE(LRDetails.Invoiced, FALSE);
//                         IF LRDetails.FINDFIRST THEN BEGIN
//                             AttachedLR.RESET;
//                             AttachedLR.INIT;
//                             AttachedLR.Code := InvoiceNo;
//                             AttachedLR."Starting Range (KMS)" := WORKDATE;
//                             AttachedLR.INSERT;
//                             MESSAGE('Invoice No. %1 has been submitted.', InvoiceNo);
//                         END;
//                     END;
//                 end;
//             }
//         }
//     }

//     var
//         TransporterName: Code[20];
//         ShippingAgent: Record 291;
//         LRDetails: Record 18606;
//         LRNo: Code[20];
//         InvoiceNo: Code[20];
//         AttachedLR: Record 50014;
//         LRPage: Page 50023;
// }


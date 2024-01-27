// codeunit 60013 "UpdateTDS Ent. to Form26Q"
// {

//     trigger OnRun()
//     begin
//         Form26Q.INIT;
//         IF Form26Q.FIND('+') THEN
//             EntryNo := Form26Q."Entry No." + 1
//         ELSE
//             EntryNo := 1;

//         TDSEntry.INIT;
//         IF TDSEntry.FIND('-') THEN
//             REPEAT
//                 Form26Q2.INIT;
//                 Form26Q2."Entry No." := EntryNo;
//                 Form26Q2."Account Type" := TDSEntry."Account Type";
//                 Form26Q2."Account No." := TDSEntry."Account No.";
//                 Form26Q2."Posting Date" := TDSEntry."Posting Date";
//                 Form26Q2."Document Type" := TDSEntry."Document Type";
//                 Form26Q2."Document No." := TDSEntry."Document No.";
//                 Form26Q2.Description := TDSEntry.Description;
//                 Form26Q2."TDS Amount Including Surcharge" := TDSEntry."TDS Amount Including Surcharge";
//                 Form26Q2."TDS Base Amount" := TDSEntry."TDS Base Amount";
//                 Form26Q2."TDS Entry No." := TDSEntry."Entry No.";
//                 Form26Q2."Party Type" := TDSEntry."Party Type";
//                 Form26Q2."Party Code" := TDSEntry."Party Code";
//                 Form26Q2."TDS Nature of Deduction" := TDSEntry."TDS Nature of Deduction";
//                 Form26Q2."Assessee Code" := TDSEntry."Assessee Code";
//                 Form26Q2."TDS Paid" := TDSEntry."TDS Paid";
//                 Form26Q2."Applied To" := TDSEntry."Applied To";
//                 Form26Q2."Challan Date" := TDSEntry."Challan Date";
//                 TDSMonth := DATE2DMY(TDSEntry."Posting Date", 2);
//                 IF ((TDSMonth >= 1) AND (TDSMonth <= 3)) THEN
//                     Form26Q2.Quarter := Form26Q2.Quarter::Q1;
//                 IF ((TDSMonth >= 4) AND (TDSMonth <= 6)) THEN
//                     Form26Q2.Quarter := Form26Q2.Quarter::Q2;
//                 IF ((TDSMonth >= 7) AND (TDSMonth <= 9)) THEN
//                     Form26Q2.Quarter := Form26Q2.Quarter::Q3;
//                 IF ((TDSMonth >= 10) AND (TDSMonth <= 12)) THEN
//                     Form26Q2.Quarter := Form26Q2.Quarter::Q4;

//                 Form26Q2."Challan No." := TDSEntry."Challan No.";
//                 Form26Q2."Bank Name" := TDSEntry."Bank Name";
//                 Form26Q2."TDS %" := TDSEntry."TDS %";
//                 Form26Q2.Adjusted := TDSEntry.Adjusted;
//                 Form26Q2."Adjusted TDS %" := TDSEntry."Adjusted TDS %";
//                 Form26Q2."Bal. TDS Including SHE CESS" := TDSEntry."Bal. TDS Including SHE CESS";
//                 Form26Q2."Pay TDS Document No." := TDSEntry."Pay TDS Document No.";
//                 Form26Q2."Applies To" := TDSEntry."Applies To";
//                 Form26Q2."TDS Category" := TDSEntry."TDS Category";
//                 Form26Q2."Surcharge %" := TDSEntry."Surcharge %";
//                 Form26Q2."Surcharge Amount" := TDSEntry."Surcharge Amount";
//                 Form26Q2."Invoice Amount" := TDSEntry."Invoice Amount";
//                 Form26Q2."Rem. Total TDS Incl. SHE CESS" := TDSEntry."Rem. Total TDS Incl. SHE CESS";
//                 Form26Q2."TDS Amount" := TDSEntry."TDS Amount";
//                 Form26Q2."Remaining Surcharge Amount" := TDSEntry."Remaining Surcharge Amount";
//                 Form26Q2."Remaining TDS Amount" := TDSEntry."Remaining TDS Amount";
//                 Form26Q2."TDS Group" := TDSEntry."TDS Group";
//                 Form26Q2."Surcharge Base Amount" := TDSEntry."Surcharge Base Amount";
//                 Form26Q2."eCESS %" := TDSEntry."eCESS %";
//                 Form26Q2."eCESS Amount" := TDSEntry."eCESS Amount";
//                 Form26Q2."Total TDS Including SHE CESS" := TDSEntry."Total TDS Including SHE CESS";
//                 Form26Q2."T.A.N. No." := TDSEntry."T.A.N. No.";
//                 Form26Q2."Party Account No." := TDSEntry."Party Account No.";
//                 Form26Q2."TDS Section" := TDSEntry."TDS Section";
//                 Form26Q2."BSR Code" := TDSEntry."BSR Code";
//                 Form26Q2."Transaction No." := TDSEntry."Transaction No.";
//                 Form26Q2."Deductee P.A.N. No." := TDSEntry."Deductee P.A.N. No.";
//                 Form26Q2."TDS Payment Date" := TDSEntry."TDS Payment Date";
//                 Form26Q2."Assessment Year" := '200910';
//                 Form26Q2."Financial Year" := '200809';
//                 Form26Q2.Mode := 'O';
//                 Form26Q2."Deductee Code" := '2';
//                 Form26Q2."Last Emp. / Party P.A.N. No." := 'PANAPPLIED';
//                 Form26Q2."Last Total Income TDS" := TDSEntry."TDS Amount Including Surcharge";
//                 Form26Q2."Total Tax Deposited" := TDSEntry."Bal. TDS Including SHE CESS";
//                 Form26Q2."Last Total Tax Deposited" := TDSEntry."Bal. TDS Including SHE CESS";
//                 Form26Q2."Amount of Payment / Credit" := TDSEntry."TDS Base Amount";
//                 Form26Q2."Amount Paid / Credited on Date" := TDSEntry."Posting Date";
//                 Form26Q2."Tax Deducted / Collected Date" := TDSEntry."Posting Date";
//                 Form26Q2."TDS Payment Date" := TDSEntry."TDS Payment Date";
//                 Form26Q2.INSERT;
//                 EntryNo += 1;
//             UNTIL TDSEntry.NEXT = 0;

//         MESSAGE('completed');
//     end;

//     var
//         TDSEntry: Record "TDS Entry";
//         Form26Q: Record "Form 26Q/27Q Entry";
//         Form26Q2: Record "Form 26Q/27Q Entry";
//         EntryNo: Integer;
//         TDSMonth: Integer;
// }



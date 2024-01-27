// codeunit 50014 "Mintifi Mgmt"
// {

//     trigger OnRun()
//     begin

//         MintifiLogJob.RESET;
//         MintifiLogJob.SETRANGE(Status, MintifiLogJob.Status::Error);
//         IF MintifiLogJob.FINDSET THEN
//             REPEAT

//                 IF MintifiLogJob."Entry Type" = MintifiLogJob."Entry Type"::"Order Process" THEN BEGIN
//                     // >> Invoice >>
//                     IF MintifiLogJob."Document Type" = MintifiLogJob."Document Type"::Invoice THEN
//                         GenerateSalesInvoiceMintifi(MintifiLogJob."Document No.");
//                     // << Invoice <<

//                     // >> Credit Memo >>
//                     IF MintifiLogJob."Document Type" = MintifiLogJob."Document Type"::"Credit Memo" THEN
//                         GenerateSalesCreditMemoMintifi(MintifiLogJob."Document No.");
//                     // << Credit Memo <<
//                 END;

//                 IF MintifiLogJob."Entry Type" = MintifiLogJob."Entry Type"::Payment THEN BEGIN
//                     // >> Payment >>
//                     IF MintifiLogJob."Document Type" = MintifiLogJob."Document Type"::Payment THEN
//                         GeneratePaymentDocMintifi(MintifiLogJob."Document No.");
//                     // << Payment <<
//                 END;

//                 IF MintifiLogJob."Entry Type" = MintifiLogJob."Entry Type"::Journal THEN BEGIN
//                     // >> Journal >>
//                     IF MintifiLogJob."Document Type" <> MintifiLogJob."Document Type"::Payment THEN
//                         GenerateJournalDocMintifi(MintifiLogJob."Document No.", MintifiLogJob."Document Type");
//                     // << Journal <<
//                 END;

//             UNTIL MintifiLogJob.NEXT = 0;
//     end;

//     var
//         StringBuilder: DotNet StringBuilder;
//         StringWriter: DotNet StringWriter;
//         StringReader: DotNet StringReader;
//         JsonTextWriter: DotNet JsonTextWriter;
//         JsonTextReader: DotNet JsonTextReader;
//         CompanyInformation: Record 79;
//         TxtJsonString: Text;
//         MyFile: File;
//         WriteFile: OutStream;
//         ReadFile: InStream;
//         IntRead: Integer;
//         txtOrderId: Text[1024];
//         CustomerShip: Record 18;
//         Text50000: Label 'This sales invoice document is uploaded sucessfully in Mintifi. ';
//         Text50001: Label 'This sales payment document is uploaded sucessfully in Mintifi. ';
//         MintifiLogJob: Record 50049;
//         Text50002: Label 'This sales credit memo document is uploaded sucessfully in Mintifi. ';
//         Text50003: Label 'This journal document is uploaded sucessfully in Mintifi. ';

//     local procedure Initialize()
//     var
//         Formatting: DotNet Formatting;
//     begin

//         StringBuilder := StringBuilder.StringBuilder;
//         StringWriter := StringWriter.StringWriter(StringBuilder);
//         JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
//         JsonTextWriter.Formatting := Formatting.Indented;
//     end;

//     // [Scope('Internal')]
//     procedure StartJSon()
//     begin

//         IF ISNULL(StringBuilder) THEN
//             Initialize;
//         JsonTextWriter.WriteStartObject;
//     end;

//     // [Scope('Internal')]
//     procedure AddToJSon(VariableName: Text; Variable: Variant)
//     begin

//         JsonTextWriter.WritePropertyName(VariableName);
//         JsonTextWriter.WriteValue(FORMAT(Variable, 0, 9));
//     end;

//     // [Scope('Internal')]
//     procedure EndJSon()
//     begin

//         JsonTextWriter.WriteEndObject;
//     end;

//     // [Scope('Internal')]
//     procedure StartJSonArray(ParameterName: Text)
//     begin

//         IF ISNULL(StringBuilder) THEN
//             Initialize;
//         JsonTextWriter.WritePropertyName(ParameterName);

//         // JsonTextWriter.WriteStartObject;

//         JsonTextWriter.WriteStartArray;
//     end;

//     //   [Scope('Internal')]
//     procedure EndJSonArray()
//     begin

//         JsonTextWriter.WriteEndArray;
//     end;

//     //  [Scope('Internal')]
//     procedure AddJSonBranch(BranchName: Text)
//     begin

//         JsonTextWriter.WritePropertyName(BranchName);
//         JsonTextWriter.WriteStartObject;
//     end;

//     //[Scope('Internal')]
//     procedure EndJSonBranch()
//     begin

//         JsonTextWriter.WriteEndObject;
//     end;

//     // [Scope('Internal')]
//     procedure GetJSon() JSon: Text
//     begin

//         JSon := StringBuilder.ToString;
//         Initialize;
//     end;

//     // [Scope('Internal')]
//     procedure CreateWebRequest(var HttpWebRequest: DotNet HttpWebRequest; WebServiceURL: Text; Method: Text)
//     begin

//         HttpWebRequest := HttpWebRequest.Create(WebServiceURL);
//         HttpWebRequest.Timeout := 30000;
//         HttpWebRequest.Method := Method;
//         HttpWebRequest.Accept := 'application/json';
//     end;

//     //  [Scope('Internal')]
//     procedure CreateCredentials(var HttpWebRequest: DotNet HttpWebRequest; UserName: Text; Password: Text)
//     var
//         Credential: DotNet NetworkCredential;
//     begin

//         Credential := Credential.NetworkCredential;
//         Credential.UserName := UserName;
//         Credential.Password := Password;
//         HttpWebRequest.Credentials := Credential;
//     end;

//     //[Scope('Internal')]
//     procedure SetRequestStream(var HttpWebRequest: DotNet HttpWebRequest; var String: DotNet String)
//     var
//         StreamWriter: DotNet StreamWriter;
//         Encoding: DotNet Encoding;
//     begin

//         StreamWriter := StreamWriter.StreamWriter(HttpWebRequest.GetRequestStream, Encoding.GetEncoding('iso8859-1'));
//         StreamWriter.Write(String);
//         StreamWriter.Close;
//     end;

//     // [Scope('Internal')]
//     procedure DoWebRequest(var HttpWebRequest: DotNet HttpWebRequest; var HttpWebResponse: DotNet WebResponse; IgnoreCode: Code[10])
//     var
//         NAVWebRequest: DotNet NAVWebRequest;
//         HttpWebException: DotNet WebException;
//         HttpWebRequestError: Label 'Error: %1\%2';
//     begin

//         NAVWebRequest := NAVWebRequest.NAVWebRequest;
//         IF NOT NAVWebRequest.doRequest(HttpWebRequest, HttpWebException, HttpWebResponse) THEN
//             IF (IgnoreCode = '') OR (STRPOS(HttpWebException.Message, IgnoreCode) = 0) THEN
//                 ERROR(HttpWebRequestError, HttpWebException.Status.ToString, HttpWebException.Message);
//     end;

//     //  [Scope('Internal')]
//     procedure GetResponseStream(var HttpWebResponse: DotNet WebResponse; var String: DotNet String)
//     var
//         StreamReader: DotNet StreamReader;
//         MemoryStream: DotNet MemoryStream;
//         DataPostingExchField: Record 1221;
//         IntEntryNo: Integer;
//     begin

//         StreamReader := StreamReader.StreamReader(HttpWebResponse.GetResponseStream);
//         String := StreamReader.ReadToEnd;
//     end;

//     //   [Scope('Internal')]
//     procedure ReadFirstJSonValue(var String: DotNet String; ParameterName: Text) ParameterValue: Text
//     var
//         PropertyName: Text;
//         JsonToken: DotNet JsonToken;
//     begin

//         StringReader := StringReader.StringReader(String);
//         JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
//         WHILE JsonTextReader.Read DO
//             CASE TRUE OF
//                 JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
//                     PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
//                 (PropertyName = ParameterName) AND NOT ISNULL(JsonTextReader.Value):
//                     BEGIN
//                         ParameterValue := FORMAT(JsonTextReader.Value, 0, 9);
//                         EXIT;
//                     END;
//             END;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
//     // [Scope('Internal')]
//     procedure FnOnBeforePostSalesInvoice(var SalesHeader: Record 36)
//     var
//         GeneralLedgerSetup: Record 98;
//         RecSalesInvHeader: Record 112;
//     begin

//         GeneralLedgerSetup.GET;

//         IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN BEGIN
//             IF SalesHeader."Mintifi Channel Finance" = SalesHeader."Mintifi Channel Finance"::Yes THEN BEGIN//RSPLSUM 29Oct2020
//                 IF GeneralLedgerSetup."MIs Invoice" = TRUE THEN BEGIN
//                     SalesHeader.TESTFIELD("External Document No.");
//                     SalesHeader.TESTFIELD("Location Code");
//                     SalesHeader.TESTFIELD("Payment Method Code");
//                     SalesHeader.TESTFIELD("Payment Terms Code");
//                     SalesHeader.TESTFIELD("Sell-to Country/Region Code");
//                     GeneralLedgerSetup.TESTFIELD("MInvoice URL");
//                 END;
//             END;//RSPLSUM 29Oct2020
//         END;

//         IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") OR (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") THEN BEGIN////RSPLSUM 31Oct2020 Added Doc Type=Return Order
//             IF (SalesHeader."Applies-to Doc. Type" = SalesHeader."Applies-to Doc. Type"::Invoice) AND (SalesHeader."Applies-to Doc. No." <> '') THEN BEGIN//RSPLSUM 31Oct2020
//                 RecSalesInvHeader.RESET;//RSPLSUM 31Oct2020
//                 IF RecSalesInvHeader.GET(SalesHeader."Applies-to Doc. No.") THEN BEGIN//RSPLSUM 31Oct2020
//                     IF RecSalesInvHeader."Mintifi Channel Finance" = RecSalesInvHeader."Mintifi Channel Finance"::Yes THEN BEGIN//RSPLSUM 31Oct2020
//                         IF GeneralLedgerSetup."MIs Credit Memo" = TRUE THEN BEGIN
//                             SalesHeader.TESTFIELD("External Document No.");
//                             SalesHeader.TESTFIELD("Location Code");
//                             SalesHeader.TESTFIELD("Payment Method Code");
//                             SalesHeader.TESTFIELD("Payment Terms Code");
//                             SalesHeader.TESTFIELD("Sell-to Country/Region Code");
//                             GeneralLedgerSetup.TESTFIELD("MCredit Memo URL");
//                         END;
//                     END;//RSPLSUM 31Oct2020
//                 END;//RSPLSUM 31Oct2020
//             END;//RSPLSUM 31Oct2020
//         END;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
//     // [Scope('Internal')]
//     procedure FnOnAfterPostSalesInvoice(var SalesHeader: Record 36; var GenJnlPostLine: Codeunit 12; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
//     var
//         GeneralLedgerSetup: Record 98;
//         RecSalesInvHeader: Record 112;
//     begin

//         GeneralLedgerSetup.GET;

//         IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN BEGIN
//             IF SalesHeader."Mintifi Channel Finance" = SalesHeader."Mintifi Channel Finance"::Yes THEN BEGIN//RSPLSUM 29Oct2020
//                 IF GeneralLedgerSetup."MIs Invoice" THEN BEGIN
//                     GenerateSalesInvoiceMintifi(SalesInvHdrNo);
//                 END;
//             END;//RSPLSUM 29Oct2020
//         END;

//         IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") OR (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") THEN BEGIN////RSPLSUM 31Oct2020 Added Doc Type=Return Order
//             IF (SalesHeader."Applies-to Doc. Type" = SalesHeader."Applies-to Doc. Type"::Invoice) AND (SalesHeader."Applies-to Doc. No." <> '') THEN BEGIN//RSPLSUM 31Oct2020
//                 RecSalesInvHeader.RESET;//RSPLSUM 31Oct2020
//                 IF RecSalesInvHeader.GET(SalesHeader."Applies-to Doc. No.") THEN BEGIN//RSPLSUM 31Oct2020
//                     IF RecSalesInvHeader."Mintifi Channel Finance" = RecSalesInvHeader."Mintifi Channel Finance"::Yes THEN BEGIN//RSPLSUM 31Oct2020
//                         IF GeneralLedgerSetup."MIs Credit Memo" THEN BEGIN
//                             GenerateSalesCreditMemoMintifi(SalesCrMemoHdrNo);
//                         END;
//                     END;//RSPLSUM 31Oct2020
//                 END;//RSPLSUM 31Oct2020
//             END;//RSPLSUM 31Oct2020
//         END;
//     end;

//     //[Scope('Internal')]
//     procedure GenerateSalesInvoiceMintifi(SalesInvoiceHeaderNo: Code[50])
//     var
//         SalesInvoiceHeaderNew: Record 112;
//         CompanyInformation: Record 79;
//         SalesInvoiceLine: Record 113;
//         declocalCurrecncyAmt: Decimal;
//         GeneralLedgerSetup: Record 98;
//         FileStream: DotNet FileStream;
//         StreamReader: DotNet StreamReader;
//         Stream: DotNet Stream;
//         NewFileName: Text[250];
//         FileManagement: Codeunit 419;
//         FilePath: Text[1024];
//         CustLedgerEntry: Record 21;
//         JsonStringNew: DotNet String;
//         MintifiLogCheck: Record 50049;
//         MintifiLogIns: Record 50049;
//         MintifiLogCheckNew: Record 50049;
//         decSalesCGST: Decimal;
//         decSalesSGST: Decimal;
//         decSalesIGST: Decimal;
//         decSalesTotalGSTAmt: Decimal;
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//         CustLedgerEntryRec: Record 21;
//     begin
//         CompanyInformation.GET;

//         GeneralLedgerSetup.GET;

//         SalesInvoiceHeaderNew.RESET;
//         SalesInvoiceHeaderNew.SETAUTOCALCFIELDS("Amount Including VAT");
//         SalesInvoiceHeaderNew.SETRANGE("No.", SalesInvoiceHeaderNo);
//         IF SalesInvoiceHeaderNew.FINDFIRST THEN BEGIN
//             StartJSon;
//             AddToJSon('company_code', CompanyInformation.Name);
//             AddToJSon('fiscal_year', FnGetFiscalYearMonth(TODAY));
//             AddToJSon('document_number', SalesInvoiceHeaderNew."No.");

//             // Start Array Items -->
//             StartJSonArray('line_items');
//             CLEAR(declocalCurrecncyAmt);
//             SalesInvoiceLine.RESET;
//             SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//             SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
//             IF SalesInvoiceLine.FINDSET THEN
//                 REPEAT
//                     StartJSon;
//                     // >> GST Calculation >>
//                     CLEAR(decSalesCGST);
//                     CLEAR(decSalesSGST);
//                     CLEAR(decSalesIGST);
//                     CLEAR(DetailedGSTLedgerEntry);
//                     DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
//                     DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
//                     DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
//                     DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
//                     IF DetailedGSTLedgerEntry.FINDSET THEN
//                         REPEAT
//                             IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
//                                 decSalesCGST := ABS(DetailedGSTLedgerEntry."GST Amount");
//                             END;


//                             IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
//                                 decSalesSGST := ABS(DetailedGSTLedgerEntry."GST Amount");
//                             END;


//                             IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
//                                 decSalesIGST := ABS(DetailedGSTLedgerEntry."GST Amount");
//                             END;

//                         UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//                     // << GST Calculation <<

//                     declocalCurrecncyAmt += SalesInvoiceLine."Line Amount";
//                     AddToJSon('description', SalesInvoiceLine.Description);
//                     AddToJSon('amount_local_currency', SalesInvoiceLine.Amount);
//                     AddToJSon('amount_document_currency', SalesInvoiceLine.Amount);
//                     AddToJSon('quantity', SalesInvoiceLine.Quantity);
//                     AddToJSon('cgst', decSalesCGST);
//                     AddToJSon('sgst', decSalesSGST);
//                     AddToJSon('igst', decSalesIGST);
//                     EndJSon;
//                 UNTIL SalesInvoiceLine.NEXT = 0;
//             EndJSonArray;
//             // End Array Items <--

//             AddToJSon('customer_code', SalesInvoiceHeaderNew."Sell-to Customer No.");
//             AddToJSon('gl_account', 'PR2123');

//             CustLedgerEntryRec.RESET;
//             CustLedgerEntryRec.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", Amount);
//             CustLedgerEntryRec.SETRANGE("Document Type", CustLedgerEntryRec."Document Type"::Invoice);
//             CustLedgerEntryRec.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//             IF CustLedgerEntryRec.FINDFIRST THEN BEGIN
//                 AddToJSon('debit_credit_amount', CustLedgerEntryRec.Amount);
//             END;

//             // AddToJSon('cutoff_date',SalesInvoiceHeaderNew."Document Date"); // Commented By Leo
//             AddToJSon('cutoff_date', SalesInvoiceHeaderNew."Due Date"); // Updated Due Date

//             AddToJSon('document_type', 'Sales');
//             AddToJSon('document_date', SalesInvoiceHeaderNew."Document Date");
//             AddToJSon('posting_date', SalesInvoiceHeaderNew."Posting Date");
//             AddToJSon('country', SalesInvoiceHeaderNew."Sell-to Country/Region Code");
//             IF SalesInvoiceHeaderNew."Payment Method Code" <> '' THEN
//                 AddToJSon('payment_method', SalesInvoiceHeaderNew."Payment Method Code")
//             ELSE
//                 AddToJSon('payment_method', 'VISA');

//             AddToJSon('payment_terms', SalesInvoiceHeaderNew."Payment Terms Code");

//             AddToJSon('local_currency_code', GeneralLedgerSetup."LCY Code");

//             CustLedgerEntry.RESET;
//             CustLedgerEntry.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
//             CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
//             CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//             IF CustLedgerEntry.FINDFIRST THEN BEGIN
//                 AddToJSon('debit_amount_lc', CustLedgerEntry."Debit Amount (LCY)");
//                 AddToJSon('credit_amount_lc', CustLedgerEntry."Credit Amount (LCY)");
//                 AddToJSon('cash_discount_lc', 0);
//                 IF SalesInvoiceHeaderNew."Currency Code" <> '' THEN
//                     AddToJSon('document_currency_code', SalesInvoiceHeaderNew."Currency Code")
//                 ELSE
//                     AddToJSon('document_currency_code', GeneralLedgerSetup."LCY Code");

//                 AddToJSon('debit_amount_dc', CustLedgerEntry."Debit Amount");
//                 AddToJSon('credit_amount_dc', CustLedgerEntry."Credit Amount");
//                 AddToJSon('cash_discount_dc', 0);
//             END;

//             AddToJSon('invoice_reference', SalesInvoiceHeaderNew."No.");
//             AddToJSon('posting_period', FORMAT(SalesInvoiceHeaderNew."Posting Date", 0, '<Year4>'));
//             EndJSon;

//             JsonStringNew := JsonStringNew.Copy(GetJSon);

//             TxtJsonString := JsonStringNew;

//             MyFile.CREATE(GeneralLedgerSetup."MJson File Path" + '\' + SalesInvoiceHeaderNew."Sell-to Customer Name" + FORMAT(SalesInvoiceHeaderNew."Posting Date") + '.txt');
//             MyFile.CREATEOUTSTREAM(WriteFile);
//             WriteFile.WRITETEXT(TxtJsonString);
//             MyFile.CLOSE;

//             FILE.ERASE(GeneralLedgerSetup."MJson File Path" + '\' + SalesInvoiceHeaderNew."Sell-to Customer Name" + FORMAT(SalesInvoiceHeaderNew."Posting Date") + '.txt');

//             IF FnConnectiontoMintifiInvoice(JsonStringNew) THEN BEGIN
//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Invoice);
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//                 IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogIns.INIT;
//                     IF MintifiLogCheck.FINDLAST THEN;
//                     MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                     MintifiLogIns."Entry Date" := TODAY;
//                     MintifiLogIns."Document Type" := MintifiLogIns."Document Type"::Invoice;
//                     MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::"Order Process";
//                     MintifiLogIns."Document No." := SalesInvoiceHeaderNew."No.";
//                     MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                     MintifiLogIns."Source No." := SalesInvoiceHeaderNew."Sell-to Customer No.";
//                     MintifiLogIns."Source Name" := SalesInvoiceHeaderNew."Sell-to Customer Name";

//                     CustLedgerEntryRec.RESET;
//                     CustLedgerEntryRec.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", Amount);
//                     CustLedgerEntryRec.SETRANGE("Document Type", CustLedgerEntryRec."Document Type"::Invoice);
//                     CustLedgerEntryRec.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//                     IF CustLedgerEntryRec.FINDFIRST THEN BEGIN
//                         MintifiLogIns.Amount := CustLedgerEntryRec.Amount;
//                     END;

//                     MintifiLogIns.Status := MintifiLogIns.Status::Success;
//                     MintifiLogIns."Status Message" := Text50000;
//                     MintifiLogIns."Created By" := USERID;
//                     MintifiLogIns.INSERT;
//                 END;

//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Invoice);
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//                 IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Success;
//                     MintifiLogCheckNew."Status Message" := Text50000;
//                     MintifiLogCheckNew."Created By" := USERID;
//                     MintifiLogCheckNew.MODIFY;
//                 END;

//             END
//             ELSE BEGIN
//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Invoice);
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//                 IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogIns.INIT;
//                     IF MintifiLogCheck.FINDLAST THEN;
//                     MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                     MintifiLogIns."Entry Date" := TODAY;
//                     MintifiLogIns."Document Type" := MintifiLogIns."Document Type"::Invoice;
//                     MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::"Order Process";
//                     MintifiLogIns."Document No." := SalesInvoiceHeaderNew."No.";
//                     MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                     MintifiLogIns."Source No." := SalesInvoiceHeaderNew."Sell-to Customer No.";
//                     MintifiLogIns."Source Name" := SalesInvoiceHeaderNew."Sell-to Customer Name";
//                     SalesInvoiceHeaderNew.CALCFIELDS("Amount Including VAT");

//                     CustLedgerEntryRec.RESET;
//                     CustLedgerEntryRec.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", Amount);
//                     CustLedgerEntryRec.SETRANGE("Document Type", CustLedgerEntryRec."Document Type"::Invoice);
//                     CustLedgerEntryRec.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//                     IF CustLedgerEntryRec.FINDFIRST THEN BEGIN
//                         MintifiLogIns.Amount := CustLedgerEntryRec.Amount;
//                     END;

//                     MintifiLogIns.Status := MintifiLogIns.Status::Error;
//                     MintifiLogIns."Status Message" := GETLASTERRORTEXT;
//                     MintifiLogIns."Created By" := USERID;
//                     MintifiLogIns.INSERT;
//                 END;

//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Invoice);
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesInvoiceHeaderNew."No.");
//                 IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Error;
//                     MintifiLogCheckNew."Status Message" := GETLASTERRORTEXT;
//                     MintifiLogCheckNew."Created By" := USERID;
//                     MintifiLogCheckNew.MODIFY;
//                 END;
//             END;
//         END;
//     end;

//     [TryFunction]
//     // [Scope('Internal')]
//     procedure FnConnectiontoMintifiInvoice(JsonStringNewGetValue: DotNet String)
//     var
//         SSHttpWebRequest: DotNet HttpWebRequest;
//         SSHttpWebResponse: DotNet WebResponse;
//         StreamWriter: DotNet StreamWriter;
//         GeneralLedgerSetup: Record 98;
//     begin

//         GeneralLedgerSetup.GET;

//         SSHttpWebRequest := SSHttpWebRequest.Create(GeneralLedgerSetup."MInvoice URL");
//         SSHttpWebRequest.Method := 'POST';
//         SSHttpWebRequest.ContentType('application/json');
//         SSHttpWebRequest.Headers.Add('Authorization' + ':' + 'Bearer' + ' ' + GeneralLedgerSetup."MAuthorization Key");
//         SSHttpWebRequest.Accept('application/json');
//         SSHttpWebRequest.KeepAlive := TRUE;
//         SSHttpWebRequest.Timeout := 30000;
//         StreamWriter := StreamWriter.StreamWriter(SSHttpWebRequest.GetRequestStream);
//         StreamWriter.Write(JsonStringNewGetValue);
//         StreamWriter.Close;
//         DoWebRequest(SSHttpWebRequest, SSHttpWebResponse, '');
//         GetResponseStream(SSHttpWebResponse, JsonStringNewGetValue);
//     end;

//     //  [Scope('Internal')]
//     procedure GenerateSalesCreditMemoMintifi(SalesCreditMemoHeaderNo: Code[50])
//     var
//         CompanyInformation: Record 79;
//         declocalCurrecncyAmt: Decimal;
//         GeneralLedgerSetup: Record 98;
//         FileStream: DotNet FileStream;
//         StreamReader: DotNet StreamReader;
//         Stream: DotNet Stream;
//         NewFileName: Text[250];
//         FileManagement: Codeunit 419;
//         FilePath: Text[1024];
//         CustLedgerEntry: Record 21;
//         JsonStringNew: DotNet String;
//         MintifiLogCheck: Record 50049;
//         MintifiLogIns: Record 50049;
//         MintifiLogCheckNew: Record 50049;
//         SalesCrMemoHeader: Record 114;
//         SalesCrMemoLine: Record 115;
//         decCreditCGST: Decimal;
//         decCreditSGST: Decimal;
//         decCreditIGST: Decimal;
//         decCreditTotalGSTAmt: Decimal;
//         DetailedGSTLedgerEntryCredit: Record "Detailed GST Ledger Entry";
//         CustLedgerEntryRec: Record 21;
//     begin

//         CompanyInformation.GET;

//         GeneralLedgerSetup.GET;

//         SalesCrMemoHeader.RESET;
//         SalesCrMemoHeader.SETAUTOCALCFIELDS("Amount Including VAT");
//         SalesCrMemoHeader.SETRANGE("No.", SalesCreditMemoHeaderNo);
//         IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
//             StartJSon;
//             AddToJSon('company_code', CompanyInformation.Name);
//             AddToJSon('fiscal_year', FnGetFiscalYearMonth(TODAY));
//             AddToJSon('document_number', SalesCrMemoHeader."No.");

//             // Start Array Items -->
//             StartJSonArray('line_items');
//             CLEAR(declocalCurrecncyAmt);
//             SalesCrMemoLine.RESET;
//             SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//             SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
//             IF SalesCrMemoLine.FINDSET THEN
//                 REPEAT
//                     StartJSon;
//                     // >> GST Calculation >>
//                     CLEAR(decCreditCGST);
//                     CLEAR(decCreditSGST);
//                     CLEAR(decCreditIGST);
//                     CLEAR(DetailedGSTLedgerEntryCredit);
//                     DetailedGSTLedgerEntryCredit.SETRANGE("Transaction Type", DetailedGSTLedgerEntryCredit."Transaction Type"::Sales);
//                     DetailedGSTLedgerEntryCredit.SETRANGE("Document Type", DetailedGSTLedgerEntryCredit."Document Type"::"Credit Memo");
//                     DetailedGSTLedgerEntryCredit.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
//                     DetailedGSTLedgerEntryCredit.SETRANGE("Document Line No.", SalesCrMemoLine."Line No.");
//                     IF DetailedGSTLedgerEntryCredit.FINDSET THEN
//                         REPEAT
//                             IF DetailedGSTLedgerEntryCredit."GST Component Code" = 'CGST' THEN BEGIN
//                                 decCreditCGST := ABS(DetailedGSTLedgerEntryCredit."GST Amount");
//                             END;

//                             IF DetailedGSTLedgerEntryCredit."GST Component Code" = 'SGST' THEN BEGIN
//                                 decCreditSGST := ABS(DetailedGSTLedgerEntryCredit."GST Amount");
//                             END;

//                             IF DetailedGSTLedgerEntryCredit."GST Component Code" = 'IGST' THEN BEGIN
//                                 decCreditIGST := ABS(DetailedGSTLedgerEntryCredit."GST Amount");
//                             END;

//                         UNTIL DetailedGSTLedgerEntryCredit.NEXT = 0;
//                     // << GST Calculation <<

//                     declocalCurrecncyAmt += SalesCrMemoLine."Line Amount";
//                     AddToJSon('description', SalesCrMemoLine.Description);
//                     AddToJSon('amount_local_currency', SalesCrMemoLine.Amount);
//                     AddToJSon('amount_document_currency', SalesCrMemoLine.Amount);
//                     AddToJSon('quantity', SalesCrMemoLine.Quantity);
//                     AddToJSon('cgst', decCreditCGST);
//                     AddToJSon('sgst', decCreditSGST);
//                     AddToJSon('igst', decCreditIGST);
//                     EndJSon;
//                 UNTIL SalesCrMemoLine.NEXT = 0;
//             EndJSonArray;
//             // End Array Items <--

//             AddToJSon('customer_code', SalesCrMemoHeader."Sell-to Customer No.");
//             AddToJSon('gl_account', 'PR2123');

//             CustLedgerEntryRec.RESET;
//             CustLedgerEntryRec.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", Amount);
//             CustLedgerEntryRec.SETRANGE("Document Type", CustLedgerEntryRec."Document Type"::"Credit Memo");
//             CustLedgerEntryRec.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//             IF CustLedgerEntryRec.FINDFIRST THEN BEGIN
//                 AddToJSon('debit_credit_amount', CustLedgerEntryRec.Amount);
//             END;

//             // AddToJSon('cutoff_date',SalesCrMemoHeader."Document Date");
//             AddToJSon('cutoff_date', SalesCrMemoHeader."Due Date");

//             AddToJSon('document_type', 'Sales');
//             AddToJSon('document_date', SalesCrMemoHeader."Document Date");
//             AddToJSon('posting_date', SalesCrMemoHeader."Posting Date");
//             AddToJSon('country', SalesCrMemoHeader."Sell-to Country/Region Code");
//             IF SalesCrMemoHeader."Payment Method Code" <> '' THEN
//                 AddToJSon('payment_method', SalesCrMemoHeader."Payment Method Code")
//             ELSE
//                 AddToJSon('payment_method', 'VISA');


//             AddToJSon('payment_terms', SalesCrMemoHeader."Payment Terms Code");

//             AddToJSon('local_currency_code', GeneralLedgerSetup."LCY Code");

//             CustLedgerEntry.RESET;
//             CustLedgerEntry.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
//             CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
//             CustLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//             IF CustLedgerEntry.FINDFIRST THEN BEGIN
//                 AddToJSon('debit_amount_lc', CustLedgerEntry."Debit Amount (LCY)");
//                 AddToJSon('credit_amount_lc', CustLedgerEntry."Credit Amount (LCY)");
//                 AddToJSon('cash_discount_lc', 0);
//                 IF SalesCrMemoHeader."Currency Code" <> '' THEN
//                     AddToJSon('document_currency_code', SalesCrMemoHeader."Currency Code")
//                 ELSE
//                     AddToJSon('document_currency_code', GeneralLedgerSetup."LCY Code");

//                 AddToJSon('debit_amount_dc', CustLedgerEntry."Debit Amount");
//                 AddToJSon('credit_amount_dc', CustLedgerEntry."Credit Amount");
//                 AddToJSon('cash_discount_dc', 0);
//             END;

//             IF SalesCrMemoHeader."Pre-Assigned No." <> '' THEN
//                 AddToJSon('invoice_reference', SalesCrMemoHeader."Pre-Assigned No.")
//             ELSE
//                 AddToJSon('invoice_reference', SalesCrMemoHeader."External Document No.");

//             AddToJSon('posting_period', FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Year4>'));
//             EndJSon;

//             JsonStringNew := JsonStringNew.Copy(GetJSon);

//             TxtJsonString := JsonStringNew;

//             MyFile.CREATE(GeneralLedgerSetup."MJson File Path" + '\' + SalesCrMemoHeader."Sell-to Customer Name" + FORMAT(SalesCrMemoHeader."Posting Date") + '.txt');
//             MyFile.CREATEOUTSTREAM(WriteFile);
//             WriteFile.WRITETEXT(TxtJsonString);
//             MyFile.CLOSE;

//             FILE.ERASE(GeneralLedgerSetup."MJson File Path" + '\' + SalesCrMemoHeader."Sell-to Customer Name" + FORMAT(SalesCrMemoHeader."Posting Date") + '.txt');

//             IF FnConnectiontoMintifiCreditMemo(JsonStringNew) THEN BEGIN
//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::"Credit Memo");
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//                 IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogIns.INIT;
//                     IF MintifiLogCheck.FINDLAST THEN;
//                     MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                     MintifiLogIns."Entry Date" := TODAY;
//                     MintifiLogIns."Document Type" := MintifiLogIns."Document Type"::"Credit Memo";
//                     MintifiLogIns."Document No." := SalesCrMemoHeader."No.";
//                     MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                     MintifiLogIns."Source No." := SalesCrMemoHeader."Sell-to Customer No.";
//                     MintifiLogIns."Source Name" := SalesCrMemoHeader."Sell-to Customer Name";
//                     SalesCrMemoHeader.CALCFIELDS("Amount Including VAT");

//                     CustLedgerEntryRec.RESET;
//                     CustLedgerEntryRec.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", Amount);
//                     CustLedgerEntryRec.SETRANGE("Document Type", CustLedgerEntryRec."Document Type"::"Credit Memo");
//                     CustLedgerEntryRec.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//                     IF CustLedgerEntryRec.FINDFIRST THEN BEGIN
//                         MintifiLogIns.Amount := CustLedgerEntryRec.Amount;
//                     END;

//                     MintifiLogIns.Status := MintifiLogIns.Status::Success;
//                     MintifiLogIns."Status Message" := Text50002;
//                     MintifiLogIns."Created By" := USERID;
//                     MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::"Order Process";
//                     MintifiLogIns.INSERT;
//                 END;

//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::"Credit Memo");
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//                 IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Success;
//                     MintifiLogCheckNew."Status Message" := Text50002;
//                     MintifiLogCheckNew."Created By" := USERID;
//                     MintifiLogCheckNew.MODIFY;
//                 END;

//             END
//             ELSE BEGIN
//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::"Credit Memo");
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//                 IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogIns.INIT;
//                     IF MintifiLogCheck.FINDLAST THEN;
//                     MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                     MintifiLogIns."Entry Date" := TODAY;
//                     MintifiLogIns."Document Type" := MintifiLogIns."Document Type"::"Credit Memo";
//                     MintifiLogIns."Document No." := SalesCrMemoHeader."No.";
//                     MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                     MintifiLogIns."Source No." := SalesCrMemoHeader."Sell-to Customer No.";
//                     MintifiLogIns."Source Name" := SalesCrMemoHeader."Sell-to Customer Name";
//                     SalesCrMemoHeader.CALCFIELDS("Amount Including VAT");
//                     CustLedgerEntryRec.RESET;
//                     CustLedgerEntryRec.SETAUTOCALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", Amount);
//                     CustLedgerEntryRec.SETRANGE("Document Type", CustLedgerEntryRec."Document Type"::"Credit Memo");
//                     CustLedgerEntryRec.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//                     IF CustLedgerEntryRec.FINDFIRST THEN BEGIN
//                         MintifiLogIns.Amount := CustLedgerEntryRec.Amount;
//                     END;
//                     MintifiLogIns.Status := MintifiLogIns.Status::Error;
//                     MintifiLogIns."Status Message" := GETLASTERRORTEXT;
//                     MintifiLogIns."Created By" := USERID;
//                     MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::"Order Process";
//                     MintifiLogIns.INSERT;
//                 END;

//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::"Credit Memo");
//                 MintifiLogCheckNew.SETRANGE("Document No.", SalesCrMemoHeader."No.");
//                 IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Error;
//                     MintifiLogCheckNew."Status Message" := GETLASTERRORTEXT;
//                     MintifiLogCheckNew."Created By" := USERID;
//                     MintifiLogCheckNew.MODIFY;
//                 END;
//             END;
//         END;
//     end;

//     [TryFunction]
//     // [Scope('Internal')]
//     procedure FnConnectiontoMintifiCreditMemo(JsonStringNewGetValue: DotNet String)
//     var
//         SSHttpWebRequest: DotNet HttpWebRequest;
//         SSHttpWebResponse: DotNet WebResponse;
//         StreamWriter: DotNet StreamWriter;
//         GeneralLedgerSetup: Record 98;
//     begin

//         GeneralLedgerSetup.GET;

//         SSHttpWebRequest := SSHttpWebRequest.Create(GeneralLedgerSetup."MCredit Memo URL");
//         SSHttpWebRequest.Method := 'POST';
//         SSHttpWebRequest.ContentType('application/json');
//         SSHttpWebRequest.Headers.Add('Authorization' + ':' + 'Bearer' + ' ' + GeneralLedgerSetup."MAuthorization Key");
//         SSHttpWebRequest.Accept('application/json');
//         SSHttpWebRequest.KeepAlive := TRUE;
//         SSHttpWebRequest.Timeout := 30000;
//         StreamWriter := StreamWriter.StreamWriter(SSHttpWebRequest.GetRequestStream);
//         StreamWriter.Write(JsonStringNewGetValue);
//         StreamWriter.Close;
//         DoWebRequest(SSHttpWebRequest, SSHttpWebResponse, '');
//         GetResponseStream(SSHttpWebResponse, JsonStringNewGetValue);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
//     // [Scope('Internal')]
//     procedure OnBeforePostPayementDoc(var GenJournalLine: Record 81)
//     var
//         GeneralLedgerSetup: Record 98;
//     begin

//         GeneralLedgerSetup.GET;

//         IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) AND (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) THEN BEGIN
//             IF GeneralLedgerSetup."MIs Payment" THEN BEGIN
//                 GenJournalLine.TESTFIELD("Account No.");
//                 GenJournalLine.TESTFIELD("External Document No.");
//                 GenJournalLine.TESTFIELD("Payment Method Code");
//             END;
//         END;

//         IF (GenJournalLine."Document Type" <> GenJournalLine."Document Type"::Payment) AND (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) THEN BEGIN
//             IF GeneralLedgerSetup."MIs Journal" THEN BEGIN
//                 GenJournalLine.TESTFIELD("Account No.");
//                 GenJournalLine.TESTFIELD("External Document No.");
//                 GenJournalLine.TESTFIELD("Payment Method Code");
//             END;
//         END;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterPostGenJnlLine', '', false, false)]
//     //   [Scope('Internal')]
//     procedure OnAfterPostPaymentDoc(var GenJournalLine: Record 81)
//     var
//         GeneralLedgerSetup: Record 98;
//     begin

//         GeneralLedgerSetup.GET;

//         IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) AND (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) THEN BEGIN
//             IF GeneralLedgerSetup."MIs Payment" THEN BEGIN
//                 GeneratePaymentDocMintifi(GenJournalLine."Document No.");
//             END;
//         END;

//         IF (GenJournalLine."Document Type" <> GenJournalLine."Document Type"::Payment) AND (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) THEN BEGIN
//             IF GeneralLedgerSetup."MIs Journal" THEN BEGIN
//                 GenerateJournalDocMintifi(GenJournalLine."Document No.", GenJournalLine."Document Type");
//             END;
//         END;
//     end;

//     //  [Scope('Internal')]
//     procedure GeneratePaymentDocMintifi(PayemntDocumentNo: Code[50])
//     var
//         SalesInvoiceHeaderNew: Record 112;
//         CompanyInformation: Record 79;
//         SalesInvoiceLine: Record 113;
//         declocalCurrecncyAmt: Decimal;
//         GeneralLedgerSetup: Record 98;
//         FileStream: DotNet FileStream;
//         StreamReader: DotNet StreamReader;
//         Stream: DotNet Stream;
//         NewFileName: Text[250];
//         FileManagement: Codeunit 419;
//         FilePath: Text[1024];
//         CustLedgerEntry: Record 21;
//         JsonStringNew: DotNet String;
//         MintifiLogCheck: Record 50049;
//         MintifiLogIns: Record 50049;
//         MintifiLogCheckNew: Record 50049;
//         Customer: Record 18;
//         CustEntry: Record 21;
//         CustEntryPaymentAgsInv: Record 21;
//         CdeInvDocNo: Code[1024];
//     begin

//         CompanyInformation.GET;

//         GeneralLedgerSetup.GET;

//         CustEntry.RESET;
//         CustEntry.SETAUTOCALCFIELDS(Amount, "Amount (LCY)", "Credit Amount", "Credit Amount (LCY)", "Debit Amount", "Debit Amount (LCY)");
//         CustEntry.SETRANGE("Document Type", CustEntry."Document Type"::Payment);
//         CustEntry.SETRANGE("Document No.", PayemntDocumentNo);
//         IF CustEntry.FINDFIRST THEN BEGIN

//             StartJSon;
//             AddToJSon('company_code', CompanyInformation.Name);
//             AddToJSon('fiscal_year', FnGetFiscalYearMonth(TODAY));
//             AddToJSon('document_number', PayemntDocumentNo);
//             AddToJSon('debit_credit_amount', CustEntry.Amount);
//             AddToJSon('customer_code', CustEntry."Customer No.");

//             // AddToJSon('cutoff_date',CustEntry."Document Date");
//             AddToJSon('cutoff_date', CustEntry."Due Date");

//             AddToJSon('document_type', 'Sales');
//             AddToJSon('document_date', CustEntry."Document Date");
//             AddToJSon('posting_date', CustEntry."Posting Date");
//             IF CustEntry."Payment Method Code" <> '' THEN
//                 AddToJSon('payment_method', CustEntry."Payment Method Code")
//             ELSE
//                 AddToJSon('payment_method', 'VISA');

//             AddToJSon('local_currency_code', GeneralLedgerSetup."LCY Code");
//             AddToJSon('credit_amount_lc', CustEntry."Credit Amount (LCY)");
//             AddToJSon('cash_discount_lc', 0);
//             IF CustEntry."Currency Code" <> '' THEN
//                 AddToJSon('document_currency_code', CustEntry."Currency Code")
//             ELSE
//                 AddToJSon('document_currency_code', GeneralLedgerSetup."LCY Code");

//             AddToJSon('credit_amount_dc', CustEntry."Credit Amount");
//             AddToJSon('cash_discount_dc', 0);

//             CLEAR(CdeInvDocNo);
//             CustEntryPaymentAgsInv.RESET;
//             CustEntryPaymentAgsInv.SETRANGE("Customer No.", CustEntry."Customer No.");
//             CustEntryPaymentAgsInv.SETRANGE("Document Type", CustEntryPaymentAgsInv."Document Type"::Invoice);
//             CustEntryPaymentAgsInv.SETRANGE("Closed by Entry No.", CustEntry."Entry No.");
//             IF CustEntryPaymentAgsInv.FINDSET THEN
//                 REPEAT
//                     IF CdeInvDocNo = '' THEN
//                         CdeInvDocNo := CustEntryPaymentAgsInv."Document No."
//                     ELSE
//                         CdeInvDocNo := CdeInvDocNo + '|' + CustEntryPaymentAgsInv."Document No.";
//                 UNTIL CustEntryPaymentAgsInv.NEXT = 0;

//             IF CdeInvDocNo = '' THEN
//                 AddToJSon('invoice_reference', CustEntry."External Document No.")
//             ELSE
//                 AddToJSon('invoice_reference', CdeInvDocNo);

//             AddToJSon('posting_period', FORMAT(CustEntry."Posting Date", 0, '<Year4>'));

//             EndJSon;

//             JsonStringNew := JsonStringNew.Copy(GetJSon);

//             TxtJsonString := JsonStringNew;

//             MyFile.CREATE(GeneralLedgerSetup."MJson File Path" + '\' + CustEntry."Customer No." + FORMAT(CustEntry."Entry No.") + '.txt');
//             MyFile.CREATEOUTSTREAM(WriteFile);
//             WriteFile.WRITETEXT(TxtJsonString);
//             MyFile.CLOSE;


//             FILE.ERASE(GeneralLedgerSetup."MJson File Path" + '\' + CustEntry."Customer No." + FORMAT(CustEntry."Entry No.") + '.txt');

//             IF FnConnectiontoMintifiPayment(JsonStringNew) THEN BEGIN
//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Payment);
//                 MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                 IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogIns.INIT;
//                     IF MintifiLogCheck.FINDLAST THEN;
//                     MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                     MintifiLogIns."Entry Date" := TODAY;
//                     MintifiLogIns."Document Type" := MintifiLogIns."Document Type"::Payment;
//                     MintifiLogIns."Document No." := CustEntry."Document No.";
//                     MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                     MintifiLogIns."Source No." := CustEntry."Customer No.";
//                     IF Customer.GET(CustEntry."Customer No.") THEN
//                         MintifiLogIns."Source Name" := Customer.Name;
//                     MintifiLogIns.Amount := CustEntry.Amount;
//                     MintifiLogIns.Status := MintifiLogIns.Status::Success;
//                     MintifiLogIns."Status Message" := Text50001;
//                     MintifiLogIns."Created By" := USERID;
//                     MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::Payment;
//                     MintifiLogIns.INSERT;
//                 END;

//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Payment);
//                 MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                 IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Success;
//                     MintifiLogCheckNew."Status Message" := Text50001;
//                     MintifiLogCheckNew."Created By" := USERID;
//                     MintifiLogCheckNew.MODIFY;
//                 END;
//             END
//             ELSE BEGIN
//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Payment);
//                 MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                 IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogIns.INIT;
//                     IF MintifiLogCheck.FINDLAST THEN;
//                     MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                     MintifiLogIns."Entry Date" := TODAY;
//                     MintifiLogIns."Document Type" := MintifiLogIns."Document Type"::Payment;
//                     MintifiLogIns."Document No." := CustEntry."Document No.";
//                     MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                     MintifiLogIns."Source No." := CustEntry."Customer No.";
//                     IF Customer.GET(CustEntry."Customer No.") THEN
//                         MintifiLogIns."Source Name" := Customer.Name;
//                     MintifiLogIns.Amount := CustEntry.Amount;
//                     MintifiLogIns.Status := MintifiLogIns.Status::Error;
//                     MintifiLogIns."Status Message" := GETLASTERRORTEXT;
//                     MintifiLogIns."Created By" := USERID;
//                     MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::Payment;
//                     MintifiLogIns.INSERT;
//                 END;

//                 MintifiLogCheckNew.RESET;
//                 MintifiLogCheckNew.SETRANGE("Document Type", MintifiLogCheckNew."Document Type"::Payment);
//                 MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                 IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                     MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Error;
//                     MintifiLogCheckNew."Status Message" := GETLASTERRORTEXT;
//                     MintifiLogCheckNew."Created By" := USERID;
//                     MintifiLogCheckNew.MODIFY;
//                 END;
//             END;
//         END;
//     end;

//     [TryFunction]
//     //[Scope('Internal')]
//     procedure FnConnectiontoMintifiPayment(JsonStringNewGetValue: DotNet String)
//     var
//         SSHttpWebRequest: DotNet HttpWebRequest;
//         SSHttpWebResponse: DotNet WebResponse;
//         StreamWriter: DotNet StreamWriter;
//         GeneralLedgerSetup: Record 98;
//     begin

//         GeneralLedgerSetup.GET;

//         SSHttpWebRequest := SSHttpWebRequest.Create(GeneralLedgerSetup."MPayment URL");
//         SSHttpWebRequest.Method := 'POST';
//         SSHttpWebRequest.ContentType('application/json');
//         SSHttpWebRequest.Headers.Add('Authorization' + ':' + 'Bearer' + ' ' + GeneralLedgerSetup."MAuthorization Key");
//         SSHttpWebRequest.Accept('application/json');
//         SSHttpWebRequest.KeepAlive := TRUE;
//         SSHttpWebRequest.Timeout := 30000;
//         StreamWriter := StreamWriter.StreamWriter(SSHttpWebRequest.GetRequestStream);
//         StreamWriter.Write(JsonStringNewGetValue);
//         StreamWriter.Close;
//         DoWebRequest(SSHttpWebRequest, SSHttpWebResponse, '');
//         GetResponseStream(SSHttpWebResponse, JsonStringNewGetValue);
//     end;

//     // [Scope('Internal')]
//     procedure GenerateJournalDocMintifi(JournalDocumentNo: Code[50]; JournalDocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund)
//     var
//         SalesInvoiceHeaderNew: Record 112;
//         CompanyInformation: Record 79;
//         SalesInvoiceLine: Record 113;
//         declocalCurrecncyAmt: Decimal;
//         GeneralLedgerSetup: Record 98;
//         FileStream: DotNet FileStream;
//         StreamReader: DotNet StreamReader;
//         Stream: DotNet Stream;
//         NewFileName: Text[250];
//         FileManagement: Codeunit 419;
//         FilePath: Text[1024];
//         CustLedgerEntry: Record 21;
//         JsonStringNew: DotNet String;
//         MintifiLogCheck: Record 50049;
//         MintifiLogIns: Record 50049;
//         MintifiLogCheckNew: Record 50049;
//         Customer: Record 18;
//         CustEntry: Record 21;
//     begin

//         CompanyInformation.GET;

//         GeneralLedgerSetup.GET;

//         CustEntry.RESET;
//         CustEntry.SETAUTOCALCFIELDS(Amount, "Amount (LCY)", "Credit Amount", "Credit Amount (LCY)", "Debit Amount", "Debit Amount (LCY)");
//         CustEntry.SETRANGE("Document Type", JournalDocumentType);
//         CustEntry.SETRANGE("Document No.", JournalDocumentNo);
//         IF CustEntry.FINDFIRST THEN BEGIN
//             IF CustEntry."Source Code" <> 'SALES' THEN BEGIN
//                 StartJSon;
//                 AddToJSon('company_code', CompanyInformation.Name);
//                 AddToJSon('fiscal_year', FnGetFiscalYearMonth(TODAY));
//                 AddToJSon('document_number', JournalDocumentNo);
//                 AddToJSon('debit_credit_amount', CustEntry.Amount);
//                 AddToJSon('customer_code', CustEntry."Customer No.");

//                 // AddToJSon('cutoff_date',CustEntry."Document Date");
//                 AddToJSon('cutoff_date', CustEntry."Due Date");

//                 AddToJSon('document_type', 'Sales');
//                 AddToJSon('document_date', CustEntry."Document Date");
//                 AddToJSon('posting_date', CustEntry."Posting Date");
//                 IF CustEntry."Payment Method Code" <> '' THEN
//                     AddToJSon('payment_method', CustEntry."Payment Method Code")
//                 ELSE
//                     AddToJSon('payment_method', 'VISA');

//                 AddToJSon('local_currency_code', GeneralLedgerSetup."LCY Code");
//                 AddToJSon('credit_amount_lc', CustEntry."Credit Amount (LCY)");
//                 AddToJSon('cash_discount_lc', 0);
//                 IF CustEntry."Currency Code" <> '' THEN
//                     AddToJSon('document_currency_code', CustEntry."Currency Code")
//                 ELSE
//                     AddToJSon('document_currency_code', GeneralLedgerSetup."LCY Code");

//                 AddToJSon('credit_amount_dc', CustEntry."Credit Amount");
//                 AddToJSon('cash_discount_dc', 0);

//                 AddToJSon('invoice_reference', CustEntry."External Document No.");
//                 AddToJSon('posting_period', FORMAT(CustEntry."Posting Date", 0, '<Year4>'));

//                 EndJSon;

//                 JsonStringNew := JsonStringNew.Copy(GetJSon);

//                 TxtJsonString := JsonStringNew;

//                 MyFile.CREATE(GeneralLedgerSetup."MJson File Path" + '\' + CustEntry."Customer No." + FORMAT(CustEntry."Entry No.") + '.txt');
//                 MyFile.CREATEOUTSTREAM(WriteFile);
//                 WriteFile.WRITETEXT(TxtJsonString);
//                 MyFile.CLOSE;

//                 FILE.ERASE(GeneralLedgerSetup."MJson File Path" + '\' + CustEntry."Customer No." + FORMAT(CustEntry."Entry No.") + '.txt');

//                 IF FnConnectiontoMintifiJournal(JsonStringNew) THEN BEGIN
//                     MintifiLogCheckNew.RESET;
//                     MintifiLogCheckNew.SETRANGE("Document Type", JournalDocumentType);
//                     MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                     IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                         MintifiLogIns.INIT;
//                         IF MintifiLogCheck.FINDLAST THEN;
//                         MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                         MintifiLogIns."Entry Date" := TODAY;
//                         MintifiLogIns."Document Type" := JournalDocumentType;
//                         MintifiLogIns."Document No." := CustEntry."Document No.";
//                         MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                         MintifiLogIns."Source No." := CustEntry."Customer No.";
//                         IF Customer.GET(CustEntry."Customer No.") THEN
//                             MintifiLogIns."Source Name" := Customer.Name;
//                         MintifiLogIns.Amount := CustEntry.Amount;
//                         MintifiLogIns.Status := MintifiLogIns.Status::Success;
//                         MintifiLogIns."Status Message" := Text50003;
//                         MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::Journal;
//                         MintifiLogIns."Created By" := USERID;
//                         MintifiLogIns.INSERT;
//                     END;

//                     MintifiLogCheckNew.RESET;
//                     MintifiLogCheckNew.SETRANGE("Document Type", JournalDocumentType);
//                     MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                     IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                         MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Success;
//                         MintifiLogCheckNew."Status Message" := Text50003;
//                         MintifiLogCheckNew."Created By" := USERID;
//                         MintifiLogCheckNew.MODIFY;
//                     END;
//                 END
//                 ELSE BEGIN
//                     MintifiLogCheckNew.RESET;
//                     MintifiLogCheckNew.SETRANGE("Document Type", JournalDocumentType);
//                     MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                     IF NOT MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                         MintifiLogIns.INIT;
//                         IF MintifiLogCheck.FINDLAST THEN;
//                         MintifiLogIns."Entry No." := MintifiLogCheck."Entry No." + 1;
//                         MintifiLogIns."Entry Date" := TODAY;
//                         MintifiLogIns."Document Type" := JournalDocumentType;
//                         MintifiLogIns."Document No." := CustEntry."Document No.";
//                         MintifiLogIns."Source Type" := MintifiLogIns."Source Type"::Customer;
//                         MintifiLogIns."Source No." := CustEntry."Customer No.";
//                         IF Customer.GET(CustEntry."Customer No.") THEN
//                             MintifiLogIns."Source Name" := Customer.Name;
//                         MintifiLogIns.Amount := CustEntry.Amount;
//                         MintifiLogIns.Status := MintifiLogIns.Status::Error;
//                         MintifiLogIns."Status Message" := GETLASTERRORTEXT;
//                         MintifiLogIns."Created By" := USERID;
//                         MintifiLogIns."Entry Type" := MintifiLogIns."Entry Type"::Journal;
//                         MintifiLogIns.INSERT;
//                     END;

//                     MintifiLogCheckNew.RESET;
//                     MintifiLogCheckNew.SETRANGE("Document Type", JournalDocumentType);
//                     MintifiLogCheckNew.SETRANGE("Document No.", CustEntry."Document No.");
//                     IF MintifiLogCheckNew.FINDFIRST THEN BEGIN
//                         MintifiLogCheckNew.Status := MintifiLogCheckNew.Status::Error;
//                         MintifiLogCheckNew."Status Message" := GETLASTERRORTEXT;
//                         MintifiLogCheckNew."Created By" := USERID;
//                         MintifiLogCheckNew.MODIFY;
//                     END;
//                 END;
//             END;
//         END;
//     end;

//     [TryFunction]
//     // [Scope('Internal')]
//     procedure FnConnectiontoMintifiJournal(JsonStringNewGetValue: DotNet String)
//     var
//         SSHttpWebRequest: DotNet HttpWebRequest;
//         SSHttpWebResponse: DotNet WebResponse;
//         StreamWriter: DotNet StreamWriter;
//         GeneralLedgerSetup: Record 98;
//     begin

//         GeneralLedgerSetup.GET;

//         SSHttpWebRequest := SSHttpWebRequest.Create(GeneralLedgerSetup.MJournalURL);
//         SSHttpWebRequest.Method := 'POST';
//         SSHttpWebRequest.ContentType('application/json');
//         SSHttpWebRequest.Headers.Add('Authorization' + ':' + 'Bearer' + ' ' + GeneralLedgerSetup."MAuthorization Key");
//         SSHttpWebRequest.Accept('application/json');
//         SSHttpWebRequest.KeepAlive := TRUE;
//         SSHttpWebRequest.Timeout := 30000;
//         StreamWriter := StreamWriter.StreamWriter(SSHttpWebRequest.GetRequestStream);
//         StreamWriter.Write(JsonStringNewGetValue);
//         StreamWriter.Close;
//         DoWebRequest(SSHttpWebRequest, SSHttpWebResponse, '');
//         GetResponseStream(SSHttpWebResponse, JsonStringNewGetValue);
//     end;

//     // [Scope('Internal')]
//     procedure FnGetFiscalYearMonth(FiscalYearCurrentDate: Date): Text[100]
//     var
//         MonthName: Text[100];
//         AccountingPeriod: Record 50;
//     begin

//         MonthName := FORMAT(FiscalYearCurrentDate, 0, '<Month Text>');

//         AccountingPeriod.RESET;
//         AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
//         AccountingPeriod.SETRANGE("Date Locked", TRUE);
//         AccountingPeriod.SETRANGE(Name, 'April');
//         IF AccountingPeriod.FINDFIRST THEN BEGIN
//             IF MonthName = 'April' THEN
//                 EXIT('01');

//             IF MonthName = 'May' THEN
//                 EXIT('02');

//             IF MonthName = 'June' THEN
//                 EXIT('03');

//             IF MonthName = 'July' THEN
//                 EXIT('04');

//             IF MonthName = 'August' THEN
//                 EXIT('05');

//             IF MonthName = 'September' THEN
//                 EXIT('06');

//             IF MonthName = 'October' THEN
//                 EXIT('07');

//             IF MonthName = 'November' THEN
//                 EXIT('08');

//             IF MonthName = 'December' THEN
//                 EXIT('09');

//             IF MonthName = 'January' THEN
//                 EXIT('10');

//             IF MonthName = 'February' THEN
//                 EXIT('11');

//             IF MonthName = 'March' THEN
//                 EXIT('12');
//         END;


//         AccountingPeriod.RESET;
//         AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
//         AccountingPeriod.SETRANGE("Date Locked", TRUE);
//         AccountingPeriod.SETRANGE(Name, 'January');
//         IF AccountingPeriod.FINDFIRST THEN BEGIN
//             IF MonthName = 'January' THEN
//                 EXIT('01');

//             IF MonthName = 'February' THEN
//                 EXIT('02');

//             IF MonthName = 'March' THEN
//                 EXIT('03');

//             IF MonthName = 'April' THEN
//                 EXIT('04');

//             IF MonthName = 'May' THEN
//                 EXIT('05');

//             IF MonthName = 'June' THEN
//                 EXIT('06');

//             IF MonthName = 'July' THEN
//                 EXIT('07');

//             IF MonthName = 'August' THEN
//                 EXIT('08');

//             IF MonthName = 'September' THEN
//                 EXIT('09');

//             IF MonthName = 'October' THEN
//                 EXIT('10');

//             IF MonthName = 'November' THEN
//                 EXIT('11');

//             IF MonthName = 'December' THEN
//                 EXIT('12');
//         END;
//     end;
// }


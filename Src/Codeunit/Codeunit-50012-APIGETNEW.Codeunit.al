/*
codeunit 50012 "API GETNEW"
{

    trigger OnRun()
    begin
        MESSAGE(FORMAT(DistanceMatrix('412220', '411018')));
    end;

    var
        HttpWebRequest: DotNet HttpWebRequest;
        GlobalSkipCheckHttps: Boolean;
        GlobalProgressDialogEnabled: Boolean;
        TraceLogEnabled: Boolean;
        txtJsonRequest: Text;
        ProcessingWindowMsg: Label 'Please wait while the server is processing your request.\This may take several minutes.';
        BaseAddress2: Label 'http://125.63.87.99:94/api/values/';
        BaseAddress: Label 'https://rspl-nav16.rsplhosting.com:94/e-waybill/api/values/';
        BaseAddress1: Label 'http://125.63.87.99:93/api/values/';
        BaseAdd: Label 'https://gsp.adaequare.com/test/enriched/ewb/ewayapi?action';
        token: Label 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTI3NDA4ODM0LCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0FQSV9HU1RfQ09NTU9OIiwiUk9MRV9TQl9FX0FQSV9HU1RfUkVUVVJOUyIsIlJPTEVfU0JfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9BU1BfU0JfQVBQIiwiUk9MRV9TQl9BUElfRVdCIiwiUk9MRV9TQl9FX0FQSV9FV0IiLCJST0xFX1NCX0VfQVBJX0dTVF9DT01NT04iXSwianRpIjoiMjFmOTI1ZTItZWUyNi00Y2Q0LWFjOTYtZTdmMjRkOTc2ODVmIiwiY2xpZW50X2lkIjoiMjAxMTI0RDQ5OUJDNDY1QkE3RkY5MzM1N0U0QzlFNzcifQ.VhCBtl4ZWQPmKLGM4nZiOYpE5fy_AEPQ_ySKc4DL830';
        DistanceMartixLink: Label 'https://rspl-nav16.rsplhosting.com:94/DistanceMatrix2/api/values/DistanceMatrix';
        EwayBillGeenrationURL: Label 'https://rspl-nav16.rsplhosting.com:94/e-waybill/api/values/';
        BingMapKey: Label 'Asp2STUpu8v3x-ngWOU3z9T2CM27NyuAGd0qWKxQYotcb4F_x8j0GAIQcoRYFNgr';

    // [Scope('Internal')]
    procedure InitiateMultivehicleUpdate(ewbNo: Text; groupNo: Text; oldvehicleNo: Text; newVehicleNo: Text; oldTranNo: Text; newTranNo: Text; fromPlace: Text; fromState: Text; reasonCode: Text; reasonRem: Text; var vehUpdDate: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtResult: Text;
        txtTest: Text;
    begin
        CLEARALL;

        txtJsonRequest := CreateInitiateMultivehMovementUpdateJson(ewbNo, groupNo, oldvehicleNo, newVehicleNo, oldTranNo, newTranNo, fromPlace, fromState, reasonCode, reasonRem);

        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'MULTIVEHUPD');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('Result');
        txtTest := FORMAT(JObject.ToString);
        IF txtTest = '' THEN BEGIN
            CLEAR(JObject);
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Message');
            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('vehUpdDate');
            vehUpdDate := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Message');

            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure CreateInitiateMultivehMovementUpdateJson(ewbNo: Text; groupNo: Text; oldvehicleNo: Text; newVehicleNo: Text; oldTranNo: Text; newTranNo: Text; fromPlace: Text; fromState: Text; reasonCode: Text; reasonRem: Text): Text
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JSON: DotNet String;
        JSONTextWriter: DotNet JsonTextWriter;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


        JSONTextWriter.WriteStartObject;

        CreateJsonAttribute('ewbNo', ewbNo, JSONTextWriter);
        CreateJsonAttribute('groupNo', groupNo, JSONTextWriter);
        CreateJsonAttribute('oldvehicleNo', oldvehicleNo, JSONTextWriter);
        CreateJsonAttribute('newVehicleNo', newVehicleNo, JSONTextWriter);
        CreateJsonAttribute('oldTranNo', oldTranNo, JSONTextWriter);
        CreateJsonAttribute('newTranNo', newTranNo, JSONTextWriter);
        CreateJsonAttribute('fromPlace', fromPlace, JSONTextWriter);
        CreateJsonAttribute('fromState', fromState, JSONTextWriter);
        CreateJsonAttribute('reasonCode', reasonCode, JSONTextWriter);
        CreateJsonAttribute('reasonRem', reasonRem, JSONTextWriter);

        JSONTextWriter.WriteEndObject;

        EXIT(StringBuilder.ToString);
    end;

    // [Scope('Internal')]
    procedure InitiateMultivehicleAddToGroup(ewbNo: Text; groupNo: Text; vehicleNo: Text; transDocNo: Text; transDocDate: Text; quantity: Text; var vehAddedDate: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtResult: Text;
        txtTest: Text;
    begin
        CLEARALL;

        //txtJsonRequest  :=  '{"ewbNo":"361001988224","reasonCode":"1","reasonRem":"vehicle broke down","fromPlace":"FRAZERTOWN","fromState":"29","toPlace":"Beml Nagar","toState":"29","transMode":"1","totalQuantity":"4","unitCode":"BOX"}';
        txtJsonRequest := CreateInitiateMultivehMovementAddToGroupJson(ewbNo, groupNo, vehicleNo, transDocNo, transDocDate, quantity);


        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'MULTIVEHADD');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('Result');
        txtTest := FORMAT(JObject.ToString);
        IF txtTest = '' THEN BEGIN
            CLEAR(JObject);
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Message');
            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('vehAddedDate');
            vehAddedDate := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Message');

            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure CreateInitiateMultivehMovementAddToGroupJson(ewbNo: Text; groupNo: Text; vehicleNo: Text; transDocNo: Text; transDocDate: Text; quantity: Text): Text
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JSON: DotNet String;
        JSONTextWriter: DotNet JsonTextWriter;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


        JSONTextWriter.WriteStartObject;

        CreateJsonAttribute('ewbNo', ewbNo, JSONTextWriter);
        CreateJsonAttribute('groupNo', groupNo, JSONTextWriter);
        CreateJsonAttribute('vehicleNo', vehicleNo, JSONTextWriter);
        CreateJsonAttribute('transDocNo', transDocNo, JSONTextWriter);
        CreateJsonAttribute('transDocDate', transDocDate, JSONTextWriter);
        CreateJsonAttribute('quantity', quantity, JSONTextWriter);

        JSONTextWriter.WriteEndObject;

        EXIT(StringBuilder.ToString);
    end;

    // [Scope('Internal')]
    procedure InitiateMultivehicleMovement(EwayBillNo: Text; ReasonCode: Text; ReasonRem: Text; FromPlace: Text; FromState: Text; ToPlace: Text; ToState: Text; TransMode: Text; TotalQuantity: Text; UnitCode: Text; var groupNo: Text; var createdDate: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtResult: Text;
        txtTest: Text;
    begin
        CLEARALL;

        txtJsonRequest := CreateInitiateMultivehMovementJson(EwayBillNo, ReasonCode, ReasonRem, FromPlace, FromState, ToPlace, ToState, TransMode, TotalQuantity, UnitCode);
        //txtJsonRequest  :=  '{"ewbNo":"361001988224","reasonCode":"1","reasonRem":"vehicle broke down","fromPlace":"FRAZERTOWN","fromState":"29","toPlace":"Beml Nagar","toState":"29","transMode":"1","totalQuantity":"4","unitCode":"BOX"}';


        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'MULTIVEHMOVINT');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('Result');
        txtTest := FORMAT(JObject.ToString);
        IF txtTest = '' THEN BEGIN
            CLEAR(JObject);
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Message');
            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('groupNo');
            groupNo := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('createdDate');
            createdDate := JObject.ToString;


            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('Message');

            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure CreateInitiateMultivehMovementJson(EwbNo: Text; ReasonCode: Text; ReasonRem: Text; FromPlace: Text; FromState: Text; ToPlace: Text; ToState: Text; TransMode: Text; TotalQuantity: Text; UnitCode: Text): Text
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JSON: DotNet String;
        JSONTextWriter: DotNet JsonTextWriter;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


        JSONTextWriter.WriteStartObject;
        CreateJsonAttribute('ewbNo', EwbNo, JSONTextWriter);
        CreateJsonAttribute('reasonCode', ReasonCode, JSONTextWriter);
        CreateJsonAttribute('reasonRem', ReasonRem, JSONTextWriter);
        CreateJsonAttribute('fromPlace', FromPlace, JSONTextWriter);
        CreateJsonAttribute('fromState', FromState, JSONTextWriter);
        CreateJsonAttribute('toPlace', ToPlace, JSONTextWriter);
        CreateJsonAttribute('toState', ToState, JSONTextWriter);
        CreateJsonAttribute('transMode', TransMode, JSONTextWriter);
        CreateJsonAttribute('totalQuantity', TotalQuantity, JSONTextWriter);
        CreateJsonAttribute('unitCode', UnitCode, JSONTextWriter);

        JSONTextWriter.WriteEndObject;

        EXIT(StringBuilder.ToString);
    end;

    // [Scope('Internal')]
    procedure CancelEWB(EwbNo: Text; cancelRsnCode: Text; cancelRmrk: Text; var cancelDate: Text; var ewayBillNo: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
    begin
        CLEARALL;

        txtJsonRequest := CreateJsonCancelEWB(EwbNo, cancelRsnCode, cancelRmrk);

        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'CancelEWB');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('success');
        txtSuccess := JObject.ToString;
        IF JObject.ToString = 'False' THEN BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');

            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('result');
            txtJsonResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResult);
            JObject := JObject.GetValue('cancelDate');
            cancelDate := JObject.ToString;


            //clear(JObject);
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');
            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure CreateJsonCancelEWB(Ewbno: Text; cancelRsnCode: Text; cancelRmrk: Text): Text
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JSON: DotNet String;
        JSONTextWriter: DotNet JsonTextWriter;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);

        JSONTextWriter.WriteStartObject;
        CreateJsonAttribute('ewbNo', Ewbno, JSONTextWriter);
        CreateJsonAttribute('cancelRsnCode', cancelRsnCode, JSONTextWriter);
        CreateJsonAttribute('cancelRmrk', cancelRmrk, JSONTextWriter);

        JSONTextWriter.WriteEndObject;

        EXIT(StringBuilder.ToString);
    end;

    //[Scope('Internal')]
    procedure ExtendValidity(EwbNo: Text; vehicleNo: Text; fromPlace: Text; fromStateCode: Text; fromState: Text; remainingDistance: Text; transDocNo: Text; transDocDate: Text; transMode: Text; extnRsnCode: Text; extnRemarks: Text; var updatedDate: Text; var validUpto: Text; fromPincode: Text; consignmentStatus_transitType: Text; addressLine1_addressLine2_addressLine3: Text; GstIn_AccessKey_UserName_Password: Text)
    var
        Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        cancelDate: Text;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtResult: Text;
        consignmentStatus: Text;
        transitType: Text;
        addressLine1: Text;
        addressLine2: Text;
        addressLine3: Text;
        GstIn: Text;
        AccessKey: Text;
        UserName: Text;
        Password: Text;
    begin

        //VehicleUpdate.


        consignmentStatus := SELECTSTR(1, consignmentStatus_transitType);
        transitType := SELECTSTR(2, consignmentStatus_transitType);


        addressLine1 := SELECTSTR(2, addressLine1_addressLine2_addressLine3);
        addressLine2 := SELECTSTR(2, addressLine1_addressLine2_addressLine3);
        addressLine3 := SELECTSTR(2, addressLine1_addressLine2_addressLine3);

        GstIn := SELECTSTR(1, GstIn_AccessKey_UserName_Password);
        AccessKey := SELECTSTR(2, GstIn_AccessKey_UserName_Password);
        UserName := SELECTSTR(3, GstIn_AccessKey_UserName_Password);
        Password := SELECTSTR(4, GstIn_AccessKey_UserName_Password);
        //txtJsonRequest := CreateExtendValidity(EwbNo,vehicleNo,fromPlace,fromStateCode,fromState,remainingDistance,transDocNo,transDocDate,transMode,extnRsnCode,extnRemarks);
        txtJsonRequest := CreateExtendValidity(EwbNo, vehicleNo, fromPlace, fromStateCode, fromState, remainingDistance, transDocNo, transDocDate, transMode, extnRsnCode, extnRemarks, fromPincode, consignmentStatus, transitType, addressLine1, addressLine2, addressLine3);
        IF USERID = 'ROBOSOFT.SUPPORT2' THEN
            MESSAGE(txtJsonRequest);
        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'EwbExtendValidity');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;



        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('success');

        IF JObject.ToString = 'False' THEN BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');

            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('updatedDate');
            updatedDate := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('validUpto');
            validUpto := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('message');
            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure CreateExtendValidity(EwbNo: Text; vehicleNo: Text; fromPlace: Text; fromStateCode: Text; fromState: Text; remainingDistance: Text; transDocNo: Text; transDocDate: Text; transMode: Text; extnRsnCode: Text; extnRemarks: Text; fromPincode: Text; consignmentStatus: Text; transitType: Text; addressLine1: Text; addressLine2: Text; addressLine3: Text): Text
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JSON: DotNet String;
        JSONTextWriter: DotNet JsonTextWriter;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


        JSONTextWriter.WriteStartObject;
        //AKT_EWB 28082019
        CreateJsonAttribute('EwbNo', EwbNo, JSONTextWriter);
        CreateJsonAttribute('VehicleNo', vehicleNo, JSONTextWriter);
        CreateJsonAttribute('FromPlace', fromPlace, JSONTextWriter);
        CreateJsonAttribute('fromStateCode', fromStateCode, JSONTextWriter);
        CreateJsonAttribute('fromState', fromState, JSONTextWriter);
        CreateJsonAttribute('remainingDistance', remainingDistance, JSONTextWriter);
        CreateJsonAttribute('TransDocNo', transDocNo, JSONTextWriter);
        CreateJsonAttribute('TransDocDate', transDocDate, JSONTextWriter);
        CreateJsonAttribute('TransMode', transMode, JSONTextWriter);
        CreateJsonAttribute('extnRsnCode', extnRsnCode, JSONTextWriter);
        CreateJsonAttribute('extnRemarks', extnRemarks, JSONTextWriter);
        CreateJsonAttribute('fromPincode', fromPincode, JSONTextWriter);
        CreateJsonAttribute('consignmentStatus', consignmentStatus, JSONTextWriter);
        CreateJsonAttribute('transitType', transitType, JSONTextWriter);
        CreateJsonAttribute('addressLine1', addressLine1, JSONTextWriter);
        CreateJsonAttribute('addressLine2', addressLine2, JSONTextWriter);
        CreateJsonAttribute('addressLine3', addressLine3, JSONTextWriter);
        //AKT_EWB 28082019
        JSONTextWriter.WriteEndObject;

        EXIT(StringBuilder.ToString);
    end;

    //[Scope('Internal')]
    procedure VehUpdate(EwbNo: Text; VehicleNo: Text; FromPlace: Text; FromState: Text; ReasonCode: Text; ReasonRem: Text; TransDocNo: Text; TransDocDate: Text; TransMode: Text; var vehUpdDate: Text; var validUpto: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtResult: Text;
    begin
        CLEARALL;
        //VehicleUpdate.

        txtJsonRequest := CreateJsonVH(EwbNo, VehicleNo, FromPlace, FromState, ReasonCode, ReasonRem, TransDocNo, TransDocDate, TransMode);

        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'VehicleUpdate');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('success');
        IF JObject.ToString = 'False' THEN BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');

            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('vehUpdDate');
            vehUpdDate := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('validUpto');
            validUpto := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');
            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure CreateJsonVH(EwbNo: Text; VehicleNo: Text; FromPlace: Text; FromState: Text; ReasonCode: Text; ReasonRem: Text; TransDocNo: Text; TransDocDate: Text; TransMode: Text): Text
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JSON: DotNet String;
        JSONTextWriter: DotNet JsonTextWriter;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


        JSONTextWriter.WriteStartObject;

        CreateJsonAttribute('EwbNo', EwbNo, JSONTextWriter);
        CreateJsonAttribute('VehicleNo', VehicleNo, JSONTextWriter);
        CreateJsonAttribute('FromPlace', FromPlace, JSONTextWriter);
        CreateJsonAttribute('FromState', FromState, JSONTextWriter);
        CreateJsonAttribute('ReasonCode', ReasonCode, JSONTextWriter);
        CreateJsonAttribute('ReasonRem', ReasonRem, JSONTextWriter);
        CreateJsonAttribute('TransDocNo', TransDocNo, JSONTextWriter);
        CreateJsonAttribute('TransDocDate', TransDocDate, JSONTextWriter);
        CreateJsonAttribute('TransMode', TransMode, JSONTextWriter);

        JSONTextWriter.WriteEndObject;

        EXIT(StringBuilder.ToString);
    end;

    local procedure CreateJsonAttribute(PropertyName: Text; Value: Variant; JSONTextWriter: DotNet JsonTextWriter)
    var
        StringWriter: DotNet StringWriter;
    begin
        JSONTextWriter.WritePropertyName(PropertyName);
        JSONTextWriter.WriteValue(Value);
    end;

    //[Scope('Internal')]
    procedure GenEWB(var alert: Text; var ewayBillDate: Text; var ewayBillNo: Text; var validUpto: Text; DocNo: Code[20]; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        cancelDate: Text;
        JObject: DotNet JObject;
        TempBlob2: Record 99008535 temporary;
        TempBlob3: Record 99008535 temporary;
        txtJsonResponse: Text;
        txtResult: Text;
    begin

        ReturnGenEBWJson(TempBlob2, DocNo);

        txtJsonRequest := ReadAsText('', TempBlob2);//('',TEXTENCODING::UTF8);
        txtJsonRequest := ReplaceString(txtJsonRequest, '"itemList": {', '"itemList": [{');
        txtJsonRequest := ReplaceString(txtJsonRequest, '}}', '}]}');

        IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') OR (USERID = 'GPUAE\RAVI.KHAMBAL') THEN
            MESSAGE(txtJsonRequest); //temp

        //I/32/I/2021/0249
        HttpClient := HttpClient.HttpClient;
        //URI :=  URI.Uri(EwayBillGeenrationURL);
        URI := URI.Uri(BaseAddress + 'GenerateEwayBill');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        IF DocNo = 'I/36/I/2021/0001' THEN
            MESSAGE(txtJsonResponse);
        //Break
        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('success');
        IF JObject.ToString = 'False' THEN BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');

            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('alert');
            alert := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('ewayBillDate');
            ewayBillDate := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('ewayBillNo');
            ewayBillNo := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('validUpto');
            validUpto := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');
            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure ReturnGenEBWJson(var TempBlob2: Record 99008535; DocNo: Code[20])
    var
        [RunOnClient]
        XMLDoc: DotNet XmlDocument;
        [RunOnClient]
        JSONConvert: DotNet JsonConvert;
        myInStream: InStream;
        myJson: Text;
        JSONFormatting: DotNet Formatting;
        myOutStream: OutStream;
        GSTLedgerEntry: Record "GST Ledger Entry";
        lvTempBlob: Record 99008535 temporary;
    begin
        XMLDoc := XMLDoc.XmlDocument;
        //
        GSTLedgerEntry.SETFILTER("Document No.", DocNo);
        IF GSTLedgerEntry.FINDFIRST THEN BEGIN
            lvTempBlob."Primary Key" := 21;
            lvTempBlob.INSERT;
            lvTempBlob.Blob.CREATEOUTSTREAM(myOutStream);
            XMLPORT.EXPORT(XMLPORT::"Generate EwayBill", myOutStream, GSTLedgerEntry);
            lvTempBlob.MODIFY;
        END;
        //Temp
        XMLDoc.LoadXml(ReadAsText('', lvTempBlob));
        //XMLDoc.Load('E:\Ysr\Generate EwayBill2.xml');
        myJson := JSONConvert.SerializeXmlNode(XMLDoc.DocumentElement, JSONFormatting.Indented, TRUE);

        TempBlob2.INIT;
        TempBlob2.Blob.CREATEOUTSTREAM(myOutStream, TEXTENCODING::UTF8);
        myOutStream.WRITETEXT(myJson);
    end;

    //  [Scope('Internal')]
    procedure "--Blob Begin"()
    begin
    end;

    //[Scope('Internal')]
    procedure WriteAsText(Content: Text; prtempBlob: Record 99008535)
    var
        OutStr: OutStream;
    begin
        CLEAR(prtempBlob.Blob);
        IF Content = '' THEN
            EXIT;
        prtempBlob.Blob.CREATEOUTSTREAM(OutStr);
        OutStr.WRITETEXT(Content);
    end;

    //[Scope('Internal')]
    procedure ReadAsText(LineSeparator: Text; prtempBlob: Record 99008535) Content: Text
    var
        InStream: InStream;
        ContentLine: Text;
    begin
        prtempBlob.Blob.CREATEINSTREAM(InStream);

        InStream.READTEXT(Content);
        WHILE NOT InStream.EOS DO BEGIN
            InStream.READTEXT(ContentLine);
            Content += LineSeparator + ContentLine;
        END;
    end;

    // [Scope('Internal')]
    procedure "--Blob End"()
    begin
    end;

    // [Scope('Internal')]
    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    //[Scope('Internal')]
    procedure "---------------------------------------"()
    begin
    end;

    // [Scope('Internal')]
    procedure "GETAPIs-----------------------------"()
    begin
    end;

    //[Scope('Internal')]
    procedure GetEWBDetail(EwbNo: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtURL: Text;
        FileName: Text;
        TestFile: File;
        FileMgt: Codeunit 419;
        MyOutStream: OutStream;
        [RunOnClient]
        JSONConvert: DotNet JsonConvert;
    begin
        CLEARALL;

        HttpClient := HttpClient.HttpClient;

        URI := URI.Uri(BaseAddress + 'GetEwayBill?EwbNo=' + EwbNo);
        //URI :=  URI.Uri(txtURL);
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.GetAsync(URI).Result;

        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        //Save in notepad Begin
        FileName := FileMgt.SaveFileDialog('Window Title', '.txt', 'Text files *.txt|*.txt');
        IF FileName = '' THEN
            EXIT;
        TestFile.CREATE(FileName);
        TestFile.CREATEOUTSTREAM(MyOutStream);
        MyOutStream.WRITETEXT(txtJsonResponse);
        HYPERLINK(FileName);
        //Save in notepad End
    end;

    // [Scope('Internal')]
    procedure GetGSTINDetails(GSTIN: Text; GstIn1: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtURL: Text;
        FileName: Text;
        TestFile: File;
        FileMgt: Codeunit 419;
        MyOutStream: OutStream;
        [RunOnClient]
        JSONConvert: DotNet JsonConvert;
    begin
        CLEARALL;

        HttpClient := HttpClient.HttpClient;

        URI := URI.Uri(BaseAddress + 'GetGSTINDetails?GSTIN=' + GSTIN);
        //URI :=  URI.Uri(txtURL);
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GSTIN);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.GetAsync(URI).Result;

        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        //Save in notepad Begin
        FileName := FileMgt.SaveFileDialog('Window Title', '.txt', 'Text files *.txt|*.txt');
        IF FileName = '' THEN
            EXIT;
        TestFile.CREATE(FileName);
        TestFile.CREATEOUTSTREAM(MyOutStream);
        MyOutStream.WRITETEXT(txtJsonResponse);
        MESSAGE(txtJsonResponse);
        HYPERLINK(FileName);
        //Save in notepad End
    end;

    //   [Scope('Internal')]
    procedure GetHsnDetailsByHsnCode(HsnCode: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtURL: Text;
        FileName: Text;
        TestFile: File;
        FileMgt: Codeunit 419;
        MyOutStream: OutStream;
        [RunOnClient]
        JSONConvert: DotNet JsonConvert;
    begin
        CLEARALL;

        HttpClient := HttpClient.HttpClient;

        URI := URI.Uri(BaseAddress + 'GetHsnDetailsByHsnCode?hsncode=' + HsnCode);
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', 'GPNAV2016');
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.GetAsync(URI).Result;

        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        //Save in notepad Begin
        FileName := FileMgt.SaveFileDialog('Window Title', '.txt', 'Text files *.txt|*.txt');
        IF FileName = '' THEN
            EXIT;
        TestFile.CREATE(FileName);
        TestFile.CREATEOUTSTREAM(MyOutStream);
        MyOutStream.WRITETEXT(txtJsonResponse);
        MESSAGE(txtJsonResponse);
        HYPERLINK(FileName);
        //Save in notepad End
    end;

    // [Scope('Internal')]
    procedure "---------------->>>>>>>"()
    begin
    end;

    // [Scope('Internal')]
    procedure TestReturnGenEBWJson(var TempBlob2: Record 99008535; DocNo: Code[20])
    var
        [RunOnClient]
        XMLDoc: DotNet XmlDocument;
        [RunOnClient]
        JSONConvert: DotNet JsonConvert;
        myInStream: InStream;
        myJson: Text;
        JSONFormatting: DotNet Formatting;
        myOutStream: OutStream;
        GSTLedgerEntry: Record "16418";
        lvTempBlob: Record "99008535" temporary;
    begin
        XMLDoc := XMLDoc.XmlDocument;
        GSTLedgerEntry.SETFILTER("Document No.", DocNo);
        IF GSTLedgerEntry.FINDFIRST THEN BEGIN
            lvTempBlob."Primary Key" := 21;
            lvTempBlob.INSERT;
            lvTempBlob.Blob.CREATEOUTSTREAM(myOutStream);
            XMLPORT.EXPORT(50004, myOutStream, GSTLedgerEntry);
            lvTempBlob.MODIFY;
        END;
        XMLDoc.LoadXml(ReadAsText('', lvTempBlob));
        //XMLDoc.Load('E:\Ysr\Generate EwayBill2.xml');
        myJson := JSONConvert.SerializeXmlNode(XMLDoc.DocumentElement, JSONFormatting.Indented, TRUE);

        TempBlob2.INIT;
        TempBlob2.Blob.CREATEOUTSTREAM(myOutStream, TEXTENCODING::UTF8);
        myOutStream.WRITETEXT(myJson);
    end;

    // [Scope('Internal')]
    procedure DistanceMatrix(FromPinCode: Text; ToPinCode: Text): Decimal
    var
        HttpResponseMessage: DotNet HttpResponseMessage;
        BaseAddres: Text;
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        txtJsonResponse: Text;
        JObject: DotNet JObject;
        txtTest: Text;
        txtResult: Text;
        decDistanceInKm: Decimal;
        TextComma: Label '"';
        FindWhat: Label 'An error has occurred.';
    begin
        CLEARALL;
        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(DistanceMartixLink);
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('FromPinCode', FromPinCode + '+India');
        HttpClient.DefaultRequestHeaders.Add('ToPinCode', ToPinCode + '+India');
        HttpClient.DefaultRequestHeaders.Add('BingMapKey', BingMapKey);
        HttpResponseMessage := HttpClient.GetAsync(URI).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;
        txtJsonResponse := DELCHR(txtJsonResponse, '=', TextComma);
        IF STRPOS(txtJsonResponse, FindWhat) = 0 THEN BEGIN
            EVALUATE(decDistanceInKm, txtJsonResponse);
            decDistanceInKm := ROUND(decDistanceInKm, 1, '>');
            IF (decDistanceInKm = 0) OR (decDistanceInKm = 1) THEN
                decDistanceInKm := 100;
            EXIT(decDistanceInKm);
        END;
    end;

    // [Scope('Internal')]
    procedure UpdateTransporter(EwbNo: Text; transporterId: Text; var transUpdateDate: Text; GstIn: Text; AccessKey: Text; UserName: Text; Password: Text)
    var
        Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtResult: Text;
    begin
        CLEARALL;

        txtJsonRequest := CreateUpdateTransporterJson(EwbNo, transporterId);

        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'UpdateTransporterEWB');
        HttpClient.BaseAddress(URI);
        HttpClient.DefaultRequestHeaders.Add('GSTIN', GstIn);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', AccessKey);
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
        HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('success');
        IF JObject.ToString = 'False' THEN BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');

            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('transUpdateDate');
            transUpdateDate := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');
            MESSAGE(JObject.ToString)

        END;
    end;

    local procedure CreateUpdateTransporterJson(EwbNo: Text; transporterId: Text): Text
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JSON: DotNet String;
        JSONTextWriter: DotNet JsonTextWriter;
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
        JSONTextWriter.WriteStartObject;
        CreateJsonAttribute('EwbNo', EwbNo, JSONTextWriter);
        CreateJsonAttribute('transporterId', transporterId, JSONTextWriter);
        JSONTextWriter.WriteEndObject;
        EXIT(StringBuilder.ToString);

    end;

    //  [Scope('Internal')]
    procedure GetEwayBillByDocument(DocNo: Text; DocType: Text; var EwayBillNo: Text; var ewayBillDate: Text; var ewayBillvalidUpto: Text; AccessKey: Text; GSTIN: Text; UserName: Text; Password: Text)
    var
        Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
        HttpClient: DotNet HttpClient;
        URI: DotNet Uri;
        ReqHdr: DotNet HttpRequestHeaders;
        HttpStringContent: DotNet StringContent;
        txtJsonResult: Text;
        Encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        JObject: DotNet JObject;
        txtSuccess: Text;
        txtJsonResponse: Text;
        txtResult: Text;
        GetEwayBillUrl2: Label 'https://gsp.adaequare.com/test/enriched/ewb/ewayapi/GetEwayBillGeneratedByConsigner';
        Authorization: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNjAwODQwNTAyLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0VXQiJdLCJqdGkiOiI1ZGM4YTNjMC04ODUzLTRkNzMtOTEzMy05Y2ZhZTA3Y2EzYmQiLCJjbGllbnRfaWQiOiI5RkVBRTFFMzZCM0U0ODgxQjlCQTk0RUY0NjdBMUI0OSJ9.TZ7vUHF6KBdPb0vA4NJe96CXdT-GpAQG7ntih5mYpYE';
        requestid: Text;
        GetEwayBillUrl: Label 'http://125.63.87.99:94/api/values/GetEwayBillGeneratedByConsigner';
    begin
        CLEARALL;

        HttpClient := HttpClient.HttpClient;
        URI := URI.Uri(BaseAddress + 'GetEwayBillGeneratedByConsigner');
        HttpClient.BaseAddress(URI);

        HttpClient.DefaultRequestHeaders.Add('GSTIN', GSTIN);
        HttpClient.DefaultRequestHeaders.Add('AccessKey', AccessKey);
        HttpClient.DefaultRequestHeaders.Add('UserName', UserName);
        HttpClient.DefaultRequestHeaders.Add('Password', Password);
        HttpClient.DefaultRequestHeaders.Add('DOCTYPE', DocType);
        HttpClient.DefaultRequestHeaders.Add('DOCNO', DocNo);

        HttpResponseMessage := HttpClient.GetAsync(URI).Result;
        txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        txtJsonResponse := COPYSTR(txtJsonResponse, 2, STRLEN(txtJsonResponse) - 2);
        txtJsonResponse := DELCHR(txtJsonResponse, '=', '\');

        JObject := JObject.JObject;
        JObject := JObject.Parse(txtJsonResponse);
        JObject := JObject.GetValue('success');
        IF JObject.ToString = 'False' THEN BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');

            ERROR(JObject.ToString)
        END ELSE BEGIN
            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('result');
            txtResult := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('ewayBillNo');
            EwayBillNo := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('ewayBillDate');
            ewayBillDate := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtResult);
            JObject := JObject.GetValue('validUpto');
            ewayBillvalidUpto := JObject.ToString;

            JObject := JObject.JObject;
            JObject := JObject.Parse(txtJsonResponse);
            JObject := JObject.GetValue('message');
            MESSAGE(JObject.ToString)
        END;
    end;
}

*/
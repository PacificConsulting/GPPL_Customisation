
tableextension 50083 GstLedEntryExtCstm extends "GST Ledger Entry"
{
    fields
    {
        field(50000; "E-Way Bill No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AKT_EWB';
        }
        field(50203; "Distance in kms"; Decimal)
        {
            Description = 'AKT_EWB';
        }
        field(50204; "Scan QrCode E-Invoice"; Text[250])
        {
            Description = 'ysr_EINV';

            trigger OnValidate()
            var
                //EInvoiceAPI: Codeunit 50011;
                GeneralLedgerSetup: Record 98;
                AuthToken: Text;
                Sek: Text;
                TokenExpiry: Text;
                ClientId: Text;
                decryptedSek: Text;
                recLocation: Record 14;
                Irn: Text;
            begin
            end;
        }
        field(50205; "E-Inv Irn"; Text[250])
        {
            Description = 'ysr_EINV';
            Editable = false;
        }
        field(50206; "QR Code"; BLOB)
        {
            Description = 'RSPLSUM_EINV';
        }
        field(50207; "IRN Ack. Date"; Text[20])
        {
            Description = 'DJ_EINV';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}
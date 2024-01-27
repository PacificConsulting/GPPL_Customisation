pageextension 50009 CustomerCardExtCStm extends "Customer Card"
{
    layout
    {
        modify("Phone No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify("Fax No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                BEGIN
                    IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                        ModifyCustomer;//RSPLSUM 22Jun2020
                END;
            end;
        }
        modify("E-Mail")
        {
            Importance = Promoted;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify("Customer Posting Group")
        {
            Importance = Promoted;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                CurrPage.UPDATE;//RSPLSUM 11May2020
            END;
        }
        modify("Payment Terms Code")
        {
            Importance = Promoted;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 25May2020>>
                IF Rec."Payment Terms Code" <> '' THEN
                    Rec.TESTFIELD("Customer Posting Group");
                //RSPLSUM 25May2020<<
            END;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify("Credit Limit (LCY)")
        {

            Visible = CreditLimtLycVisible;
            Editable = CreditLimitLCYEditable;
        }
        modify("Search Name")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }

        modify("Primary Contact No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify("Country/Region Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify(City)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify("Address 2")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify(Address)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                Rec.TESTFIELD("Full Name");//02Apr2018

                IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                    ModifyCustomer;//RSPLSUM 22Jun2020
            END;
        }

        // Add changes to page layout here
        addafter("Service Zone Code")
        {

            // field(Structure; rec.Structure)
            // {
            //     applicationArea = all;
            // }
            field(Contact; Rec.Contact)
            {
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                        ModifyCustomer;//RSPLSUM 22Jun2020
                end;
            }
            field("National Discount Applicable"; rec."National Discount Applicable")
            {
                applicationArea = all;
            }
            field("LBT Reg. No."; rec."LBT Reg. No.")
            {
                applicationArea = all;

            }
            field("Parent Customer"; rec."Parent Customer")
            {
                Editable = ParentCust;
            }
            field("Consolidated Cr. Limit"; rec."Consolidated Cr. Limit")
            {
                Visible = FALSE;
                Editable = ConsolidatedCrLimit;
            }
            field("RWR Salesperson"; rec."RWR Salesperson")
            {
                applicationArea = all;
            }
            // field("Responsibility Center"; rec."Responsibility Center")
            // {
            //     applicationArea = all;
            //     trigger OnValidate()
            //     var
            //         myInt: Integer;
            //     BEGIN
            //         IF "Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
            //             ModifyCustomer;//RSPLSUM 22Jun2020
            //     END;
            // }
            field(Type; rec.Type)
            {
                applicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //EBT/CNF/0001
                    IF Rec.Type = Rec.Type::Customer THEN
                        IF Rec."Vendor No." = '' THEN
                            VenNo := FALSE //RSPL-TC
                        ELSE
                            VenNo := TRUE; //RSPL-TC
                                           //EBT/CNF/0001
                END;
            }
            field("Full Name"; rec."Full Name")
            {
                applicationArea = all;
            }
            field("Customer Cr. Group"; rec."Customer Cr. Group")
            {
                applicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //EBT/CrLimit/0001
                    IF Rec."Customer Cr. Group" = Rec."Customer Cr. Group"::"Group Customer" THEN BEGIN
                        //CurrForm."Consolidated Cr. Limit".EDITABLE := FALSE;
                        //CurrForm."Parent Customer".EDITABLE := TRUE;
                        ConsolidatedCrLimit := FALSE; //RSPL-TC
                        ParentCust := TRUE; //RSPL-TC
                    END
                    ELSE BEGIN
                        //CurrForm."Consolidated Cr. Limit".EDITABLE := TRUE;
                        //CurrForm."Parent Customer".EDITABLE := FALSE;
                        ConsolidatedCrLimit := TRUE; //RSPL-TC
                        ParentCust := FALSE; //RSPL-TC
                    END;

                    //EBT/CrLimit/0001
                END;
            }
            field("Creation Date"; rec."Creation Date")
            {
                applicationArea = all;
            }
            field("Commercial Rating"; rec."Commercial Rating")
            {
                applicationArea = all;
            }
            field("Credit Rating"; rec."Credit Rating")
            {
                applicationArea = all;
            }
            field("Vendor No."; rec."Vendor No.")
            {
                Editable = VenNo;
                applicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                        ModifyCustomer;//RSPLSUM 22Jun2020
                END;
            }
            field("Inter Company Customer"; rec."Inter Company Customer")
            {
                applicationArea = all;
            }
            field(Legal; rec.Legal)
            {
                applicationArea = all;
            }
            field("Customer Group Code"; rec."Customer Group Code")
            {
                ApplicationArea = all;
            }
            field("Exclude From Bal Confir Mail"; rec."Exclude From Bal Confir Mail")
            {
                applicationArea = all;
            }
            field("O/s Email Alert"; rec."O/s Email Alert")
            {
                applicationArea = all;
            }
            field("Transport Subsidy Applicable"; rec."Transport Subsidy Applicable")
            {
                applicationArea = all;
            }
            field("Our Account No."; rec."Our Account No.")
            {
                ApplicationArea = all;
            }
            field("Headquarter Location"; rec."Headquarter Location")
            {
                ApplicationArea = all;
            }
            field("Insurance Limit"; rec."Insurance Limit")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Insurance Limit" <> xRec."Insurance Limit") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Management Limit"; rec."Management Limit")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Management Limit" <> xRec."Management Limit") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Temporary Limit"; rec."Temporary Limit")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Temporary Limit" <> xRec."Temporary Limit") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Insurance Limit Exp Date"; rec."Insurance Limit Exp Date")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Insurance Limit Exp Date" <> xRec."Insurance Limit Exp Date") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Management Limit Exp Date"; rec."Management Limit Exp Date")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Management Limit Exp Date" <> xRec."Management Limit Exp Date") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Temporary Limit Exp Date"; rec."Temporary Limit Exp Date")
            {
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Temporary Limit Exp Date" <> xRec."Temporary Limit Exp Date") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Credit Limit Approval"; rec."Credit Limit Approval")
            {
                ApplicationArea = all;
                Visible = FALSE;
                Editable = FALSE;
            }
            field("Insurance Percentage"; rec."Insurance Percentage")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Insurance Percentage" <> xRec."Insurance Percentage") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Management Percentage"; rec."Management Percentage")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Management Percentage" <> xRec."Management Percentage") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;
            }
            field("Temporary Percentage"; rec."Temporary Percentage")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN

                    IF (Rec."Temporary Percentage" <> xRec."Temporary Percentage") THEN BEGIN
                        Rec."Credit Limit Approval" := TRUE;
                        Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                        Rec.MODIFY;
                    END;
                END;

            }
            field("Trade License Available"; rec."Trade License Available")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Trade License Available" <> xRec."Trade License Available") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<

                    IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                        ModifyCustomer;//RSPLSUM 22Jun2020
                END;
            }
            field("Licensing Authority"; rec."Licensing Authority")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Licensing Authority" <> xRec."Licensing Authority") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<

                    IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                        ModifyCustomer;//RSPLSUM 22Jun2020
                END;
            }
            field("License Number"; rec."License Number")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."License Number" <> xRec."License Number") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Date Of Issue"; rec."Date Of Issue")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Date Of Issue" <> xRec."Date Of Issue") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Place Of Issue"; rec."Place Of Issue")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Place Of Issue" <> xRec."Place Of Issue") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Date Of Expiry"; rec."Date Of Expiry")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Date Of Expiry" <> xRec."Date Of Expiry") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Bank Ref. Name"; rec."Bank Ref. Name")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Bank Ref. Name" <> xRec."Bank Ref. Name") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Person On Behalf"; rec."Person On Behalf")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Person On Behalf" <> xRec."Person On Behalf") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Business Type"; rec."Business Type")
            {
                ApplicationArea = all;
            }
            field("Business Reg No. Available"; rec."Business Reg No. Available")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Business Reg No. Available" <> xRec."Business Reg No. Available") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Business Reg No."; rec."Business Reg No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Business Reg No." <> xRec."Business Reg No.") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Bank Branch"; rec."Bank Branch")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Bank Branch" <> xRec."Bank Branch") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Bank Account No." <> xRec."Bank Account No.") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("IBAN No."; rec."IBAN No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."IBAN No." <> xRec."IBAN No.") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Swift Code"; rec."Swift Code")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Swift Code" <> xRec."Swift Code") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<
                END;
            }
            field("Approval Status"; rec."Approval Status")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("Credit Limit Approval Status"; rec."Credit Limit Approval Status")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("Balance Credit Limit"; rec."Balance Credit Limit")
            {
                ApplicationArea = all;
            }
            field("KYC Approval Status"; rec."KYC Approval Status")
            {
                ApplicationArea = all;
            }
            field("Balance Credit Limit in USD"; rec."Balance Credit Limit in USD")
            {
                ApplicationArea = all;
            }
            field(BalanceCreditLimit; rec.BalanceCreditLimit)
            {
                ApplicationArea = all;
            }
            field("Customer Type"; rec."Customer Type")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 22Jun2020>>
                    IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
                            ERROR('No changes allowed when the customer is pending for approval');

                        IF (Rec."Customer Type" <> xRec."Customer Type") THEN BEGIN
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
                            Rec.MODIFY;
                        END;
                    END;
                    //RSPLSUM 22Jun2020<<

                    IF Rec."Customer Posting Group" = 'FO' THEN//RSPLSUM 22Jun2020
                        ModifyCustomer;//RSPLSUM 22Jun2020
                END;
            }
            field("Freight Type"; rec."Freight Type")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Approved Payment Days"; rec."Approved Payment Days")
            {
                ApplicationArea = all;
            }
            // field("Partner Type"; rec."Partner Type")
            // {
            //     ApplicationArea = all;
            // }
            field("Customer Kms"; rec."Customer Kms")
            {
                ApplicationArea = all;
            }
            field("W.e.f. Date(C.S.T No.)"; rec."W.e.f. Date(C.S.T No.)")
            {
                ApplicationArea = all;
            }
            field("Linking of Aadhaar with PAN"; rec."Linking of Aadhaar with PAN")
            {
                ApplicationArea = all;
            }
            field("Turnover Above 10 Crores"; rec."Turnover Above 10 Crores")
            {
                ApplicationArea = all;
            }
            field("ITR filled for last 02 years"; rec."ITR filled for last 02 years")
            {
                ApplicationArea = all;
            }
            field("W.e.f. Date(T.I.N No.)"; rec."W.e.f. Date(T.I.N No.)")
            {
                ApplicationArea = all;
            }
            field(TANNO; rec.TANNO)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(SendApprovalRequest)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                //>>
                SRSetup.GET;
                IF SRSetup."Email Alert On Customer App" THEN
                    EmailNotification(3, REC."No.", 1, USERID);
                //                 //<<
            end;
        }
        modify(CancelApprovalRequest)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin

            end;
        }
        //modify(send)

        addafter("F&unctions")
        {
            action("Send Approval Request")
            {
                Promoted = true;
                Image = SendApprovalRequest;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                BEGIN
                    rec.TESTFIELD("No.");
                    rec.TESTFIELD(Name);
                    rec.TESTFIELD(Address);
                    rec.TESTFIELD("Address 2");
                    rec.TESTFIELD(City);
                    rec.TESTFIELD(Contact);
                    rec.TESTFIELD("Phone No.");
                    rec.TESTFIELD("Customer Posting Group", 'FO');
                    //TESTFIELD("Currency Code");
                    rec.TESTFIELD("Payment Terms Code");
                    rec.TESTFIELD("Country/Region Code");
                    rec.TESTFIELD("Payment Terms Code");
                    rec.TESTFIELD("Gen. Bus. Posting Group");
                    rec.TESTFIELD("E-Mail");
                    //TESTFIELD("Responsibility Center");
                    //RSPLSUM 19Jun2020>>
                    IF rec."Customer Posting Group" = 'FO' THEN BEGIN
                        IF rec."Customer Type" = rec."Customer Type"::" " THEN
                            ERROR('Customer Type should not be blank');
                    END;
                    //RSPLSUM 19Jun2020<<

                    IF rec."Approval Status" = rec."Approval Status"::Approved THEN//RSPLSUM 03Jul2020
                        ERROR('This customer is already approved');//RSPLSUM 03Jul2020

                    IF rec."Approval Status" <> rec."Approval Status"::"Pending For Approval" THEN BEGIN
                        //ss--IF Blocked = Blocked::All THEN
                        //ss--BEGIN
                        rec.TESTFIELD(Contact);
                        IF rec."Salesperson Code" = '' THEN
                            ERROR(Text005, rec.FIELDCAPTION("Salesperson Code"));
                        rec.TESTFIELD("E-Mail");
                        rec.TESTFIELD("Gen. Bus. Posting Group");
                        rec.TESTFIELD("Customer Posting Group");
                        rec.TESTFIELD("Payment Terms Code");
                        rec.TESTFIELD("Payment Method Code");
                        //              {
                        //              IF "Insurance Limit" <> 0 THEN BEGIN
                        //     IF "Insurance Limit Exp Date" = 0D THEN
                        //         ERROR(Text005, FIELDCAPTION("Insurance Limit Exp Date"));
                        //     IF "Insurance Percentage" = 0 THEN
                        //         ERROR(Text005, FIELDCAPTION("Insurance Percentage"));
                        // END;

                        // IF "Management Limit" <> 0 THEN BEGIN
                        //     IF "Management Limit Exp Date" = 0D THEN
                        //         ERROR(Text005, FIELDCAPTION("Management Limit Exp Date"));
                        //     IF "Management Percentage" = 0 THEN
                        //         ERROR(Text005, FIELDCAPTION("Management Percentage"));
                        // END;

                        // IF "Temporary Limit" <> 0 THEN BEGIN
                        //     IF "Insurance Limit Exp Date" = 0D THEN
                        //         ERROR(Text005, FIELDCAPTION("Insurance Limit Exp Date"));
                        //     IF "Insurance Percentage" = 0 THEN
                        //         ERROR(Text005, FIELDCAPTION("Insurance Percentage"));
                        // END;


                        // IF ("Customer Type" = "Customer Type"::"Local") THEN BEGIN
                        //     IF "Trade License Available" = TRUE THEN BEGIN
                        //         IF "Licensing Authority" = '' THEN ERROR(Text005, FIELDCAPTION("Licensing Authority"));
                        //         IF "License Number" = '' THEN ERROR(Text005, FIELDCAPTION("License Number"));
                        //         IF "Date Of Issue" = 0D THEN ERROR(Text005, FIELDCAPTION("Date Of Issue"));
                        //         IF "Place Of Issue" = '' THEN ERROR(Text005, FIELDCAPTION("Place Of Issue"));
                        //         IF "Date Of Expiry" = 0D THEN ERROR(Text005, FIELDCAPTION("Date Of Expiry"));
                        //     END;
                        //     IF "Credit Limit (LCY)" = 0 THEN ERROR(Text005, FIELDCAPTION("Credit Limit (LCY)"));
                        //     IF "Person On Behalf" = '' THEN ERROR(Text005, FIELDCAPTION("Person On Behalf"));
                        // END;

                        // IF ("Customer Type" = "Customer Type"::Bunker) THEN BEGIN
                        //     IF "Business Reg No. Available" = TRUE THEN BEGIN
                        //         IF "Business Reg No." = '' THEN ERROR(Text005, FIELDCAPTION("Business Reg No."));
                        //         IF "Date Of Issue" = 0D THEN ERROR(Text005, FIELDCAPTION("Date Of Issue"));
                        //         IF "Place Of Issue" = '' THEN ERROR(Text005, FIELDCAPTION("Place Of Issue"));
                        //         IF "Date Of Expiry" = 0D THEN ERROR(Text005, FIELDCAPTION("Date Of Expiry"));
                        //     END;

                        //     IF "Business Type" = 0 THEN ERROR(Text005, FIELDCAPTION("Business Type"));
                        //     IF "Person On Behalf" = '' THEN ERROR(Text005, FIELDCAPTION("Person On Behalf"));
                        // END;
                        // IF ("Inter Dept Customer" = FALSE) THEN BEGIN
                        //     IF "Bank Ref. Name" = '' THEN ERROR(Text005, FIELDCAPTION("Bank Ref. Name"));
                        //     IF "Bank Branch" = '' THEN ERROR(Text005, FIELDCAPTION("Bank Branch"));
                        //     IF "Bank Account No." = '' THEN ERROR(Text005, FIELDCAPTION("Bank Account No."));
                        //     IF "IBAN No." = '' THEN ERROR(Text005, FIELDCAPTION("IBAN No."));
                        //     IF "Swift Code" = '' THEN ERROR(Text005, FIELDCAPTION("Swift Code"));

                        // END;
                        //              }
                        //  {//
                        //  IF Approvals.CheckApprDocument(DATABASE::Customer,ApprovalEntry."Document Type"::Customer) THEN
                        //  BEGIN
                        //    Approvals.SendCustApprovalRequest(Rec);
                        //    MESSAGE('Customer %1 sent for approval',Rec."No.");
                        //  END ELSE
                        //  BEGIN
                        //    "Approval Status" := "Approval Status"::Approved;
                        //    Blocked := 0;
                        //    MODIFY;
                        //    MESSAGE('Customer %1 has been approved',Rec."No.");
                        //  END;
                        //  }//

                        TempVersionNo := 0;
                        SAE19.RESET;
                        SAE19.SETCURRENTKEY("Document No.", "Version No.");
                        SAE19.SETRANGE("Document Type", SAE19."Document Type"::Customer);
                        SAE19.SETRANGE("Document No.", rec."No.");
                        IF SAE19.FINDLAST THEN
                            TempVersionNo := SAE19."Version No." + 1
                        ELSE
                            TempVersionNo := 1;

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::Customer);
                        SalesApproval.SETRANGE("User ID", USERID);
                        SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                        IF SalesApproval.FINDSET THEN BEGIN
                            TempSeqNo := 0;
                            REPEAT
                                TempSeqNo += 1;
                                SalesApprovalEntry.INIT;
                                SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::Customer;
                                SalesApprovalEntry."Document No." := rec."No.";
                                SalesApprovalEntry."User ID" := USERID;
                                SalesApprovalEntry."User Name" := SalesApproval.Name;
                                SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                SalesApprovalEntry."Time Sent for Approval" := TIME;
                                SalesApprovalEntry."Version No." := TempVersionNo;
                                SalesApprovalEntry."Sequence No." := TempSeqNo;
                                //SalesApprovalEntry.Type := SalesApprovalEntry.Type::Customer;//RSPLSUM 05Nov2019
                                //SalesApprovalEntry."Customer/Vendor No." := "No.";//RSPLSUM 05Nov2019
                                //SalesApprovalEntry."Customer/Vendor Name" := Name;//RSPLSUM 05Nov2019
                                //SalesApprovalEntry."Payment Terms Code" := "Payment Terms Code";//RSPLSUM 05Nov2019
                                //SalesApprovalEntry."Payment Method Code" := "Payment Method Code";//RSPLSUM 05Nov2019
                                SalesApprovalEntry.INSERT;
                            UNTIL SalesApproval.NEXT = 0;

                            rec."Approval Status" := rec."Approval Status"::"Pending For Approval";
                            rec.MODIFY(TRUE);
                            //>>
                            SRSetup.GET;
                            IF SRSetup."Email Alert On Customer App" THEN
                                EmailNotification(3, REC."No.", 1, USERID);
                            //<<

                            MESSAGE('Customer No. %1 has been sent for Approval', rec."No.");
                        END ELSE
                            ERROR('Customer Approval setup does not exists for User %1', USERID);
                        //ss--END ELSE
                        //ss--ERROR('Blocked must be ALL');
                    END ELSE
                        ERROR('This Customer has been already sent for approval');
                END;


            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                ApplicationArea = all;
                trigger OnAction()
                BEGIN
                    //Approvals.CancelCustApprovalRequest(Rec,TRUE,TRUE);

                    IF rec."Approval Status" = rec."Approval Status"::Open THEN
                        ERROR('This document is already open. Nothing to cancel.');

                    IF rec."Approval Status" = rec."Approval Status"::Approved THEN
                        ERROR('This approval request cannot be cancelled because the Customer has been already approved.');

                    IF rec."Approval Status" = rec."Approval Status"::"Pending For Approval" THEN BEGIN
                        //ss--IF Blocked = Blocked::All THEN
                        //ss--BEGIN
                        SAE19.RESET;
                        SAE19.SETCURRENTKEY("Document No.", "Version No.");
                        SAE19.SETRANGE("Document Type", SAE19."Document Type"::Customer);
                        SAE19.SETRANGE("Document No.", rec."No.");
                        SAE19.SETRANGE(Approved, FALSE);
                        SAE19.SETRANGE(Cancelled, FALSE);
                        SAE19.SETRANGE(Rejected, FALSE);
                        IF SAE19.FINDLAST THEN BEGIN
                            RecUserSetup.RESET;//RSPLSUM 11Dec19
                            IF RecUserSetup.GET(USERID) THEN;//RSPLSUM 11Dec19
                                                             //RSPLSUM 11Dec19---IF (USERID  <> 'GPUAE\KAUSTUBH.PARAB') AND (USERID  <> 'GPUAE\UNNIKRISHNAN.VS') THEN
                            IF (USERID <> 'GPUAE\KAUSTUBH.PARAB') AND (USERID <> 'GPUAE\UNNIKRISHNAN.VS') AND (RecUserSetup."Credit Limit Approval" = FALSE) THEN//RSPLSUM 11Dec19
                                IF SAE19."User ID" <> USERID THEN
                                    ERROR('Only Requester USERID is allowed for Cancel Approval Request');
                            SAE19.MODIFYALL(Cancelled, TRUE);
                            SAE19.MODIFYALL("Cancelled Date", TODAY);
                            SAE19.MODIFYALL("Cancelled Time", TIME);

                        END;

                        rec.VALIDATE("Approval Status", rec."Approval Status"::Open);
                        rec.MODIFY;
                        //>>
                        SRSetup.GET;
                        IF SRSetup."Email Alert On Customer App" THEN
                            EmailNotification(3, REC."No.", 3, USERID);
                        //<<

                        //ss--END ELSE
                        //ss--ERROR('Blocked must be ALL');
                    END;
                    MESSAGE('%1 %2 approval request cancelled', 'Customer', REC."No.");
                END;


            }
            action("Send Credit Limit Approval Request")
            {
                Promoted = true;
                Image = SendApprovalRequest;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                BEGIN
                    Rec.TESTFIELD(Rec."Approval Status", Rec."Approval Status"::Approved);

                    IF ((Rec."Insurance Limit" <> 0) OR (Rec."Management Limit" <> 0) OR (Rec."Temporary Limit" <> 0)) THEN BEGIN
                        IF Rec."Credit Limit Approval Status" <> Rec."Credit Limit Approval Status"::"Pending For Approval" THEN BEGIN
                            IF Rec."Credit Limit Approval" = TRUE THEN BEGIN
                                IF Rec."Insurance Limit" <> 0 THEN BEGIN
                                    IF Rec."Insurance Limit Exp Date" = 0D THEN
                                        ERROR(Text005, Rec.FIELDCAPTION("Insurance Limit Exp Date"));
                                    IF Rec."Insurance Percentage" = 0 THEN
                                        ERROR(Text005, Rec.FIELDCAPTION("Insurance Percentage"));
                                END;

                                IF Rec."Management Limit" <> 0 THEN BEGIN
                                    IF Rec."Management Limit Exp Date" = 0D THEN
                                        ERROR(Text005, Rec.FIELDCAPTION("Management Limit Exp Date"));
                                    IF Rec."Management Percentage" = 0 THEN
                                        ERROR(Text005, Rec.FIELDCAPTION("Management Percentage"));
                                END;

                                IF Rec."Temporary Limit" <> 0 THEN BEGIN
                                    IF Rec."Temporary Limit Exp Date" = 0D THEN
                                        ERROR(Text005, Rec.FIELDCAPTION("Temporary Limit Exp Date"));
                                    IF Rec."Temporary Percentage" = 0 THEN
                                        ERROR(Text005, Rec.FIELDCAPTION("Temporary Percentage"));
                                END;
                                //        {//
                                //        IF Approvals.CheckApprDocument(DATABASE::Customer, ApprovalEntry."Document Type"::OCL) THEN BEGIN
                                //     Approvals.SendCustOCLApprovalRequest(Rec);
                                //     MESSAGE('Customer %1 sent for approval', Rec."No.");
                                // END ELSE BEGIN
                                //     "Credit Limit Approval Status" := "Credit Limit Approval Status"::Approved;
                                //     MODIFY;
                                //     MESSAGE('Customer %1 has been approved', Rec."No.");
                                // END;
                                //        }//

                                TempVersionNo := 0;
                                SAE19.RESET;
                                SAE19.SETCURRENTKEY("Document No.", "Version No.");
                                SAE19.SETRANGE("Document Type", SAE19."Document Type"::"Customer OCL");
                                SAE19.SETRANGE("Document No.", Rec."No.");
                                IF SAE19.FINDLAST THEN
                                    TempVersionNo := SAE19."Version No." + 1
                                ELSE
                                    TempVersionNo := 1;

                                SalesApproval.RESET;
                                SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Customer OCL");
                                SalesApproval.SETRANGE("User ID", USERID);
                                SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                                IF SalesApproval.FINDSET THEN BEGIN
                                    TempSeqNo := 0;
                                    REPEAT
                                        TempSeqNo += 1;
                                        SalesApprovalEntry.INIT;
                                        SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::"Customer OCL";
                                        SalesApprovalEntry."Document No." := Rec."No.";
                                        SalesApprovalEntry."User ID" := USERID;
                                        SalesApprovalEntry."User Name" := SalesApproval.Name;
                                        SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                        SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                        SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                        SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                        SalesApprovalEntry."Time Sent for Approval" := TIME;
                                        SalesApprovalEntry."Version No." := TempVersionNo;
                                        SalesApprovalEntry."Sequence No." := TempSeqNo;
                                        //SalesApprovalEntry.Type := SalesApprovalEntry.Type::Customer;//RSPLSUM 05Nov2019
                                        //SalesApprovalEntry."Customer/Vendor No." := "No.";//RSPLSUM 05Nov2019
                                        //SalesApprovalEntry."Customer/Vendor Name" := Name;//RSPLSUM 05Nov2019
                                        //SalesApprovalEntry."Payment Terms Code" := "Payment Terms Code";//RSPLSUM 05Nov2019
                                        //SalesApprovalEntry."Payment Method Code" := "Payment Method Code";//RSPLSUM 05Nov2019
                                        SalesApprovalEntry.INSERT;
                                    UNTIL SalesApproval.NEXT = 0;

                                    Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::"Pending For Approval";
                                    Rec.MODIFY(TRUE);

                                    IF SalesApproval."User ID" <> SalesApproval."Approvar ID" THEN BEGIN
                                        //>>
                                        SRSetup.GET;
                                        IF SRSetup."Email Alert On Customer Credit" THEN
                                            EmailNotification(4, Rec."No.", 2, USERID);
                                        //<<
                                        MESSAGE('Customer No. %1 has been sent for Credit Limit Approval', Rec."No.");
                                    END ELSE BEGIN
                                        SAE09.RESET;
                                        SAE09.SETCURRENTKEY("Document Type", "Document No.");
                                        SAE09.SETRANGE("Document Type", SAE09."Document Type"::"Customer OCL");
                                        SAE09.SETRANGE("Document No.", Rec."No.");
                                        SAE09.SETRANGE("User ID", USERID);
                                        SAE09.SETRANGE("Approvar ID", USERID);
                                        SAE09.SETRANGE(Approved, FALSE);
                                        IF SAE09.FINDLAST THEN BEGIN

                                            Rec."Credit Limit Approval" := FALSE;
                                            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Approved;
                                            Rec.MODIFY(TRUE);

                                            SAE09.Approved := TRUE;
                                            SAE09."Approval Date" := TODAY;
                                            SAE09."Approval Time" := TIME;
                                            SAE09.MODIFY;

                                            SAE09_01.RESET;
                                            SAE09_01.SETCURRENTKEY("Document No.", "Version No.");
                                            SAE09_01.SETRANGE("Document Type", SAE09_01."Document Type"::"Customer OCL");
                                            SAE09_01.SETRANGE("Document No.", SAE09."Document No.");
                                            SAE09_01.SETRANGE("Version No.", SAE09."Version No.");
                                            SAE09_01.SETRANGE(Approved, FALSE);
                                            IF SAE09_01.FINDFIRST THEN BEGIN
                                                SAE09_01.DELETEALL(TRUE);
                                            END;
                                        END;
                                        //>>
                                        SRSetup.GET;
                                        IF SRSetup."Email Alert On Customer Credit" THEN
                                            EmailNotification(4, Rec."No.", 5, USERID);
                                        //<<
                                        MESSAGE('Customer No. %1 has been Self Approved', Rec."No.");
                                    END;
                                END ELSE
                                    ERROR('Customer Credit Limit Approval setup does not exists for User %1', USERID);
                            END ELSE
                                ERROR('OCL must be FALSE');
                        END ELSE
                            ERROR('This Customer has been already sent for approval');
                    END ELSE
                        ERROR('Nothing to Approve');
                END;


            }
            action("Cancel Credit Limit Approval Request")
            {
                Image = Cancel;
                ApplicationArea = all;
                trigger OnAction()
                BEGIN
                    //Approvals.CancelCustOCLApprovalRequest(Rec,TRUE,TRUE);

                    IF Rec."Credit Limit Approval Status" = Rec."Credit Limit Approval Status"::Open THEN
                        ERROR('This document is already open. Nothing to cancel.');
                    IF Rec."Credit Limit Approval Status" = Rec."Credit Limit Approval Status"::Approved THEN
                        ERROR('This approval request cannot be canceled because the Customer Credit Limit has been already approved.');

                    IF Rec."Credit Limit Approval Status" = Rec."Credit Limit Approval Status"::"Pending For Approval" THEN BEGIN
                        IF Rec."Credit Limit Approval" = TRUE THEN BEGIN
                            SAE19.RESET;
                            SAE19.SETCURRENTKEY("Document No.", "Version No.");
                            SAE19.SETRANGE("Document Type", SAE19."Document Type"::"Customer OCL");
                            SAE19.SETRANGE("Document No.", Rec."No.");
                            SAE19.SETRANGE(Approved, FALSE);
                            SAE19.SETRANGE(Cancelled, FALSE);
                            SAE19.SETRANGE(Rejected, FALSE);
                            IF SAE19.FINDLAST THEN BEGIN
                                IF SAE19."User ID" <> USERID THEN
                                    ERROR('Only Requester USERID is allowed for Cancel Approval Request');
                                SAE19.MODIFYALL(Cancelled, TRUE);
                                SAE19.MODIFYALL("Cancelled Date", TODAY);
                                SAE19.MODIFYALL("Cancelled Time", TIME);
                            END;

                            Rec.VALIDATE("Credit Limit Approval Status", Rec."Credit Limit Approval Status"::Open);
                            Rec.MODIFY;
                            //>>
                            SRSetup.GET;
                            IF SRSetup."Email Alert On Customer Credit" THEN
                                EmailNotification(4, REC."No.", 2, USERID);
                            //<<

                        END ELSE
                            ERROR('OCL must be FALSE');
                    END;

                    MESSAGE('%1 %2 approval request cancelled', 'Customer OCL', REC."No.");
                END;


            }
            // action("Approval Entries")
            // {
            //     Image = Ledger;
            //     trigger OnAction()
            //     BEGIN

            //         AppPage.Setfilters(9, REC."No.");
            //         AppPage.RUN;
            //     END;


            // }
            action("Send  KYC Request")
            {
                Promoted = true;
                Image = SendApprovalRequest;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    Text001: Label 'ENU=Approval Status Must be Approved Current Status is %1';
                    Text002: Label 'ENU=This customer is Already Approved';
                    Text003: Label 'ENU=Customer No. %1 has been sent for Approval';
                    Text004: Label 'ENU=Customer Approval setup does not exists for User %1';
                    Text010: Label 'ENU=This Customer has been already sent for approval';
                    SalesApproval: Record 50008;
                    Text011: Label 'ENU="Do not have Permission to Send To Customer KYC Approval "';
                BEGIN
                    //RSPLAM29597 -- BEGIN

                    IF Rec."KYC Approval Status" = Rec."KYC Approval Status"::Approved THEN
                        ERROR(Text002);

                    IF Rec."KYC Approval Status" <> Rec."KYC Approval Status"::"Pending For Approval" THEN BEGIN
                        TempVersionNo := 0;
                        SAE19.RESET;
                        SAE19.SETCURRENTKEY("Document No.", "Version No.");
                        SAE19.SETRANGE("Document Type", SAE19."Document Type"::"Customer KYC");
                        SAE19.SETRANGE("Document No.", REC."No.");
                        IF SAE19.FINDLAST THEN
                            TempVersionNo := SAE19."Version No." + 1
                        ELSE
                            TempVersionNo := 1;

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Customer KYC");
                        SalesApproval.SETRANGE("User ID", USERID);
                        SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                        IF SalesApproval.FINDSET THEN BEGIN
                            TempSeqNo := 0;
                            REPEAT
                                TempSeqNo += 1;
                                SalesApprovalEntry.INIT;
                                SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::"Customer KYC";
                                SalesApprovalEntry."Document No." := Rec."No.";
                                SalesApprovalEntry."User ID" := USERID;
                                SalesApprovalEntry."User Name" := SalesApproval.Name;
                                SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                SalesApprovalEntry."Time Sent for Approval" := TIME;
                                SalesApprovalEntry."Version No." := TempVersionNo;
                                SalesApprovalEntry."Sequence No." := TempSeqNo;
                                SalesApprovalEntry.INSERT;
                            UNTIL SalesApproval.NEXT = 0;

                            Rec."KYC Approval Status" := Rec."KYC Approval Status"::"Pending For Approval";
                            Rec.MODIFY(TRUE);

                            SRSetup.GET;
                            IF SRSetup."Email Alert On Customer KYC" THEN
                                EmailNotification(5, Rec."No.", 1, USERID);

                            MESSAGE(Text003, REC."No.");
                        END ELSE
                            ERROR(Text004, USERID);
                    END ELSE
                        ERROR(Text010);

                    //RSPLAM29597 ++ END
                END;

            }
            action("Cancel KYC Request")
            {
                Image = Cancel;
                ApplicationArea = all;
                trigger OnAction()

                VAR
                    Text00001: Label 'ENU=This Document is already open. Nothing To Cancel.';
                    Text00002: Label 'ENU=This approval request cannot be cancelled because the Customer has been already approved.';
                    Text00003: Label 'ENU=Only Requester USERID is allowed for Cancel Approval Request';
                    Text00004: Label 'ENU=%1 %2 approval request cancelled.';
                BEGIN
                    //RSPLAM29597 --- BEGIN
                    IF Rec."KYC Approval Status" = Rec."KYC Approval Status"::Open THEN
                        ERROR(Text00001);

                    IF Rec."KYC Approval Status" = Rec."KYC Approval Status"::Approved THEN
                        ERROR(Text00002);

                    IF Rec."KYC Approval Status" = Rec."KYC Approval Status"::"Pending For Approval" THEN BEGIN
                        SAE19.RESET;
                        SAE19.SETCURRENTKEY("Document No.", "Version No.");
                        SAE19.SETRANGE("Document Type", SAE19."Document Type"::"Customer KYC");
                        SAE19.SETRANGE("Document No.", Rec."No.");
                        SAE19.SETRANGE(Approved, FALSE);
                        SAE19.SETRANGE(Cancelled, FALSE);
                        SAE19.SETRANGE(Rejected, FALSE);
                        IF SAE19.FINDLAST THEN BEGIN
                            RecUserSetup.RESET;
                            IF RecUserSetup.GET(USERID) THEN;
                            IF (USERID <> 'GPUAE\KAUSTUBH.PARAB') AND (USERID <> 'GPUAE\UNNIKRISHNAN.VS') AND (RecUserSetup."Credit Limit Approval" = FALSE) THEN
                                IF SAE19."User ID" <> USERID THEN
                                    ERROR(Text00003);
                            SAE19.MODIFYALL(Cancelled, TRUE);
                            SAE19.MODIFYALL("Cancelled Date", TODAY);
                            SAE19.MODIFYALL("Cancelled Time", TIME);

                        END;

                        Rec.VALIDATE("KYC Approval Status", Rec."KYC Approval Status"::Open);
                        Rec.MODIFY;

                        SRSetup.GET;
                        IF SRSetup."Email Alert On Customer KYC" THEN
                            EmailNotification(5, REC."No.", 3, USERID);
                    END;
                    MESSAGE(Text00004, 'Customer', REC."No.");
                    //RSPLAM29597 -- END
                END;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        MapPointVisible: Boolean;
    begin
        CLEAR(CreditLimtLycVisible);
        CLEAR(MapPointVisible);
        UserSetup.GET(USERID);
        AccessControl1.RESET;
        AccessControl1.SETRANGE("User Name", USERID);
        AccessControl1.SETRANGE("Role ID", 'MARKETING');
        IF AccessControl1.FINDFIRST THEN BEGIN
            Rec.SETRANGE("Salesperson Code", USERID);
        END ELSE
            IF LocationMap.GET(UPPERCASE(USERID), 0) THEN
                Rec.SETFILTER("Responsibility Center", GetResCustFilter);

        //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Customer Form will get Editable ----START
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETRANGE("Role ID", 'CUSTCREATION');
        IF NOT (AccessControl.FINDFIRST) THEN
            CurrPage.EDITABLE(FALSE);
        //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Customer Form will get Editable ------END

        //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Credit Limit Field will Be Visible ----START
        AccessControl2.RESET;
        AccessControl2.SETRANGE("User Name", USERID);
        AccessControl2.SETFILTER("Role ID", '%1|%2', 'SUPER', 'CR LIMIT VISIBLE');
        IF (AccessControl2.FINDFIRST) THEN
            //CurrForm."Credit Limit (LCY)".VISIBLE(FALSE);
            CreditLimtLycVisible := TRUE;
        //EBT STIVAN ---(16072012)--- A new Role has been created,as per the role the Credit Limit Field will Be Visible ------END

        //  {
        //  User.GET(USERID);
        //  IF (User."User ID" = 'CF24') OR (User."User ID" = 'CF09') OR (User."User ID" = 'CF11') OR (User."User ID" = 'CF12') OR
        //  (User."User ID" = 'CF16') OR (User."User ID" = 'CF22') OR (User."User ID" = 'CF29') OR (User."User ID" = 'CF31') OR
        //  (User."User ID" = 'CF32') OR (User."User ID" = 'CF34') OR (User."User ID" = 'CF35') OR (User."User ID" = 'CF36') OR
        //  (User."User ID" = 'CF40') OR (User."User ID" = 'CF41') OR (User."User ID" = 'CF42') OR (User."User ID" = 'CF43') OR
        //  (User."User ID" = 'CF44') OR (User."User ID" = 'CF46') OR (User."User ID" = 'CF47') OR (User."User ID" = 'CF48') OR
        //  (User."User ID" = 'CF49') OR (User."User ID" = 'CF50') OR (User."User ID" = 'CF51') OR (User."User ID" = 'CF52') OR
        //  (User."User ID" = 'CF53') OR (User."User ID" = 'CF55') THEN
        //  ERROR('You are not allowed to View the Customer Card');
        //  }

        //RSPLSUM 28Dec2020>>
        IF UserSetup."Credit Limit Update" THEN
            CreditLimitLCYEditable := TRUE
        ELSE
            CreditLimitLCYEditable := FALSE;
        //RSPLSUM 28Dec2020<<

    end;

    trigger OnClosePage()
    var
        myInt: Integer;
    BEGIN
        Rec.TESTFIELD("Full Name");//02Apr2018

        recDefDim.RESET;
        recDefDim.SETRANGE(recDefDim."Table ID", 18);
        recDefDim.SETRANGE(recDefDim."No.", Rec."No.");
        recDefDim.SETRANGE(recDefDim."Dimension Code", 'CUSTREGION');
        IF recDefDim.FINDFIRST THEN
            IF recDefDim."Dimension Value Code" = '' THEN BEGIN
                ERROR('Please Specify Customer Region Dimension For Customer No. %1', Rec."No.");
            END;

        recDefDim.RESET;
        recDefDim.SETRANGE(recDefDim."Table ID", 18);
        recDefDim.SETRANGE(recDefDim."No.", Rec."No.");
        recDefDim.SETRANGE(recDefDim."Dimension Code", 'DIVISION');
        IF recDefDim.FINDFIRST THEN
            IF recDefDim."Dimension Value Code" = '' THEN BEGIN
                ERROR('Please Specify Division Dimension For Customer No. %1', Rec."No.");
            END;

        recDefDim.RESET;
        recDefDim.SETRANGE(recDefDim."Table ID", 18);
        recDefDim.SETRANGE(recDefDim."No.", Rec."No.");
        recDefDim.SETRANGE(recDefDim."Dimension Code", 'RESPCENTER');
        IF recDefDim.FINDFIRST THEN
            IF recDefDim."Dimension Value Code" = '' THEN BEGIN
                ERROR('Please Specify Resp. Center Dimension For Customer No. %1', Rec."No.");
            END;

        recDefDim.RESET;
        recDefDim.SETRANGE(recDefDim."Table ID", 18);
        recDefDim.SETRANGE(recDefDim."No.", Rec."No.");
        recDefDim.SETRANGE(recDefDim."Dimension Code", 'SALESPERSON');
        IF recDefDim.FINDFIRST THEN
            IF recDefDim."Dimension Value Code" = '' THEN BEGIN
                ERROR('Please Specify SalesPerson Dimension For Customer No. %1', Rec."No.");
            END;

        recDefDim.RESET;
        recDefDim.SETRANGE(recDefDim."Table ID", 18);
        recDefDim.SETRANGE(recDefDim."No.", Rec."No.");
        recDefDim.SETRANGE(recDefDim."Dimension Code", 'EMPHIEAUTO');
        IF recDefDim.FINDFIRST THEN
            IF recDefDim."Dimension Value Code" = '' THEN BEGIN
                ERROR('Please Specify Employee Hierarchy-Automotive Dimension For Customer No. %1', Rec."No.");
            END;

        recDefDim.RESET;
        recDefDim.SETRANGE(recDefDim."Table ID", 18);
        recDefDim.SETRANGE(recDefDim."No.", Rec."No.");
        recDefDim.SETRANGE(recDefDim."Dimension Code", 'AUTODIST');
        IF recDefDim.FINDFIRST THEN
            IF recDefDim."Dimension Value Code" = '' THEN BEGIN
                ERROR('Please Specify Automotive Distributor Dimension For Customer No. %1', Rec."No.");
            END;
    END;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    BEGIN
        Rec.SETRANGE("No.");

        //RSPLSUM 26Aug2020>>
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETRANGE("Role ID", 'CUSTCREATION');
        IF AccessControl.FINDFIRST THEN
            CurrPageEditable := TRUE
        ELSE
            CurrPageEditable := FALSE;
        //RSPLSUM 26Aug2020<<

        //EBT/CrLimit/0001
        IF Rec."Customer Cr. Group" = Rec."Customer Cr. Group"::"Group Customer" THEN BEGIN
            //CurrForm."Consolidated Cr. Limit".EDITABLE := FALSE;
            //CurrForm."Parent Customer".EDITABLE := TRUE;
            ConsolidatedCrLimit := FALSE; //RSPL-TC
            ParentCust := TRUE; //RSPL-TC
        END
        ELSE BEGIN
            //CurrForm."Consolidated Cr. Limit".EDITABLE := TRUE;
            //CurrForm."Parent Customer".EDITABLE := FALSE;
            ConsolidatedCrLimit := TRUE; //RSPL-TC
            ParentCust := FALSE; //RSPL-TC
        END;
        //EBT/CrLimit/0001

        //RSPLSUM 10May2020>>
        IF Rec."Customer Posting Group" <> 'FO' THEN BEGIN
            //            {   ContactEditable := FALSE;
            // InsuranceLimit := FALSE;
            // ManagementLimit := FALSE;
            // TemporaryLimit := FALSE;
            // InsuranceLimitExpDate := FALSE;
            // ManagementLimitExpDate := FALSE;
            // TemporaryLimitExpDate := FALSE;
            // InsurancePercentage := FALSE;
            // ManagementPercentage := FALSE;
            // TemporaryPercentage := FALSE;}
            CreditLimitEditable := FALSE;
            //LegalEdit := FALSE;
        END ELSE
            CreditLimitEditable := TRUE;
        //RSPLSUM 10May2020<<

        //RSPLSUM 28Dec2020>>
        UserSetup.GET(USERID);
        IF UserSetup."Credit Limit Update" THEN
            CreditLimitLCYEditable := TRUE
        ELSE
            CreditLimitLCYEditable := FALSE;
        //RSPLSUM 28Dec2020<<
    END;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    BEGIN
        //RSPLSUM 26Aug2020>>
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETRANGE("Role ID", 'CUSTCREATION');
        IF NOT AccessControl.FINDFIRST THEN
            ERROR('You do not have permission, Please contact system administrator');
        //RSPLSUM 26Aug2020<<
    END;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    BEGIN
        //RSPLSUM 26Aug2020>>
        User.GET(USERID);
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", User."User ID");
        AccessControl.SETRANGE("Role ID", 'CUSTCREATION');
        IF NOT AccessControl.FINDFIRST THEN
            ERROR('You do not have permission, Please contact system administrator');
        //RSPLSUM 26Aug2020<<
    END;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    BEGIN
        //EBT/CNF/0001
        //            {IF Type = Type::Distributor THEN
        // TESTFIELD("Vendor No.");}
        //EBT/CNF/0001

        //RSPLSUM 19Jun2020>>
        IF Rec."Customer Posting Group" = 'FO' THEN BEGIN
            Rec.TESTFIELD("Customer Type");

            Rec.TESTFIELD("Currency Code", 'USD');
        END;
        //RSPLSUM 19Jun2020<<

        //RSPLSUM 01Feb21>>
        IF Rec."No." <> '' THEN BEGIN//RSPLSUM26Mar21
            Rec.TESTFIELD(City);
            Rec.TESTFIELD("GST Customer Type");//RSPLSUM03May21
            IF Rec."GST Customer Type" <> Rec."GST Customer Type"::Export THEN
                Rec.TESTFIELD("Post Code");
        END;//RSPLSUM26Mar21
            //RSPLSUM 01Feb21<<

        // Fahim 01-06-2022

        // IF "No." <> '' THEN BEGIN//RSPLSUM
        //     TESTFIELD(Structure);//14Feb2019
        // END;//RSPLSUM03May21

        //  {IF ("MSME Status" = "MSME Status"::"Micro Industries")
        //  OR ("MSME Status" = "MSME Status"::"Small Scale Industries")
        //  OR ("MSME Status" = "MSME Status"::"Medium Scale Industries") THEN
        //    TESTFIELD("MSME Registration No.");}
        //<<14Feb2019
    END;

    var

        recDefDim: Record 352;
        ConsolidatedCrLimit: Boolean;
        ParentCust: Boolean;
        VenNo: Boolean;
        UserSetup: Record 91;
        AccessControl: Record 2000000053;
        AccessControl2: Record 2000000053;
        AccessControl1: Record 2000000053;
        LocationMap: Record 50029;
        UserMgt: Codeunit 5700;
        User: Record 91;
        CreditLimtLycVisible: Boolean;
        CreditLimitEditable: Boolean;
        Text005: Label 'ENU=%1 Can''t Be Empty';
        TempVersionNo: Integer;
        TempSeqNo: Integer;
        SAE19: Record 50009;
        SalesApproval: Record 50008;
        SalesApprovalEntry: Record 50009;
        SRSetup: Record 311;
        RecUserSetup: Record 91;
        SAE09: Record 50009;
        SAE09_01: Record 50009;
        AppPage: Page 50010;
        CurrPageEditable: Boolean;
        CreditLimitLCYEditable: Boolean;
    //SMTPMailSetup: Record 409;


    procedure GetResCustFilter(): Code[200]
    begin


        LocationMap.RESET;
        IF LocationMap.GET(UPPERCASE(USERID), 0) THEN
            EXIT(LocationMap.Area)
        ELSE
            EXIT('');
    end;

    // PROCEDURE EmailNotification(DocType: Option ,SalesOrder,SalesInvoice,Customer,"Customer OCL","Customer KYC"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]);
    // VAR
    //     SMTPMail: Codeunit 400;
    //     SAE18: Record 50009;
    //     SA18: Record 50008;
    //     SubjectText: Text;
    //     User18: Record 91;
    //     SenderName: Text;
    //     SenderEmail: Text;
    //     ReceiveEmail: Text;
    //     Text18: Text;
    //     Cust18: Record 18;
    //     OtAmt: Decimal;
    //     CrAmt: Decimal;
    // BEGIN

    //     SMTPMailSetup.GET;//RSPLSUM01Apr21

    //     SubjectText := '';
    //     SenderName := '';
    //     SenderEmail := '';
    //     Text18 := '';
    //     //CLEAR(SMTPMail);

    //     //>>SenderID
    //     User18.RESET;
    //     IF User18.GET(SenderID) THEN BEGIN
    //         User18.TESTFIELD("E-Mail");
    //         SenderEmail := User18."E-Mail";
    //         IF User18.Name <> '' THEN
    //             SenderName := User18.Name
    //         ELSE
    //             SenderName := SenderID;
    //     END;
    //     //<<SenderID

    //     IF SeqNo = 1 THEN BEGIN
    //         SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
    //         Text18 := 'Requires Approval.';
    //     END;

    //     //RSPLAM29597 --
    //     IF (SeqNo = 1) AND (DocType = DocType::"Customer KYC") THEN BEGIN
    //         SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
    //         Text18 := 'Requires KYC Approval.';
    //     END;
    //     //RSPLAM29597 ++

    //     IF SeqNo = 2 THEN BEGIN
    //         SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Mail';
    //         Text18 := 'Requires Credit Limit Approval.';
    //     END;

    //     IF SeqNo = 3 THEN BEGIN
    //         SubjectText := 'Microsoft Dynamics NAV: Cancellation Mail';
    //         Text18 := 'Cancellation Mail.';
    //     END;

    //     //RSPLAM29597 --
    //     IF (SeqNo = 3) AND (DocType = DocType::"Customer KYC") THEN BEGIN
    //         SubjectText := 'Microsoft Dynamics NAV: Cancellation Mail';
    //         Text18 := 'Cancellation KYC Mail.';
    //     END;
    //     //RSPLAM29597 ++

    //     IF SeqNo = 4 THEN BEGIN
    //         SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Cancellation Mail';
    //         Text18 := 'Credit Limit Approval Cancellation Mail.';
    //     END;

    //     IF SeqNo = 5 THEN BEGIN
    //         SubjectText := 'Microsoft Dynamics NAV: Credit Limit Self Approval Mail';
    //         Text18 := 'Credit Limit Self Approval Mail.';
    //     END;



    //     //>>ReceiveEmail
    //     ReceiveEmail := '';
    //     SA18.RESET;
    //     IF DocType = 3 THEN//RSPLSUM 26May2020
    //         SA18.SETRANGE("Document Type", SA18."Document Type"::Customer);//RSPLSUM 26May2020
    //     IF DocType = 4 THEN//RSPLSUM 26May2020
    //         SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer OCL");//RSPLSUM 26May2020
    //                                                                              //SA18.SETRANGE("Document Type",DocType);
    //                                                                              //RSPLAM29597 --
    //     IF DocType = 5 THEN
    //         SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer KYC");
    //     //RSPLAM29597 ++
    //     SA18.SETRANGE("User ID", SenderID);
    //     SA18.SETFILTER("Approvar ID", '<>%1', '');
    //     IF SA18.FINDFIRST THEN BEGIN
    //         User18.RESET;
    //         IF User18.GET(SA18."Approvar ID") THEN BEGIN
    //             User18.TESTFIELD("E-Mail");
    //             ReceiveEmail := User18."E-Mail";
    //         END;
    //     END;
    //     //<<ReceiveEmail


    //     //>>Email Body
    //     //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
    //     SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM02Apr21


    //     //>>Other ReceiveEmail
    //     SA18.RESET;
    //     IF DocType = 3 THEN//RSPLSUM 26May2020
    //         SA18.SETRANGE("Document Type", SA18."Document Type"::Customer);//RSPLSUM 26May2020
    //     IF DocType = 4 THEN//RSPLSUM 26May2020
    //         SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer OCL");//RSPLSUM 26May2020
    //                                                                              //SA18.SETRANGE("Document Type",DocType);
    //                                                                              //RSPLAM29597 --
    //     IF DocType = 5 THEN
    //         SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer KYC");
    //     //RSPLAM29597 ++
    //     SA18.SETRANGE("User ID", SenderID);
    //     SA18.SETFILTER("Approvar ID", '<>%1', '');
    //     IF SA18.FINDSET THEN
    //         REPEAT
    //             //>>Approvar Email
    //             User18.RESET;
    //             IF User18.GET(SA18."Approvar ID") THEN BEGIN
    //                 User18.TESTFIELD("E-Mail");
    //                 IF User18."E-Mail" <> ReceiveEmail THEN
    //                     SMTPMail.AddRecipients(User18."E-Mail");
    //             END;

    //             //>>Credit Approvar
    //             User18.RESET;
    //             IF User18.GET(SA18."Credit Approvar ID") THEN BEGIN
    //                 User18.TESTFIELD("E-Mail");
    //                 SMTPMail.AddRecipients(User18."E-Mail");
    //             END;

    //         UNTIL SA18.NEXT = 0;
    //     //<<Other ReceiveEmail

    //     //<<
    //     SMTPMail.AppendBody('<Br>');
    //     SMTPMail.AppendBody('<Br>');
    //     SMTPMail.AppendBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
    //     SMTPMail.AppendBody('<Br>');
    //     SMTPMail.AppendBody('<Br> <B> Customer No.  - </B>' + '<B>' + Rec."No." + '</B>' + ' ' + Text18);
    //     SMTPMail.AppendBody('<Br>');
    //     SMTPMail.AppendBody('<Br>');
    //     SMTPMail.AppendBody('<Table  Border="1">');//Table Start
    //     SMTPMail.AppendBody('<tr>');
    //     SMTPMail.AppendBody('<th>Company Name </th>');
    //     SMTPMail.AppendBody('<td>' + COMPANYNAME + '</td>');
    //     SMTPMail.AppendBody('</tr>');
    //     SMTPMail.AppendBody('<tr>');
    //     SMTPMail.AppendBody('<th>Customer</th>');
    //     SMTPMail.AppendBody('<td>' + Rec."No." + '  ' + Rec.Name + '</td>');
    //     SMTPMail.AppendBody('</tr>');
    //     SMTPMail.AppendBody('</table>');//Table End
    //     SMTPMail.AppendBody('<Br>');
    //     SMTPMail.AppendBody('<Br>');
    //     SMTPMail.Send;
    //     //<<Email Body

    // END;

    PROCEDURE EmailNotification(DocType: Option ,SalesOrder,SalesInvoice,Customer,"Customer OCL","Customer KYC"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]);
    VAR
        //SMTPMail: Codeunit 400;
        SAE18: Record 50009;
        SA18: Record 50008;
        SubjectText: Text;
        User18: Record 91;
        SenderName: Text;
        SenderEmail: Text;
        ReceiveEmail: Text;
        Text18: Text;
        Cust18: Record 18;
        OtAmt: Decimal;
        CrAmt: Decimal;
        EmailMsg: Codeunit "Email Message";
        EmailObj: Codeunit Email;
        RecipientType: Enum "Email Recipient Type";
    BEGIN



        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        Text18 := '';
        //CLEAR(SMTPMail);

        //>>SenderID
        User18.RESET;
        IF User18.GET(SenderID) THEN BEGIN
            User18.TESTFIELD("E-Mail");
            SenderEmail := User18."E-Mail";
            IF User18.Name <> '' THEN
                SenderName := User18.Name
            ELSE
                SenderName := SenderID;
        END;
        //<<SenderID

        IF SeqNo = 1 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            Text18 := 'Requires Approval.';
        END;

        //RSPLAM29597 --
        IF (SeqNo = 1) AND (DocType = DocType::"Customer KYC") THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            Text18 := 'Requires KYC Approval.';
        END;
        //RSPLAM29597 ++

        IF SeqNo = 2 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Mail';
            Text18 := 'Requires Credit Limit Approval.';
        END;

        IF SeqNo = 3 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Cancellation Mail';
            Text18 := 'Cancellation Mail.';
        END;

        //RSPLAM29597 --
        IF (SeqNo = 3) AND (DocType = DocType::"Customer KYC") THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Cancellation Mail';
            Text18 := 'Cancellation KYC Mail.';
        END;
        //RSPLAM29597 ++

        IF SeqNo = 4 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Cancellation Mail';
            Text18 := 'Credit Limit Approval Cancellation Mail.';
        END;

        IF SeqNo = 5 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Self Approval Mail';
            Text18 := 'Credit Limit Self Approval Mail.';
        END;



        //>>ReceiveEmail
        ReceiveEmail := '';
        SA18.RESET;
        IF DocType = 3 THEN//RSPLSUM 26May2020
            SA18.SETRANGE("Document Type", SA18."Document Type"::Customer);//RSPLSUM 26May2020
        IF DocType = 4 THEN//RSPLSUM 26May2020
            SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer OCL");//RSPLSUM 26May2020
                                                                                 //SA18.SETRANGE("Document Type",DocType);
                                                                                 //RSPLAM29597 --
        IF DocType = 5 THEN
            SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer KYC");
        //RSPLAM29597 ++
        SA18.SETRANGE("User ID", SenderID);
        SA18.SETFILTER("Approvar ID", '<>%1', '');
        IF SA18.FINDFIRST THEN BEGIN
            User18.RESET;
            IF User18.GET(SA18."Approvar ID") THEN BEGIN
                User18.TESTFIELD("E-Mail");
                ReceiveEmail := User18."E-Mail";
            END;
        END;
        //<<ReceiveEmail


        //>>Email Body
        //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        //SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM02Apr21
        EmailMsg.Create(ReceiveEmail, SubjectText, '', true);

        //>>Other ReceiveEmail
        SA18.RESET;
        IF DocType = 3 THEN//RSPLSUM 26May2020
            SA18.SETRANGE("Document Type", SA18."Document Type"::Customer);//RSPLSUM 26May2020
        IF DocType = 4 THEN//RSPLSUM 26May2020
            SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer OCL");//RSPLSUM 26May2020
                                                                                 //SA18.SETRANGE("Document Type",DocType);
                                                                                 //RSPLAM29597 --
        IF DocType = 5 THEN
            SA18.SETRANGE("Document Type", SA18."Document Type"::"Customer KYC");
        //RSPLAM29597 ++
        SA18.SETRANGE("User ID", SenderID);
        SA18.SETFILTER("Approvar ID", '<>%1', '');
        IF SA18.FINDSET THEN
            REPEAT
                //>>Approvar Email
                User18.RESET;
                IF User18.GET(SA18."Approvar ID") THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    IF User18."E-Mail" <> ReceiveEmail THEN
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    //SMTPMail.AddRecipients(User18."E-Mail");
                END;

                //>>Credit Approvar
                User18.RESET;
                IF User18.GET(SA18."Credit Approvar ID") THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    //SMTPMail.AddRecipients(User18."E-Mail");
                END;

            UNTIL SA18.NEXT = 0;
        //<<Other ReceiveEmail

        //<<
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br> <B> Customer No.  - </B>' + '<B>' + Rec."No." + '</B>' + ' ' + Text18);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Company Name </th>');
        EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Customer</th>');
        EmailMsg.AppendToBody('<td>' + Rec."No." + '  ' + Rec.Name + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('</table>');//Table End
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');


        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        //SMTPMail.Send;
        //<<Email Body

    END;


    PROCEDURE ModifyCustomer();
    BEGIN
        IF Rec."Approval Status" = Rec."Approval Status"::"Pending For Approval" THEN
            ERROR('Approval status is Pending For Approval. You cannot modify');

        IF Rec."Approval Status" IN [Rec."Approval Status"::Approved, Rec."Approval Status"::Rejected, 0] THEN BEGIN
            Rec."Approval Status" := Rec."Approval Status"::Open;
            Rec."Credit Limit Approval Status" := Rec."Credit Limit Approval Status"::Open;
            // {
            // //>>29Mar2019
            // "Credit Limit Approval Status" := "Credit Limit Approval Status"::Open;
            // "Management Limit" := 0;
            // "Management Limit Exp Date" := 0D;
            // "Management Percentage" := 0;
            // "Insurance Limit" := 0;
            // "Insurance Limit Exp Date" := 0D;
            // "Insurance Percentage" := 0;
            // "Temporary Limit" := 0;
            // "Temporary Limit Exp Date" := 0D;
            // "Temporary Percentage" := 0;
            // //<<29Mar2019
            // }//code Commented 17Apr2019
        END;
    END;

}
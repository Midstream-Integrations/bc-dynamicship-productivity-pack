tableextension 50255 "MID Package Options BOL" extends "DSHIP Package Options"
{
    fields
    {
        field(50255; MID_ThirdParty_Name; Text[50])
        {
            Caption = '3rd Party Name';
            DataClassification = CustomerContent;
        }
        field(50256; MID_ThirdParty_Address; Text[100])
        {
            Caption = '3rd Party Address';
            DataClassification = CustomerContent;
        }
        field(50257; MID_ThirdParty_CityStateZIP; Text[100])
        {
            Caption = '3rd Party City/State/ZIP';
            DataClassification = CustomerContent;
        }
        field(50258; MID_SpecialInstructions; Text[250]) // New field
        {
            Caption = 'Special Instructions';
            DataClassification = CustomerContent;
        }
        field(50259; MID_AdditionalShipperInfo; Text[250]) // New field
        {
            Caption = 'Additional Shipper Information';
            DataClassification = CustomerContent;
        }
    }
}
pageextension 50255 "MID Package Options BOL" extends "DSHIP Package Options Part"
{
    layout
    {
        addlast("Alternate Billing")
        {
            group(MIDThirdPartyGroup)
            {
                ShowCaption = false;

                field(MID_ThirdParty_Name; Rec.MID_ThirdParty_Name)
                {
                    ApplicationArea = All;
                    Caption = '3rd Party Name';
                    ToolTip = 'Specifies the 3rd party shipping name';
                }
                field(MID_ThirdParty_Address; Rec.MID_ThirdParty_Address)
                {
                    ApplicationArea = All;
                    Caption = '3rd Party Address';
                    ToolTip = 'Specifies the 3rd party shipping address';
                }
                field(ThirdParty_City; Rec.MID_ThirdParty_CityStateZIP)
                {
                    ApplicationArea = All;
                    Caption = '3rd Party City/State/ZIP';
                    ToolTip = 'Specifies the 3rd party shipping city/state/zip';
                }
            }
        }

        // New section for Special Instructions
        addlast(Content) // Adds the new section after Alternate Billing
        {
            group(MIDAdditionalInformation)
            {
                ShowCaption = true;
                Caption = 'Additional Information';

                field(MID_SpecialInstructions; Rec.MID_SpecialInstructions)
                {
                    ApplicationArea = All;
                    Caption = 'Special Instructions';
                    ToolTip = 'Specifies any special instructions for third-party billing';
                }
                field(MID_AdditionalShipperInfo; Rec.MID_AdditionalShipperInfo)
                {
                    ApplicationArea = All;
                    Caption = 'Additional Shipper Information';
                    ToolTip = 'Specifies any additional information that the shipper needs to know';
                }
            }
        }
    }
}

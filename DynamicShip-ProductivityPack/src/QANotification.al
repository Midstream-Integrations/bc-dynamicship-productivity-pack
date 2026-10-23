tableextension 50251 "MID Warehouse Setup QA" extends "Warehouse Setup"
{
    fields
    {
        field(50250; "MID QA Inspection Email"; Text[250])
        {
            Caption = 'QA Inspection Email';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
    }
}

tableextension 50256 "MID Location QA" extends Location
{
    fields
    {
        field(50260; "MID QA Inspection Email"; Text[250])
        {
            Caption = 'QA Inspection Email';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
    }
}

pageextension 50256 "MID Location Card QA" extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("MID QA Inspection Email"; Rec."MID QA Inspection Email")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies who is emailed when an order shipping from this location is ready for QA. Leave blank to use the address on Warehouse Setup.';
            }
        }
    }
}

pageextension 50251 "MID Warehouse Setup QA" extends "Warehouse Setup"
{
    layout
    {
        addlast(General)
        {
            field("MID QA Inspection Email"; Rec."MID QA Inspection Email")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies who is emailed when a packer presses Ready for QA on the Package Worksheet, unless the location has its own QA address. Separate several addresses with semicolons.';
            }
        }
    }
}

codeunit 50252 "MID QA Notification"
{
    procedure SendReadyForQA(ShipmentNo: Code[20])
    var
        WarehouseSetup: Record "Warehouse Setup";
        Location: Record Location;
        Recipient: Text;
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        SalesHeader: Record "Sales Header";
        LPHeader: Record "IWX LP Header";
        LPLine: Record "IWX LP Line";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        ItemSerialInfo: Text;
        NoSetupErr: Label 'Set a QA Inspection Email on the location or on Warehouse Setup first.';
        SubjectTxt: Label '%1 is ready for QA inspection', Comment = '%1 = sales order no.';
        BodyTxt: Label 'This order is ready for inspection:<br><br>Sales Order No. - %1<br>Customer Name - %2<br>Customer PO No. - %3<br>Location - %4<br><br>Item No. - %5<br>Item Description - %6<br><br>%7For any order issues, please contact the shipping department.', Comment = '%1..%6 = order details, %7 = license plate item/serial list';
        LPLineTxt: Label 'Item No. - %1<br>Serial No. - %2<br><br>', Comment = '%1 = item no., %2 = serial no.';
        DoneMsg: Label 'QA has been notified:\Sales Order No. - %1\Customer Name - %2\Customer PO No. - %3\Location - %4', Comment = '%1..%4 = order details';
    begin
        WarehouseShipmentLine.SetRange("No.", ShipmentNo);
        if not WarehouseShipmentLine.FindFirst() then
            Error('No shipment lines found for %1.', ShipmentNo);

        // location's own QA address first, then the company-wide one
        if Location.Get(WarehouseShipmentLine."Location Code") then
            Recipient := Location."MID QA Inspection Email";
        if Recipient = '' then
            if WarehouseSetup.Get() then
                Recipient := WarehouseSetup."MID QA Inspection Email";
        if Recipient = '' then
            Error(NoSetupErr);
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseShipmentLine."Source No.") then
            Error('Sales order %1 was not found.', WarehouseShipmentLine."Source No.");

        LPHeader.SetRange("Source No.", ShipmentNo);
        if LPHeader.FindSet() then
            repeat
                LPLine.SetRange("License Plate No.", LPHeader."No.");
                if LPLine.FindSet() then
                    repeat
                        ItemSerialInfo += StrSubstNo(LPLineTxt, LPLine."No.", LPLine."Serial No.");
                    until LPLine.Next() = 0;
            until LPHeader.Next() = 0;

        EmailMsg.Create(Recipient,
            StrSubstNo(SubjectTxt, SalesHeader."No."),
            StrSubstNo(BodyTxt, SalesHeader."No.", SalesHeader."Sell-to Customer Name", SalesHeader."External Document No.",
                SalesHeader."Location Code", WarehouseShipmentLine."Item No.", WarehouseShipmentLine.Description, ItemSerialInfo),
            true);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);

        Message(DoneMsg, SalesHeader."No.", SalesHeader."Sell-to Customer Name", SalesHeader."External Document No.", SalesHeader."Location Code");
    end;
}

permissionset 50250 "MID DSHIP PACK"
{
    Assignable = true;
    Caption = 'Dynamic Ship Productivity Pack';
    IncludedPermissionSets = "Email - Edit";
    Permissions =
        codeunit "MID QA Notification" = X,
        tabledata "Warehouse Setup" = R,
        tabledata Location = R,
        tabledata "Warehouse Shipment Header" = R,
        tabledata "Warehouse Shipment Line" = R,
        tabledata "Sales Header" = R;
}

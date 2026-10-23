pageextension 50250 "MID Package Worksheet" extends "DSHIP Package Worksheet"
{
    layout
    {
        addafter(LocationCode)
        {
            field(MIDSalesOrderNo; GetSalesOrderNo())
            {
                ApplicationArea = All;
                Caption = 'Sales Order No.';
                ToolTip = 'Shows the sales order behind the warehouse shipment being packed.';
            }
            field(MIDExternalDocNo; GetExternalDocumentNo())
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
                ToolTip = 'Shows the External Document No. (customer PO) from the warehouse shipment.';
            }
        }
    }

    actions
    {
        addafter("acCustoms")
        {
            action(MIDOpenPostedSalesShipments)
            {
                ApplicationArea = All;
                Caption = 'Posted Sales Shipments';
                ToolTip = 'Open the list of posted sales shipments.';
                Image = PostedShipment;
                RunObject = page "Posted Sales Shipments";
            }
            action(MIDReadyForQA)
            {
                ApplicationArea = All;
                Caption = 'Ready for QA';
                Image = Email;
                ToolTip = 'Email the QA inspection address (Warehouse Setup) that this order is packed and ready for inspection, with item and serial numbers from its license plates.';

                trigger OnAction()
                var
                    QANotify: Codeunit "MID QA Notification";
                begin
                    QANotify.SendReadyForQA(Rec."Document No.");
                end;
            }
        }
    }

    local procedure GetSalesOrderNo(): Code[20]
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        if Rec."Document No." = '' then
            exit('');
        WarehouseShipmentLine.SetRange("No.", Rec."Document No.");
        WarehouseShipmentLine.SetLoadFields("Source No.");
        if WarehouseShipmentLine.FindFirst() then
            exit(WarehouseShipmentLine."Source No.");
        exit('');
    end;

    local procedure GetExternalDocumentNo(): Text[35]
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
    begin
        if Rec."Document No." = '' then
            exit('');
        if WarehouseShipmentHeader.Get(Rec."Document No.") then
            exit(WarehouseShipmentHeader."External Document No.");
        exit('');
    end;
}

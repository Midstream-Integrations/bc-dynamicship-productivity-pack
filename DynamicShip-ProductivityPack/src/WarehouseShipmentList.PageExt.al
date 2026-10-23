pageextension 50253 "MID Warehouse Shipment List" extends "Warehouse Shipment List"
{
    layout
    {
        addlast(Control1)
        {
            field(MIDSalesOrderNo; GetSalesOrderNo)
            {
                ApplicationArea = All;
                Caption = 'Sales Order No.';
                ToolTip = 'Displays the Sales Order No. based on the Sales Order.';
            }
            field(MIDCustomerName; GetCustomerName)
            {
                ApplicationArea = All;
                Caption = 'Customer Name';
                ToolTip = 'Displays the Customer Name based on the Sales Order.';
            }
            field(MIDExternalDocNo; GetExternalDocumentNo)
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
                ToolTip = 'Displays the External Document No. from the Sales Order.';
            }
        }
    }

    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";

    local procedure GetSalesOrderNo(): Code[20]
    begin
        if WarehouseShipmentHeader.Get(Rec."No.") then begin
            WarehouseShipmentLine.SetRange("No.", Rec."No.");
            if WarehouseShipmentLine.FindFirst() then
                exit(WarehouseShipmentLine."Source No.");
        end;
        exit('');
    end;

    local procedure GetCustomerName(): Text[100]
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        SalesHeader: Record "Sales Header";
        SalesOrderNo: Code[20];
    begin
        // Get the Warehouse Shipment Header
        if WarehouseShipmentHeader.Get(Rec."No.") then begin
            // Find first related line (assuming all lines on this shipment have the same customer)
            WarehouseShipmentLine.SetRange("No.", Rec."No.");
            if WarehouseShipmentLine.FindFirst() then begin
                SalesOrderNo := WarehouseShipmentLine."Source No.";
                // Now get the Sales Header for this Sales Order
                if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo) then
                    exit(SalesHeader."Sell-to Customer Name");
            end;
        end;
        exit('');
    end;

    local procedure GetExternalDocumentNo(): Text[35]
    begin
        if WarehouseShipmentHeader.Get(Rec."No.") then
            exit(WarehouseShipmentHeader."External Document No.");
        exit('');
    end;
}
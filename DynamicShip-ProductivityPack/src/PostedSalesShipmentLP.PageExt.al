pageextension 50254 "MID Posted Sales Shipment LP" extends "Posted Sales Shipment"
{
    actions
    {
        addafter("&Track Package")
        {
            action(MIDOpenLicensePlates)
            {
                Caption = 'View License Plates';
                Image = List;
                ApplicationArea = All;
                ToolTip = 'View License Plates associated with this shipment.';

                trigger OnAction()
                var
                    LicensePlateRec: Record "IWX LP Header";
                begin
                    // Filter the record by the current shipment number
                    LicensePlateRec.SetRange("Shipment No.", Rec."No.");

                    // Run the page using the filtered record
                    PAGE.Run(PAGE::"IWX License Plate List", LicensePlateRec);
                end;
            }
        }
    }
}

# Dynamic Ship Productivity Pack

![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg) ![Business Central 25+](https://img.shields.io/badge/Business%20Central-25%2B-0B7E8A) ![AL](https://img.shields.io/badge/language-AL-5C2D91)

**For Insight Works Dynamic Ship: fewer clicks for packers and shipping clerks.**

<!-- DEMO: record a 30-60 second screen capture, save it as docs/images/demo.gif, then replace this comment with:
![Demo](docs/images/demo.gif) -->

> **Free and open source.** Want it installed, hosted or changed to fit your process? [Midstream Integrations](https://www.MidstreamIntegrations.com) does that. [Book a 20-minute call](https://midstreamintegrations.com/contact).

## What it does

- **Package Worksheet:** Sales Order No. and External Document No. (customer PO) columns, a **Posted Sales Shipments** shortcut, and a **Ready for QA** button. The button emails QA the order, customer, PO, location, and the item and serial numbers from the order's license plates.
- **Warehouse Shipments list:** Sales Order No., Customer Name and External Document No. columns.
- **Posted Sales Shipment:** **View License Plates** action.
- **Package Options:** third-party bill-to name, address and city/state/ZIP, plus **Special Instructions** and **Additional Shipper Information**, for your BOL layout.

## Setup

1. Set the **QA Inspection Email** on **Warehouse Setup** (company-wide), and optionally on a **Location Card** to send that location's orders somewhere else.
2. Assign `MID DSHIP PACK` to packers.
3. To print the third-party and instruction fields, add them to your Bill of Lading layout.

## Install

**From a release (no build tools needed)**
1. Download the `.app` file from the latest [release](../../releases).
2. In Business Central, open **Extension Management** → **Manage** → **Upload Extension** and select the file.
3. Assign the permission set listed below to the people who use it.

**From source**
1. Clone this repo and open `DynamicShip-ProductivityPack` in VS Code with the [AL Language extension](https://marketplace.visualstudio.com/items?itemName=ms-dynamics-smb.al).
2. Put your sandbox name and tenant ID in `.vscode/launch.json`, then run **AL: Download Symbols**.
3. Press **F5** to publish to your sandbox.

Always test in a sandbox before you install in production.

## Technical details

| | |
|---|---|
| Object ID range | 50250–50279 |
| Object prefix | `MID` |
| Dependencies | Insight Works Dynamic Ship: Integrated Shipping, IWorks Common |
| Permission set(s) | `MID DSHIP PACK` |
| Business Central | Online, version 25 or later |

## Need help, or something this doesn't do?

[Midstream Integrations](https://www.MidstreamIntegrations.com) builds and supports Business Central extensions and integrations. We can:

- install and set up this app in your tenant and show your team how to use it
- change it to fit your process: fields, reports, layouts, approval rules
- build the integration you actually need: APIs, EDI, OCR, Python services, and connections between Business Central and the other systems you run

**[Book a 20-minute call](https://midstreamintegrations.com/contact)** · intro@MidstreamIntegrations.com

## Contributing

Issues and pull requests are welcome; see [CONTRIBUTING](https://github.com/Midstream-Integrations/.github/blob/main/CONTRIBUTING.md).
Found a security problem? Please follow the [security policy](https://github.com/Midstream-Integrations/.github/blob/main/SECURITY.md) instead of opening a public issue.

## License

[MIT](LICENSE) © Midstream Integrations

# Accounts Payable (AP) - Capabilities

## 1. Domain Purpose
The Accounts Payable (AP) domain is responsible for managing the money Kalles Buss owes to its suppliers (e.g., energy providers, depot landlords, vehicle maintenance). It handles invoice ingestion, authorization, and payment scheduling.

## 2. Core Capabilities

### 2.1 Invoice Ingestion & Digitization
*   Listens to `SupplierInvoiceReceived` events (often triggered by an Inbound Invoicing Gateway that digitizes PDFs or receives Peppol XMLs).
*   Registers the invoice against a known `Supplier` profile.

### 2.2 Automated 3-Way Matching (Level 1 Automation)
*   **The Golden Rule:** Automatically matches the `Supplier Invoice` against an approved `Purchase Order (PO)` and a `Goods/Service Receipt`.
*   If Amount, Quantity, and Supplier match perfectly within a defined tolerance (e.g., < 1% variance), the invoice is automatically marked as `Approved for Payment`.

### 2.3 Payment Scheduling & Execution
*   Monitors `Approved` invoices and their `due_date`.
*   Based on instructions from the `Treasury` domain (cash flow optimization), AP generates a `PaymentInstruction` event.
*   This event is published to the event bus for the `Bank Gateway` to pick up and transmit to Bankgirot.

### 2.4 Payment Reconciliation
*   Listens to `BankgirotPaymentAcknowledged` events from the Bank Gateway to confirm that the money actually left our account, transitioning the invoice to `Paid`.

## 3. The A-A-H Escalation Model in AP

### Level 1: Straight-Through Automation
*   **Scenario:** E.ON sends an e-invoice for depot electricity that matches the projected consumption PO exactly.
*   **Action:** AP automatically approves the invoice and schedules the payment instruction for the due date.

### Level 2: AI Agent Resolution
*   **Scenario:** A maintenance invoice from a mechanic arrives. It matches the PO, but includes an unexpected 500 SEK "environmental disposal fee" that wasn't on the PO.
*   **Action:** The AP Agent reads the supplier contract from the database, confirms that environmental fees are standard valid additions for this supplier, and auto-approves the variance without bothering a human.

### Level 3: Human-in-the-Loop
*   **Scenario:** An invoice arrives from a completely unknown vendor, or an invoice from a known vendor is 300% higher than the PO.
*   **Action:** The system halts. It routes the invoice to the CFO or the responsible Domain Manager (e.g., the Fleet Manager) for manual inspection, potential fraud detection, and manual attestation.
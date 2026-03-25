# Accounts Receivable (AR) - Data Model & Flows

## 1. Internal Data Model (State)

While inspired by Odoo/ERPNext, this model is streamlined for an event-driven architecture.

### Entity: `CustomerAccount`
*   `customer_id` (UUID) - e.g., SL
*   `name` (String)
*   `billing_currency` (String) - e.g., SEK
*   `payment_terms_days` (Int) - e.g., 30
*   `current_balance` (Decimal)

### Entity: `Claim` (Underlag)
*   `claim_id` (UUID)
*   `customer_id` (UUID)
*   `source_domain` (String) - e.g., 'traffic', 'sla-engine'
*   `description` (String) - e.g., "Route 676, Bus 12, 2026-03-24"
*   `amount` (Decimal)
*   `status` (Enum: Pending, Invoiced, Disputed, Voided)

### Entity: `Invoice`
*   `invoice_id` (UUID)
*   `invoice_number` (String) - e.g., "KB-2026-001" (Generated on finalization)
*   `customer_id` (UUID)
*   `issue_date` (Date)
*   `due_date` (Date)
*   `line_items` (List[Claim])
*   `total_amount` (Decimal)
*   `ocr_reference` (String)
*   `status` (Enum: Draft, Finalized, Sent, Paid, Overdue)

## 2. Information Flow (Outbound Revenue)

```mermaid
sequenceDiagram
    participant Billing Engine
    participant AR (Accounts Receivable)
    participant Event Bus
    participant GL (General Ledger)
    participant Invoicing Gateway

    Billing Engine->>Event Bus: Publish `ClaimCalculated` (e.g., 1500 SEK for Route)
    Event Bus->>AR: Consume Claim
    AR->>AR: Store Claim (Status: Pending)
    
    Note over AR: End of Month Trigger
    AR->>AR: Aggregate Claims into `Draft Invoice`
    AR->>AR: A-A-H check (Anomaly detection)
    AR->>AR: Finalize Invoice & Generate OCR
    
    AR->>Event Bus: Publish `InvoiceFinalized` (Internal JSON)
    Event Bus->>GL: Consume (Book Accounts Receivable Debit)
    Event Bus->>Invoicing Gateway: Consume (Begin delivery process)
```
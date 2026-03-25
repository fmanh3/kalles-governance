# General Ledger (GL) - Data Model & Flows

## 1. Internal Data Model (State)

### Entity: `ChartOfAccounts` (Kontoplan)
*   `account_id` (String) - e.g., "1930" (Bank), "1510" (AR), "3000" (Revenue)
*   `name` (String)
*   `account_type` (Enum: Asset, Liability, Equity, Revenue, Expense)
*   `vat_code` (String, Optional)

### Entity: `AccountingPeriod`
*   `period_id` (UUID)
*   `start_date` (Date)
*   `end_date` (Date)
*   `status` (Enum: Open, Closed)

### Entity: `JournalEntry` (Verifikat)
*   `entry_id` (UUID)
*   `source_event_id` (UUID) - Link to the event that caused this entry (Traceability).
*   `source_domain` (String) - e.g., 'AR', 'AP'
*   `booking_date` (Date)
*   `description` (String)
*   `lines` (List[JournalLine])
*   `status` (Enum: Draft, Posted)

### Entity: `JournalLine`
*   `line_id` (UUID)
*   `account_id` (String)
*   `amount` (Decimal) - Positive for Debit, Negative for Credit.
*   `dimension_cost_center` (String, Optional) - e.g., "Depot_Norrtälje"
*   `dimension_vehicle` (String, Optional) - e.g., "Bus_104"

## 2. Information Flow (Event to Ledger)

```mermaid
sequenceDiagram
    participant AR (Accounts Receivable)
    participant Event Bus
    participant GL (General Ledger)
    participant Tax Reporting (Skatteverket)

    AR->>Event Bus: Publish `InvoiceFinalized` (1250 SEK, 25% VAT)
    Event Bus->>GL: Consume Event
    
    GL->>GL: Validate Accounting Period (Must be Open)
    GL->>GL: Map to Chart of Accounts (Level 1 Auto)
    
    Note over GL: Create JournalEntry<br>Debit 1510 (AR): 1250<br>Credit 3000 (Rev): 1000<br>Credit 2611 (VAT): 250
    
    GL->>GL: Commit JournalEntry (Immutable)
    
    Note over GL: End of Month
    GL->>Tax Reporting: Generate SIE-file / VAT Return
```
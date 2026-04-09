# Accounts Receivable - Data Model

## 1. Domain Entities

### Entity: `ReceivableAccount`
*   `customer_id`: String
*   `total_outstanding`: Decimal
*   `last_payment_date`: DateTime

## 2. Integration with Ledger
Every status change in a receivable (e.g., from PENDING to PAID) must trigger a corresponding Ledger Entry (Debit 1930 / Kredit 1510).

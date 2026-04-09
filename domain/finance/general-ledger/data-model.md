# General Ledger - Data Model

## 1. Internal State

### Entity: `LedgerEntry`
*   `id`: UUID
*   `transaction_date`: DateTime
*   `account_code`: String (e.g., "1930", "1510", "3000")
*   `description`: String
*   `debit`: Decimal
*   `credit`: Decimal
*   `invoice_id`: UUID (Optional reference)

## 2. Standard Chart of Accounts (Swedish BAS)
*   **1510:** Kundreskontra
*   **1930:** Företagskonto (Bank)
*   **2611:** Utgående moms (6%)
*   **2641:** Ingående moms (25%)
*   **3000:** Försäljning

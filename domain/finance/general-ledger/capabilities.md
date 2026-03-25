# General Ledger (GL) - Capabilities

## 1. Domain Purpose
The General Ledger (Huvudbok) is the immutable, cryptographically secure source of truth for Kalles Buss. It does not initiate transactions; it strictly observes the event bus and records the financial impact (double-entry bookkeeping) of activities happening in AR, AP, Payroll, and Treasury.

## 2. Core Capabilities

### 2.1 Event-Driven Bookkeeping
*   **Listen & Record:** Listens to financial state changes across the platform (e.g., `InvoiceFinalized`, `BankTransactionReceived`, `PayrollCalculated`).
*   **Double-Entry Engine:** Translates domain events into standardized Debits and Credits against the Chart of Accounts (Kontoplan - e.g., BAS-kontoplan in Sweden).
*   **Immutability:** Once a journal entry is committed, it cannot be altered. Corrections must be made via a new reversing journal entry.

### 2.2 Period Close & Consolidation
*   **Automated Month-End:** Automatically calculates depreciation, accruals (periodiseringar), and currency revaluations on the last day of the month.
*   **Locking:** Locks accounting periods to prevent backdated entries after the tax reporting deadline.

### 2.3 Tax & Compliance Reporting
*   Generates statutory reports (e.g., Momsdeklaration/VAT return, SIE-files for the Swedish Tax Agency / Skatteverket).
*   Maintains the `CompanyProfile` master data (Kalles Buss AB's legal entity details, OrgNo, active fiscal years).

## 3. The A-A-H Escalation Model in GL

### Level 1: Straight-Through Automation
*   **Scenario:** AR publishes `InvoiceFinalized` for 1000 SEK.
*   **Action:** GL automatically credits "Sales Revenue" (Konto 3000) for 800 SEK, credits "Outgoing VAT" (Konto 2611) for 200 SEK, and debits "Accounts Receivable" (Konto 1510) for 1000 SEK.

### Level 2: AI Agent Resolution
*   **Scenario:** An employee submits a complex travel expense receipt in a foreign currency via the AP domain. The standard rule engine isn't sure which specific expense account to use.
*   **Action:** The GL Classification Agent analyzes the receipt description, historical patterns, and Swedish tax deductibility rules to suggest the correct "Konto" and VAT code, automatically creating the journal entry.

### Level 3: Human-in-the-Loop
*   **Scenario:** The automated month-end reconciliation detects that the balance in the GL's Bank Account ledger does not match the actual balance reported by the `Bank Gateway` for the same date (a reconciliation fracture).
*   **Action:** The system halts the month-end close. A high-priority alert is sent to the Financial Controller to manually investigate the discrepancy before the books are locked.
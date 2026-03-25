# Accounts Receivable (AR) - Capabilities

## 1. Domain Purpose
The Accounts Receivable (AR) domain is responsible for managing the money owed to Kalles Buss by its customers (primarily SL). It acts as the financial state machine for incoming revenue, completely decoupled from how invoices are physically formatted or delivered.

## 2. Core Capabilities

### 2.1 Claim Aggregation & Invoice Generation
*   **Listen & Accumulate:** Listens to `ClaimCalculated` events from the `Billing Engine` (e.g., "Driven 150km on route 676", "Penalty for 5 min delay").
*   **Drafting:** Automatically aggregates claims into a `Draft Invoice` based on customer billing cycles (e.g., end of month).
*   **Finalization:** Transitions a Draft Invoice to `Finalized`, locking it from further changes.

### 2.2 Automated Reconciliation (Payment Matching)
*   **Listen for Payments:** Listens to `BankTransactionReceived` events from the `Bank Gateway`.
*   **Matching Engine (Level 1):** Automatically matches incoming funds to open invoices based on OCR numbers, exact amounts, or invoice references.
*   **State Update:** Closes the invoice (`Status: Paid`) and publishes an `InvoiceReconciled` event for the General Ledger.

### 2.3 Automated Dunning (Kravhantering)
*   Monitors invoice due dates.
*   Automatically generates "Payment Reminder" events if an invoice is overdue, escalating the collection process without human intervention.

## 3. The A-A-H Escalation Model in AR

### Level 1: Straight-Through Automation
*   **Scenario:** Standard monthly invoice generation for SL. 
*   **Action:** Claims are summed up, invoice generated, approved, and handed off to the Invoicing Gateway completely automatically. Payment matching succeeds on exact OCR match.

### Level 2: AI Agent Resolution
*   **Scenario A (Disputed Claim):** SL disputes a specific delay penalty via a webhook/API. The AI Agent analyzes the GPS/Traffic logs for that specific route and cross-references the SL contract to either accept the dispute (issue partial credit note) or reject it with evidence.
*   **Scenario B (Fuzzy Matching):** A payment arrives via Bank Gateway missing the OCR number, but the amount is off by 5 SEK due to bank fees. The AI Agent uses fuzzy logic (matching customer name, approximate date, and amount) to propose a reconciliation.

### Level 3: Human-in-the-Loop
*   **Scenario:** A massive anomaly is detected (e.g., the aggregated monthly invoice is 40% lower than the historical average, or SL defaults on a multi-million SEK payment).
*   **Action:** The system halts the invoice finalization or payment write-off and alerts the CFO/Human operator for manual review and override.
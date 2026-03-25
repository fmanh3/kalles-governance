# Bank Gateway (Bankgirot Integration) - Capabilities

## 1. Domain Purpose
The Bank Gateway acts as the Anti-Corruption Layer (ACL) between Kalles Buss internal financial events and the external Swedish banking infrastructure, specifically **Bankgirot**. It translates internal standardized JSON events into Bankgirot API payloads/files (inbetalningar, utbetalningar, återrapportering) and vice versa.

## 2. Core Capabilities

### 2.1 Outbound Payments (Utbetalningar)
*   **Listen:** Consumes `PaymentInstructionCreated` events from Accounts Payable or Payroll.
*   **Translate & Batch:** Converts the internal instructions into Bankgirot's required format. Historically this was the LB-format (Leverantörsbetalningar), but via modern APIs, this translates to ISO 20022 `pain.001` or Bankgirot's specific JSON API payloads.
*   **Transmit:** Securely authenticates (e.g., via mutual TLS or BankID signing) and transmits the payment orders to Bankgirot specifying the execution date, target Bankgiro, amount, and OCR.

### 2.2 Inbound Receivables (Inbetalningar)
*   **Poll/Listen:** Continuously polls the Bankgirot API for incoming customer payments (previously BGMax files, now often `camt.054` or API arrays).
*   **Normalize:** Extracts the crucial data points: `Sender_Bankgiro`, `Amount`, `Payment_Date`, and `OCR_Reference` (or free-text reference).
*   **Publish:** Translates the Bankgirot payload into a canonical internal `BankTransactionReceived` event and broadcasts it on the event bus for `Accounts Receivable` to consume and match.

### 2.3 Reconciliation Feedback (Återrapportering)
*   Fetches the daily confirmation from Bankgirot detailing which outbound payments were successfully withdrawn from Kalles Buss's account and delivered to the suppliers.
*   Publishes `BankgirotPaymentAcknowledged` or `BankgirotPaymentFailed` events.

## 3. The A-A-H Escalation Model in Bank Gateway

### Level 1: Straight-Through Automation
*   **Scenario:** Daily polling of Bankgirot API retrieves 50 incoming payments. The Gateway parses the JSON/XML flawlessly, extracting 50 valid OCR numbers and amounts, and publishes 50 `BankTransactionReceived` events.
*   **Action:** 100% automated translation.

### Level 2: AI Agent Resolution
*   **Scenario:** Bankgirot's API returns a payload where a customer paid without an OCR, using a free-text field instead (e.g., "Faktura 123 SL"). The strict regex parser fails.
*   **Action:** The Gateway Agent intercepts the parsing error. It uses an LLM to extract the intent from the free-text field ("Faktura 123"), structures it into the canonical `BankTransactionReceived` event, flags it with `confidence_score: 0.85`, and sends it to AR.

### Level 3: Human-in-the-Loop
*   **Scenario:** The Bankgirot API is down, or the TLS certificate used for mutual authentication expires, completely halting the flow of money.
*   **Action:** The system raises a P1 Incident. A human platform engineer must rotate the certificates or manually download/upload BGMax/LB files via the bank's internet portal until the API is restored.
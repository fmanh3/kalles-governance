# Invoicing Gateway - Capabilities

## 1. Domain Purpose
The Invoicing Gateway is an Anti-Corruption Layer (ACL) and delivery mechanism. It ensures that the core `Accounts Receivable` (AR) domain never needs to know about XML schemas, Peppol networks, PDF generation, or EDI protocols. It handles the "messy reality" of external communication.

## 2. Core Capabilities

### 2.1 Format Translation (Transformation)
*   Listens to internal canonical `InvoiceFinalized` events.
*   Maps the internal JSON structure to the required external format based on the customer's preferred delivery method (e.g., Peppol BIS Billing 3.0 / Svefaktura / PDF / E-mail).

### 2.2 Secure Delivery
*   Handles the physical transmission of the invoice via external APIs (e.g., integrating with an Access Point provider for Peppol, or an SMTP server for PDF delivery).
*   Manages retry logic, backoffs, and circuit breakers if external delivery networks are down.

### 2.3 Delivery Tracking & Acknowledgement
*   Monitors delivery receipts (Message Disposition Notifications - MDN).
*   Publishes success or failure events back to the internal event bus, allowing AR or Agents to react if an invoice cannot be delivered.

## 3. The A-A-H Escalation Model in Invoicing Gateway

### Level 1: Straight-Through Automation
*   **Scenario:** A standard `InvoiceFinalized` event is received. The gateway maps it flawlessly to Peppol XML, transmits it, and receives a synchronous HTTP 200 OK and a positive MDN.
*   **Action:** The gateway publishes `InvoiceDelivered`. Zero human interaction.

### Level 2: AI Agent Resolution
*   **Scenario:** The external Peppol validation API rejects the XML because a required SL reference code (e.g., "Order Number") is in the wrong format or missing a prefix.
*   **Action:** The Invoicing Agent intercepts the `DeliveryFailed` exception. The agent reads the error message, uses historical context to identify the correct formatting rule for SL, patches the XML structure on the fly, and re-submits the payload.

### Level 3: Human-in-the-Loop
*   **Scenario:** The delivery fails repeatedly because SL's corporate identity number (Orgnr) has changed in the registry, or the Peppol ID is fundamentally invalid.
*   **Action:** The agent creates a critical alert ticket. A human operator must verify the new legal entity details with SL, update the Master Data, and click "Retry".
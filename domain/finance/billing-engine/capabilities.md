# Billing & Rating Engine - Capabilities

## 1. Domain Purpose
The Billing Engine (often called a Rating Engine in telecom/transport) is the core commercial heart of Kalles Buss. It bridges the physical world of operations with the financial world. It translates raw, operational events (kilometers driven, delays, passenger counts) into monetary values based on complex, customer-specific contracts (e.g., SL, Västtrafik, Skånetrafiken).

## 2. Core Capabilities

### 2.1 Contract & Tariff Management
*   Maintains a repository of active `CustomerContracts`.
*   A contract contains multiple `TariffRules` (e.g., Base route payout, per-kilometer rate, electric vs. diesel bus rates) and `SLARules` (Service Level Agreements, e.g., punctuality penalties, cleanliness bonuses).

### 2.2 Event Rating (The Calculation Engine)
*   **Listen:** Consumes operational events from the `Traffic` and `Telemetry` domains (e.g., `RouteCompleted`, `BusArrivedAtStop`).
*   **Evaluate:** Passes the event data through the active contract's Tariff and SLA rules.
*   **Generate:** Produces a priced `Claim` (e.g., +1500 SEK for route completion, -200 SEK for being 4 minutes late).
*   **Publish:** Sends the calculated `ClaimCalculated` event to the `Accounts Receivable (AR)` domain for aggregation into the monthly invoice.

### 2.3 Dispute Evidence Gathering
*   When a claim is generated (especially a penalty), the engine cryptographically binds the raw telemetry data (GPS coordinates, timestamps) to the claim. This ensures automated evidence exists if the customer disputes the invoice later.

## 3. The A-A-H Escalation Model in Billing

### Level 1: Straight-Through Automation
*   **Scenario:** A bus completes Route 676 on time. The telemetry matches the planned schedule perfectly.
*   **Action:** The engine applies the "Standard Route Tariff", generates a positive claim, and sends it to AR. Zero human touch.

### Level 2: AI Agent Resolution
*   **Scenario:** A bus arrives 15 minutes late. The Level 1 engine automatically applies a 5000 SEK SLA penalty. However, the `Traffic` domain published a `ForceMajeureEvent` (e.g., a major accident closed the highway, verified by external traffic APIs).
*   **Action:** The Billing Agent intercepts the penalty. It cross-references the SLA contract's "Force Majeure" clause, determines the delay was outside Kalles Buss's control, voids the penalty claim, and logs the justification.

### Level 3: Human-in-the-Loop
*   **Scenario:** A new contract with a regional transit authority introduces a highly complex, tiered profit-sharing model based on passenger satisfaction scores (which are unstructured text).
*   **Action:** The rules engine cannot parse this reliably. The system routes the raw survey data to the Commercial Manager to manually assess and input the monthly bonus claim until a specific Level 2 agent is trained for this contract.
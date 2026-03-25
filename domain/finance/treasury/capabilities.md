# Treasury & Liquidity - Capabilities

## 1. Domain Purpose
The Treasury domain is an advanced, forward-looking AI Agent system. While the General Ledger looks at the *past* and AR/AP look at the *present*, Treasury looks at the *future*. It forecasts cash flow, manages liquidity risk, and optimizes the timing of supplier payments to maximize capital efficiency.

## 2. Core Capabilities

### 2.1 Cash Flow Forecasting
*   **Predictive Modeling:** Consumes open invoices from AR (expected inflows), approved POs/Invoices from AP (expected outflows), and historical payroll data.
*   **Real-time Balances:** Monitors current bank balances via the Bank Gateway.
*   **Output:** Generates a rolling 30/60/90-day liquidity forecast.

### 2.2 Payment Timing Optimization (Yield Management)
*   **Strategic Delay:** Intercepts `Approved` invoices in the AP domain. Instead of paying them immediately, the Treasury Agent calculates the absolute latest date the payment can be sent to Bankgirot without incurring late fees, maximizing the interest earned on cash held in Kalles Buss's accounts.
*   **Early Payment Discounts:** If a supplier offers a 2% discount for paying within 10 days, the Treasury Agent evaluates the Cost of Capital. If the discount yield is higher than the bank interest rate, it instructs AP to pay early.

### 2.3 Currency & Fuel Hedging
*   If Kalles Buss buys parts or fuel internationally, the Treasury agent monitors exchange rates and fuel indices, suggesting or executing automated hedging contracts to stabilize operating costs.

## 3. The A-A-H Escalation Model in Treasury

### Level 1: Straight-Through Automation
*   **Scenario:** Standard AP invoice approved.
*   **Action:** Treasury algorithm automatically sets the `execution_date` to `Due_Date - 1 day` (to allow Bankgirot processing time) and releases it.

### Level 2: AI Agent Resolution
*   **Scenario:** The cash flow forecast predicts a liquidity shortfall (negative balance) in 14 days because SL's monthly payment falls on a weekend, delaying inflow, while major supplier payments are due on Friday.
*   **Action:** The Treasury Agent automatically identifies non-critical supplier invoices (e.g., consulting fees) and dynamically delays their payment instruction by 3 days. It generates an internal report explaining the automated re-balancing.

### Level 3: Human-in-the-Loop
*   **Scenario:** The liquidity shortfall cannot be resolved by delaying payments without breaching contracts, or a major fuel hedge contract needs to be signed.
*   **Action:** The agent raises a "Liquidity Crisis Warning". The CFO must manually approve drawing from the corporate credit line (Checkkredit) or negotiate an extension with suppliers.
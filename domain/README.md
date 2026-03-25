# Kalles Buss: Domain Architecture & Evolution Model

## 1. Overview
This directory contains the specifications for all bounded contexts within the Kalles Buss "Transport-as-Code" platform. Unlike traditional ERP systems, these domains are designed for **maximum autonomous throughput**.

## 2. The Agent Escalation Model (A-A-H)
All domain services and agents must implement the following three-tier resolution hierarchy:

1.  **Level 1: Straight-Through Automation (Rule-Based):** 
    - The standard flow. If all information is present and satisfies business rules (e.g., matching an invoice to a purchase order), the transaction is processed without any human or AI intervention.
2.  **Level 2: AI Agent Resolution (Context-Aware):** 
    - If automation fails (e.g., a missing field, an OCR error, or a minor discrepancy), the task is escalated to a specialized Domain Agent. The agent attempts to resolve the issue using its knowledge of the policy-as-code and historical context.
3.  **Level 3: Human-in-the-Loop (Exception Handling):** 
    - If the AI Agent's confidence score is below the threshold or the transaction violates a critical safety/financial guardrail, the task is presented to a human for final approval. The human's decision is then captured as training data to improve the Level 2 agent.

## 3. Financial Domains Structure

### 3.1 Core Billing & Rating (`billing-engine/`)
- **Responsibility:** Translating operational transport events (km, SLAs, viten) into financial claims.
- **Key Interface:** `Trafik` domain -> `Billing` -> `Accounts Receivable`.

### 3.2 Payroll Calculation (`payroll-engine/`)
- **Responsibility:** Translating driver shift events and rest-time violations into compensation and deductions.
- **Key Interface:** `HR/Personal` domain -> `Payroll` -> `Accounts Payable`.

### 3.3 Accounts Receivable (`accounts-receivable/`)
- **Responsibility:** Managing customer (SL) debt, payment matching, and automated dunning.
- **Focus:** Automated reconciliation of bank statements against open claims.

### 3.4 Accounts Payable (`accounts-payable/`)
- **Responsibility:** Managing supplier debt (energy, maintenance, depot rent).
- **Focus:** Automated three-way matching (Invoice vs. PO vs. Delivery).

### 3.5 General Ledger (`general-ledger/`)
- **Responsibility:** The immutable double-entry truth.
- **Focus:** Real-time bookkeeping derived from event-bus transactions.

### 3.6 Treasury & Liquidity (`treasury/`)
- **Responsibility:** Cash flow forecasting and payment optimization.
- **Focus:** Strategic agents managing bank balances and payment timing.

### 3.7 Bank Gateway (`bank-gateway/`)
- **Responsibility:** Integration with banking APIs (ISO 20022).
- **Focus:** Normalizing CAMT/PAIN messages into Kalles Buss internal events.

### 3.8 Invoicing Gateway (`invoicing-gateway/`)
- **Responsibility:** Format normalization (Peppol, EDI, PDF).
- **Focus:** Handling the messy reality of external communication formats without polluting internal logic.

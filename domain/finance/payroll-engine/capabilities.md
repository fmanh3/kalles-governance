# Payroll Engine - Capabilities

## 1. Domain Purpose
The Payroll Engine calculates compensation for the Kalles Buss workforce. It acts as an intelligent rules engine that translates raw attendance and operational events into legally compliant financial payouts, strictly adhering to the Swedish Working Hours Act (ATL) and union agreements (e.g., Kommunals Bussbranschavtal).

## 2. Core Capabilities

### 2.1 Time & Attendance Evaluation
*   **Listen:** Consumes raw events from the `HR/Personal` domain (e.g., `ShiftStarted`, `ShiftEnded`, `BreakTaken`).
*   **Normalize:** Cleans up "dirty" time punches (e.g., driver forgets to clock out, agent infers clock-out from the bus telematics shutting down).

### 2.2 Union Rule Execution (Bussbranschavtalet)
*   Applies a complex matrix of collective agreement rules to the normalized time data:
    *   **OB-tillägg (Unsocial Hours):** Automatically calculates premium pay for evenings, nights, and weekends based on exact minute intervals.
    *   **Delad Tjänst (Split Shifts):** Automatically applies the mandatory monetary compensation if a driver has a split shift with an unpaid gap in the middle.
    *   **Övertid (Overtime):** Calculates daily and weekly overtime thresholds.

### 2.3 Deduction & Leave Management
*   Processes events regarding sick leave (Sjuklön med karensavdrag), parental leave, or vacation, applying the correct statutory deduction formulas.

### 2.4 Payout Generation
*   Aggregates the daily calculations into a monthly `PayrollClaim`.
*   Publishes `PayrollApproved` events to `Accounts Payable` (for the net salary payout to the employee) and to the `General Ledger` (for booking employer taxes/arbetsgivaravgifter).

## 3. The A-A-H Escalation Model in Payroll

### Level 1: Straight-Through Automation
*   **Scenario:** A driver works a standard scheduled shift, clocks in and out on time via the bus edge device.
*   **Action:** The engine calculates standard hourly pay + standard afternoon OB-tillägg. The day is marked "Ready for Payroll" instantly.

### Level 2: AI Agent Resolution
*   **Scenario:** A driver clocks out 45 minutes late due to a breakdown. The raw time punch contradicts the planned schedule.
*   **Action:** The Payroll Agent cross-references the `Traffic` domain for incident reports. Finding a `BusBreakdown` event matching that driver's vehicle, the Agent automatically classifies the extra 45 minutes as "Kvalificerad Övertid" (Qualified Overtime) rather than standard time, saving HR from manual investigation.

### Level 3: Human-in-the-Loop
*   **Scenario:** A driver disputes their paycheck, claiming they were promised a special "hazard bonus" by a dispatcher for driving a dangerous route during a severe snowstorm, which isn't in the standard union matrix.
*   **Action:** The engine flags the anomaly. An HR/Payroll specialist must manually review the dispatcher's logs, negotiate with the union representative if necessary, and manually insert a one-off `BonusClaim` into the system.
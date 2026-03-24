# Policy: Daily Rest (Dygnsvila) & Driver Scheduling Constraints

## 1. Legal & Regulatory Foundation
This policy codifies the hard constraints for driver scheduling and workforce management within the Kalles Buss platform. The autonomous scheduling agents and HR systems must operate strictly within the bounds of:
*   **EU Regulation (EC) No 561/2006:** European rules on driving times, breaks, and rest periods.
*   **Arbetstidslagen (ATL):** The Swedish Working Hours Act.
*   **Bussbranschavtalet:** The collective union agreement (Kommunal / Sveriges Bussföretag).

The goal of this policy is to ensure absolute driver safety, zero regulatory fines (Transportstyrelsen), and harmonious union compliance, fully enforced by software.

## 2. Scheduling Guardrails (Policy-as-Code)
The `SchedulingAgent` and any system generating or validating driver rosters must enforce the following absolute constraints.

### 2.1 Constraint: Standard Daily Rest (Normal Dygnsvila)
*   **Rule:** A driver must have at least **11 consecutive hours** of rest within a 24-hour period following the end of the previous rest.
*   **System Implementation:** The roster generator must default to a hard minimum of 11 hours between the scheduled `ShiftEnded` and the subsequent `ShiftStarted` timestamps.

### 2.2 Constraint: Reduced Daily Rest (Reducerad Dygnsvila)
*   **Rule:** Daily rest can be reduced to a minimum of **9 consecutive hours**, but this is strictly limited to a maximum of **three (3) times** between any two weekly rest periods.
*   **System Implementation:** If a scheduling agent attempts to assign a rest period of < 11 hours (but >= 9 hours), it must first query the driver's historical state for the current week. If the counter for `reduced_daily_rests` is `>= 3`, the assignment must be programmatically rejected (State validation error).

### 2.3 Constraint: Split Daily Rest (Delad Dygnsvila)
*   **Rule:** Daily rest can be split into two periods, provided the first period is at least **3 uninterrupted hours** and the second period is at least **9 uninterrupted hours** (totaling 12 hours).
*   **System Implementation:** The scheduling system must support "split shift" (delad tjänst) validation. The agent must verify that the intervals between active driving blocks strictly adhere to the `3h + 9h` minimums.

## 3. Real-Time Event Enforcement
Because Kalles Buss operates dynamically, pre-planned schedules can be invalidated by operational realities (e.g., traffic jams, weather, vehicle breakdowns). Rest periods are calculated based on *actual* events, not just planned schedules.

### 3.1 Dynamic Recalculation
*   When a `traffic.driver.shift_ended` event is emitted on the event bus, the HR domain must immediately calculate the exact timestamp when the driver is legally permitted to drive again.
*   **Interlock:** If the actual end-of-shift timestamp was delayed, causing the planned next shift to violate the rest constraints, the HR system must emit a `hr.driver.rest_violation_predicted` event.

### 3.2 Automated Reassignment
*   Upon receiving a `rest_violation_predicted` event, the Traffic/Routing Agent must automatically detach the affected driver from the upcoming route.
*   The system must either delay the route (if SLAs allow) or automatically page/assign a standby driver (`reservförare`) to cover the deficit.

### 3.3 Hardware Edge Enforcement
*   The vehicle's onboard telematics unit (edge device) is the final guardrail. When a driver attempts to log in (e.g., via RFID or Driver Card) to initiate a commercial route, the edge device must verify the driver's legal state.
*   If the minimum rest period has not been met, the bus must physically/logically block the driver from initiating the operational state and alert the traffic control center.

## 4. Union & Regulatory Audit
*   All scheduling decisions, including the automated invocation of "Reducerad Dygnsvila", must be logged immutably.
*   The system must expose standardized reporting APIs for automated extraction of tachograph/rest data to facilitate routine inspections by the Swedish Transport Agency (Transportstyrelsen) and union safety representatives (skyddsombud).
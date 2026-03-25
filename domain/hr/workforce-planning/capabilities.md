# Workforce Planning - Capabilities

## 1. Domain Purpose
Workforce Planning (Rostering) is a complex constraint-satisfaction engine. It bridges the gap between `Traffic` (which knows *what* needs to be driven) and `Core HR` (which knows *who* is allowed to drive).

## 2. Core Capabilities

### 2.1 Roster Generation (Constraint Solving)
*   **Inputs:** `TripPlans` (from Traffic), `DriverAvailability` (from Core HR), `DepotLocations`, and the `Union/EU Rules` (from governance policies).
*   **Action:** Automatically generates optimized shifts (Pass). It must balance:
    *   **Legal:** Ensuring 11h daily rest (or 9h reduced).
    *   **Geographic:** Ensuring a driver starts and ends their shift at their contracted home depot (e.g., Norrtälje), or calculating paid travel time if they must start elsewhere.
    *   **Financial:** Minimizing expensive "Split Shifts" (Delade pass) and overtime (OB).

### 2.2 Vacation & Leave Bidding
*   Allows drivers to submit vacation requests. The planning agent evaluates the requests against required coverage levels for that period and auto-approves or denies them based on seniority or first-come-first-serve union rules.

## 3. The A-A-H Escalation Model in Workforce Planning

### Level 1: Straight-Through Automation
*   **Scenario:** Standard weekly roster generation for the Norrtälje depot.
*   **Action:** The algorithm finds a perfect mathematical fit that covers all routes, gives everyone their legal rest, and adheres to 100% of union rules. The schedule is published to the drivers' apps automatically 14 days in advance.

### Level 2: AI Agent Resolution
*   **Scenario:** A major music festival is announced, requiring 20 extra buses on a Saturday night. The mathematical solver fails to find a solution because there aren't enough available drivers without breaching the 40-hour weekly overtime limit.
*   **Action:** The Rostering Agent switches from "Strict Compliance" to "Bargaining Mode". It analyzes historical data to see which drivers frequently accept extra shifts. It sends out an automated "Bidding Request" via SMS to part-time staff and drivers at neighboring depots, offering a specific bonus rate to fill the 20 slots. As drivers click "Accept", the agent dynamically patches the roster.

### Level 3: Human-in-the-Loop
*   **Scenario:** A widespread flu epidemic hits the region. 30% of the workforce is out sick. The mathematical solver and the agent's bidding requests both fail to cover the core SL contract routes.
*   **Action:** The system raises a "Capacity Crisis". A human planner must manually intervene, selectively cancel low-priority routes (in coordination with SL/Traffic domain), and manually override standard roster preferences to prioritize critical commuter lines.
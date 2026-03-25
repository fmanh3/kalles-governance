# Energy Management - Capabilities

## 1. Domain Purpose
Energy Management is an optimization engine. It ensures that every electric bus has the required energy to complete its next scheduled route without running out of battery, while simultaneously avoiding peak electricity pricing and preventing depot grid overload.

## 2. Core Capabilities

### 2.1 Smart Charging (Load Shifting)
*   **Inputs:** Reads the `TripPlan` from Traffic (when does the bus leave, how far is the route), current `SOC` from the Fleet Gateway, and the `Day-Ahead Spot Price` from the energy market.
*   **Output:** Generates an optimal `ChargingProfile` (e.g., "Wait until 02:00 when prices drop, then charge at 150kW until 05:00").

### 2.2 Dynamic Load Balancing
*   **Constraint:** The depot has a maximum grid capacity (e.g., 2 MW). If 30 buses plug in simultaneously, they cannot all charge at maximum speed without blowing the main fuse.
*   **Mechanism:** Continuously redistributes available power among active chargers based on the priority of the next departing trip.

### 2.3 Range Anxiety Prevention
*   Calculates the estimated energy consumption for an upcoming trip based on weather (heating/AC uses significant battery), passenger load, and route topography. 
*   Emits an alert if a scheduled bus mathematically cannot complete its assigned route.

## 3. The A-A-H Escalation Model in Energy Management

### Level 1: Straight-Through Automation
*   **Scenario:** A bus plugs in at 20:00 with 40% SOC. Its next departure is 06:00. 
*   **Action:** The system calculates it needs 3 hours of charging. It automatically schedules the charging window during the cheapest spot-price hours (01:00-04:00) and sends the `StartTransaction` command to the Charger Gateway at 01:00.

### Level 2: AI Agent Resolution
*   **Scenario (Grid Overload Warning):** Spot prices are exceptionally low right now, so the Level 1 logic attempts to command all 50 chargers to maximum power, threatening to breach the 2MW grid limit.
*   **Action:** The Grid Management Agent intercepts the command block. It ranks all 50 buses by their `ScheduledDepartureTime`. It allocates maximum power to the 10 buses leaving first, throttles the next 20 to 50% power, and pauses the remaining 20 until capacity frees up, ensuring grid stability while fulfilling operational SLAs.

### Level 3: Human-in-the-Loop
*   **Scenario:** A severe winter storm (-20°C) drastically reduces battery efficiency. The Energy Engine calculates that even with 100% SOC, 5 scheduled buses will not be able to complete their long rural routes without dying.
*   **Action:** The system halts automated vehicle assignment. It flags the routes as "High Risk of Failure" and alerts the human Traffic Planner and Fleet Manager to intervene (e.g., swapping to diesel reserve buses or adding a mid-route charging stop).
# Driver Operations - Capabilities

## 1. Domain Purpose
Driver Operations manages the execution of the schedule on the actual day of operation. It is highly reactive, dealing with the chaos of reality: morning sickness, late arrivals, and real-time tracking of driving hours to prevent legal breaches mid-shift.

## 2. Core Capabilities

### 2.1 Time & Attendance (Clock-In/Out)
*   Ingests events from the edge device on the bus or a terminal at the depot (`DriverClockedIn`, `RestStarted`, `RestEnded`).
*   Validates these actual times against the planned roster.
*   Pushes clean, normalized time entries to the `Payroll Engine`.

### 2.2 Real-Time Rest Tracking (Tachograph Integration)
*   **The EU 561/2006 Rule:** A driver must take a 45-minute break after 4.5 hours of continuous driving.
*   **Action:** The domain continuously monitors the `DrivingTime` via the `Fleet Gateway` telemetry. If a driver approaches the 4.5-hour limit (e.g., due to severe traffic delaying their return to the depot), the system triggers an alert.

### 2.3 Acute Absence Management (Sjukanmälan)
*   Handles unplanned, immediate absences (e.g., a driver calls in sick at 04:00 AM).
*   Triggers the "Automated Reassignment" cascade.

## 3. The A-A-H Escalation Model in Driver Operations

### Level 1: Straight-Through Automation
*   **Scenario:** Driver arrives at 06:00, logs into Bus 12 via their RFID card. 
*   **Action:** System registers the start time, confirms identity, unlocks the vehicle, and updates the `Traffic` Digital Twin that the trip is "Manned and Ready".

### Level 2: AI Agent Resolution
*   **Scenario (04:00 AM Sick Call):** A driver assigned to the critical 05:30 commuter route to Stockholm logs a "Sick" status in the app at 04:00 AM.
*   **Action:** The Operations Agent intercepts this. It immediately:
    1. Unassigns the driver.
    2. Scans the "Standby" (`Reserv/Beredskap`) roster for the Norrtälje depot.
    3. Finds an available standby driver, sends an automated automated wake-up call/push notification, and assigns them the route.
    4. Updates `Traffic` and `Depot` with the new driver ID. 

### Level 3: Human-in-the-Loop
*   **Scenario:** A driver gets stuck in a massive traffic jam. They hit the 4.5-hour driving limit and are legally forced to pull the bus over to the side of the highway and take a 45-minute break, leaving passengers stranded.
*   **Action:** The agent cannot resolve a legal hard-stop on an active highway. It alerts the human Traffic Dispatcher, who must use the radio to instruct the driver and arrange a rescue bus for the passengers.
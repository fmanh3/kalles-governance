# Depot Operations - Capabilities

## 1. Domain Purpose
Depot Operations (Yard Management) acts as the physical state machine of the bus terminal. While Traffic Control knows where the bus is on the *road*, Depot Operations knows exactly where the bus is parked within the *yard*, who has the keys, and its physical readiness state (washed, inspected, maintained).

## 2. Core Capabilities

### 2.1 Yard Location Tracking
*   Tracks the micro-location of vehicles within the depot boundaries (e.g., "Parking Bay 42", "Wash Station 2", "Workshop Lane A").
*   Relies on geofencing, RFID gates, or manual input from the depot staff.

### 2.2 Vehicle Readiness State Machine
*   A vehicle cannot be assigned to a `Trip` by Traffic Control unless its `ReadinessState` in the depot is `Ready_For_Service`.
*   Readiness requires multiple criteria: SOC is sufficient (via Energy domain), no critical maintenance flags, and legally required daily inspections (Pre-Trip Inspection) are logged.

### 2.3 Driver-to-Vehicle Handover
*   Coordinates the physical meeting of the HR domain (Driver) and the physical asset (Bus). 
*   Provides terminal displays or app instructions telling the arriving driver exactly which parking bay to walk to.

## 3. The A-A-H Escalation Model in Depot Operations

### Level 1: Straight-Through Automation
*   **Scenario:** A bus finishes a route, the driver parks it in Bay 12, plugs in the charger, and completes the digital post-trip inspection with no errors.
*   **Action:** The system automatically updates the yard location to "Bay 12", registers the inspection, hands over control to the Energy Management domain for charging, and marks the bus `Ready_For_Service` for tomorrow.

### Level 2: AI Agent Resolution
*   **Scenario:** A driver arrives at 05:00 for the first route. The Traffic domain assigned them Bus 104 in Bay 12. However, the Charger Gateway reports that Bus 104 suffered a hardware charging fault during the night and is at 15% SOC.
*   **Action:** The Depot Allocation Agent intercepts the failure. It scans the yard for another bus of the exact same type with >80% SOC that is currently unassigned. It finds Bus 112 in Bay 4. It automatically re-assigns the hardware in the Digital Twin and sends a push notification to the driver's phone: "Your bus has changed. Proceed to Bay 4."

### Level 3: Human-in-the-Loop
*   **Scenario:** A bus returns to the depot with a shattered windshield (vandalism) and a damaged front bumper.
*   **Action:** The driver logs the damage. The system immediately flags the bus as `Out_Of_Service`. A human Depot Manager must physically inspect the vehicle, log a damage report, open an insurance claim with the AP/Finance domain, and coordinate with external repair technicians.
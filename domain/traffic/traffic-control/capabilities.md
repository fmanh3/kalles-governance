# Traffic Control - Capabilities

## 1. Domain Purpose
Traffic Control is the brain of the active operation. It maintains the "Digital Twin" of the fleet by constantly comparing the actual state of the vehicles (received from the `Fleet Gateway`) against the planned state (the Timetable/Schedule). It manages deviations, generates SLA events (delays), and orchestrates real-time dispatching.

## 2. Core Capabilities

### 2.1 The Digital Twin (State Machine)
*   Consumes `CanonicalTelemetry` events.
*   Maps raw GPS coordinates to semantic logical objects (e.g., "Bus is at Geofence Stop A", "Bus is driving on Route Segment B").

### 2.2 Real-Time Schedule Adherence (Punctuality)
*   Compares semantic location against the active `TripPlan`.
*   Automatically calculates deviations (e.g., +2 minutes early, -4 minutes late).
*   Emits `TrafficDeviation` events which are used by:
    *   **Billing Engine:** To calculate SLA penalties.
    *   **External APIs (GTFS-RT/SIRI):** To update the passenger apps (e.g., SL Appen) with real-time ETA.

### 2.3 Exception Management & Dispatching
*   Monitors for critical events (e.g., `BusBreakdown`, `DriverPanicButton`, `ExtremeDelay`).
*   Orchestrates the mitigation strategy, such as assigning a standby bus or canceling a trip.

## 3. The A-A-H Escalation Model in Traffic Control

### Level 1: Straight-Through Automation
*   **Scenario:** A bus arrives at the Norrtälje terminal 1 minute behind schedule.
*   **Action:** Traffic Control automatically records the arrival, updates the GTFS-RT feed indicating a 1-min delay, and transitions the `TripState` to `Completed`. No human is notified because 1 minute is within the SLA tolerance.

### Level 2: AI Agent Resolution
*   **Scenario (Cascading Delay Prediction):** A bus gets stuck in severe traffic on the highway. It is 15 minutes late. This specific bus is scheduled to immediately turn around and drive back.
*   **Action:** The Traffic Routing Agent detects that the current delay will cause a *cascading delay* for the next trip. The Agent automatically:
    1. Cancels the immediate turnaround trip.
    2. Dispatches a standby bus (`Reservvagn`) from the depot to cover the return trip to prevent SLA failure.
    3. Instructs the delayed bus to return to the depot as `Tomkörning` (Empty run) once it arrives.

### Level 3: Human-in-the-Loop
*   **Scenario:** The Fleet Gateway reports an `AirbagDeployed` or `AccidentDetected` event for a bus on an active route.
*   **Action:** Absolute system halt on automation. A high-decibel alarm triggers in the control room. A human Traffic Controller takes over, contacts emergency services, communicates with the driver, and manually executes the crisis response playbook.
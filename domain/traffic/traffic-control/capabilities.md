# Traffic Control - Capabilities

## 1. Domain Purpose
Traffic Control acts as the "Brain" of the vehicle operations. It maintains the real-time state of the entire fleet, tracks vehicle positions against timetables, and manages the lifecycle of a `Tour`.

## 2. Core Capabilities

### 2.1 Fleet State Management (Digital Twin)
*   Maintains the "Source of Truth" for every vehicle's current status (Active, Maintenance, Charging, Idle).
*   Tracks real-time position and heading.

### 2.2 Tour Orchestration
*   Starts and terminates `Tours` based on scheduling data.
*   Assigns physical vehicles to specific journeys.
*   Monitors punctuality (On-time, Delayed, Early).

### 2.3 Incident Management
*   Detects anomalies (e.g., bus off-route, sudden SoC drop).
*   Publishes alerts to the control center and the Driver App.

## 3. Events
*   **Listens to:** `VehicleTelemetryUpdate` (from Fleet Gateway).
*   **Publishes:** `TrafficTourStarted`, `TrafficTourCompleted`, `VehicleIncidentDetected`.

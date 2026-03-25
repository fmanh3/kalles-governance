# Fleet Gateway - Capabilities

## 1. Domain Purpose
The Fleet Gateway acts as the strict Anti-Corruption Layer (ACL) between the physical vehicles (or third-party Fleet Management Systems like Scania FMS or Volvo Connect) and the Kalles Buss internal platform. Its job is to ingest high-frequency, noisy hardware data and translate it into clean, standardized domain events.

## 2. Core Capabilities

### 2.1 Telemetry Ingestion & Normalization
*   **Protocols:** Supports standard public transport protocols such as **ITxPT** and the **FMS Standard** (Fleet Management System via CAN-bus), as well as vendor-specific REST/MQTT APIs.
*   **Data Points:** Collects GPS location, Speed, Odometer, State of Charge (SOC) for EVs, Door status (Open/Closed), and Driver Tachograph state.
*   **Normalization:** Translates vendor-specific codes (e.g., Volvo's "Door Error 404" vs Scania's "Door Jammed 12") into canonical Kalles Buss JSON.

### 2.2 Event Throttling & Smoothing (Filtering)
*   Raw telemetry might stream at 1Hz (1 event/second). The event bus would drown.
*   The gateway smooths the data (e.g., using Kalman filters for GPS jitter) and throttles the output to meaningful intervals (e.g., every 10 seconds, or explicitly upon significant state changes like `DoorOpened`).

### 2.3 Identity Binding (Hardware to Asset)
*   Translates physical hardware identifiers (e.g., a telematics unit IMEI or MAC address) into the internal Kalles Buss `VehicleId` (UUID) using a master lookup table.

## 3. The A-A-H Escalation Model in Fleet Gateway

### Level 1: Straight-Through Automation
*   **Scenario:** A bus drives along a route. The telematics unit sends steady ITxPT payloads. 
*   **Action:** The gateway parses, throttles, normalizes, and publishes `VehicleLocationUpdated` and `VehicleTelemetry` events automatically.

### Level 2: AI Agent Resolution
*   **Scenario (Sensor Dropout):** A bus enters a long tunnel (e.g., Södra Länken). The GPS signal drops out for 3 minutes.
*   **Action:** The Telemetry Agent intercepts the "Signal Lost" state. Using the last known vector (speed/heading) and the known mapped route topology, it interpolates the bus's position (`estimated_location=true`) to keep the Digital Twin moving smoothly, preventing false "Bus Missing" alarms in Traffic Control.

### Level 3: Human-in-the-Loop
*   **Scenario:** A telematics unit starts sending completely garbage data (e.g., GPS coordinates placing the bus in the Atlantic Ocean, or SOC = 999%). 
*   **Action:** The system halts data propagation to prevent poisoning the Billing/Traffic engines. It generates a high-priority "Hardware Defect" work order for the Maintenance/Depot human crew to replace the edge device on that specific bus.
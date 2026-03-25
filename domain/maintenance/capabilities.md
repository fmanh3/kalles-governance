# Maintenance & Asset Management - Capabilities

## 1. Domain Purpose
This domain ensures the fleet remains safe, legal, and operational while minimizing downtime. It shifts Kalles Buss from reactive "break-fix" repairs to proactive, data-driven Predictive Maintenance.

## 2. Core Capabilities

### 2.1 Predictive Maintenance (AI Diagnostics)
*   **Listen:** Consumes raw `CanonicalTelemetry` and hardware states from the `Fleet Gateway`.
*   **Analyze:** Monitors patterns indicating impending failure (e.g., abnormal brake temperature, battery cell voltage imbalances, engine fault codes).
*   **Action:** Automatically generates `MaintenanceWorkOrder` events *before* the bus breaks down on the road.

### 2.2 Scheduled Servicing (Besiktning & Service)
*   Tracks the legal and manufacturer-mandated service intervals based on calendar days or driven kilometers (e.g., "Yearly Besiktning", "100k km Service").
*   Integrates with `Depot Operations` to ensure the vehicle is pulled from the active roster on the required date.

### 2.3 Parts & Inventory Management
*   Manages the stock levels of critical spare parts at the depots.
*   Automatically triggers purchase orders (via the AP domain) when inventory falls below minimum thresholds.

## 3. The A-A-H Escalation Model

### Level 1: Straight-Through Automation
*   **Scenario:** Bus 12 hits 98,000 km. A standard 100k km service is required.
*   **Action:** The system automatically creates a work order, reserves a slot in the workshop next week, orders the standard filter kit from the supplier, and marks the bus as unavailable for Traffic Control on that specific date.

### Level 2: AI Agent Resolution
*   **Scenario:** Telemetry shows Bus 44's electric heater is consuming 30% more power than the fleet average, indicating a failing component, but there are no hard error codes.
*   **Action:** The Diagnostics Agent creates a "Low Priority Inspection" task. It analyzes the upcoming weather forecast and sees temperatures will drop to -10°C next week. The Agent immediately upgrades the task to "High Priority" and schedules the repair for tonight, preventing the bus from freezing mid-route later.

### Level 3: Human-in-the-Loop
*   **Scenario:** A bus is involved in a severe collision.
*   **Action:** The system grounds the bus indefinitely. A human Lead Mechanic must physically assess the structural damage, determine if the vehicle is totaled (write-off), and manually coordinate with insurance adjusters.
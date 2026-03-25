# Energy Management - Data Model & Flows

## 1. Internal Data Model (State)

### Entity: `ChargingSession`
*   `session_id` (UUID)
*   `vehicle_id` (UUID)
*   `charger_id` (String)
*   `start_soc_percentage` (Float)
*   `target_soc_percentage` (Float) - Driven by the next scheduled route.
*   `deadline_timestamp` (DateTime) - When must it be fully charged?
*   `status` (Enum: Plugged_In, Waiting_For_Price, Charging, Suspended_Grid_Limit, Completed, Error)

### Entity: `DepotGridState`
*   `depot_id` (String)
*   `max_capacity_kw` (Int) - Physical limit of the grid connection.
*   `current_draw_kw` (Int) - Sum of all active chargers.
*   `spot_price_matrix` (JSON) - Hourly pricing data for the day.

## 2. Information Flow (Smart Charging)

```mermaid
sequenceDiagram
    participant Driver/Bus
    participant Charger Gateway (OCPP)
    participant Energy Management
    participant Traffic Control (Schedule)

    Driver/Bus->>Charger Gateway: Plugs in Bus 12
    Charger Gateway->>Energy Management: Event `VehiclePluggedIn` (Bus 12, SOC 20%)
    
    Energy Management->>Traffic Control: Request `NextAssignment` for Bus 12
    Traffic Control-->>Energy Management: Departs 05:30, Route requires 60% battery.
    
    Energy Management->>Energy Management: Calculate target SOC = 80% (incl. 20% safety margin).
    Energy Management->>Energy Management: Analyze spot prices & grid capacity.
    
    Note over Energy Management: Strategy: Delay charging until 02:00 for cheaper rates.
    Energy Management->>Charger Gateway: Command `SetChargingProfile` (0kW until 02:00, then 150kW)
    
    Note over Energy Management: 02:00 Arrives
    Charger Gateway->>Driver/Bus: Begins physical charging
```
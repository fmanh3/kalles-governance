# Traffic Control - Data Model & Flows

## 1. Internal Data Model (State)

This model represents the semantic state of the operation, not the hardware.

### Entity: `VehicleDigitalTwin`
*   `vehicle_id` (UUID)
*   `current_assignment` (UUID, Optional) - Link to an active `Trip`.
*   `logical_location` (Enum: At_Depot, On_Route, At_Stop, Maintenance)
*   `current_coordinate` (Lat/Lon)
*   `status` (Enum: Available, In_Service, Out_Of_Service, Emergency)

### Entity: `Trip` (The Planned Journey)
*   `trip_id` (UUID) - Matches GTFS standard `trip_id`.
*   `route_id` (String) - e.g., "676"
*   `vehicle_id` (UUID)
*   `driver_id` (UUID)
*   `scheduled_start` (DateTime)
*   `scheduled_end` (DateTime)
*   `status` (Enum: Scheduled, Active, Completed, Cancelled)

### Entity: `TripStopEvent`
*   `stop_id` (String) - e.g., "Tekniska Högskolan"
*   `trip_id` (UUID)
*   `planned_arrival` (DateTime)
*   `actual_arrival` (DateTime, Nullable)
*   `deviation_seconds` (Int) - Negative is late, Positive is early.

## 2. Information Flow (Digital Twin & Deviations)

```mermaid
sequenceDiagram
    participant Fleet Gateway
    participant Event Bus
    participant Traffic Control (Digital Twin)
    participant Billing / External (SL)

    Fleet Gateway->>Event Bus: Publish `CanonicalTelemetry` (Lat/Lon)
    Event Bus->>Traffic Control: Consume
    
    Traffic Control->>Traffic Control: Update `VehicleDigitalTwin` position
    Traffic Control->>Traffic Control: Intersect Lat/Lon with Geofence (Stop A)
    
    Note over Traffic Control: Semantic Event Detected
    Traffic Control->>Traffic Control: Calculate: Actual Arrival vs Planned Arrival
    Traffic Control->>Traffic Control: Set `deviation_seconds` = -180 (3 mins late)
    
    Traffic Control->>Event Bus: Publish `BusArrivedAtStop` (Trip: 123, Dev: -180s)
    
    Event Bus->>Billing / External (SL): Consume (Update SLA Penalty Engine / GTFS-RT)
```
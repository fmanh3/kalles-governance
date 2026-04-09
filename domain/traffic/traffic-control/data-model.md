# Traffic Control - Data Model

## 1. Domain Entities

### Entity: `Tour`
*   `id`: UUID (Primary Key)
*   `vehicle_id`: String (FK to Vehicle)
*   `line_id`: String
*   `route_id`: String
*   `status`: Enum (PLANNED, ACTIVE, COMPLETED, CANCELLED)
*   `start_time_actual`: DateTime
*   `end_time_actual`: DateTime
*   `distance_actual_km`: Decimal

### Entity: `VehiclePosition` (Real-time Snapshot)
*   `vehicle_id`: String (PK)
*   `lat`: Decimal
*   `lon`: Decimal
*   `heading`: Integer (0-359)
*   `last_update`: DateTime

## 2. Business Logic (Punctuality Calculation)

```typescript
// Example logic
if (actual_departure > planned_departure + 5 minutes) {
  status = "DELAYED";
}
```

# Fleet Gateway - Data Model

## 1. Internal Message Model (Normalized Telemetry)

Every incoming packet is transformed into this canonical format before being published to the internal bus.

### Entity: `VehicleTelemetryUpdate`
*   `vehicle_id`: String (Required)
*   `timestamp`: ISO8601 DateTime
*   `location`: 
    *   `lat`: Decimal
    *   `lon`: Decimal
*   `energy`:
    *   `soc`: Decimal (0-100)
    *   `voltage`: Decimal (Optional)
    *   `current_draw`: Decimal (Optional)
*   `environment`:
    *   `temp_ambient`: Decimal
*   `diagnostics`:
    *   `odometer`: Integer (meters)
    *   `active_faults`: Array of Strings

## 2. Ingestion Logic (Example Mapping)

| Source (FMS) | Internal Field | Transformation |
| :--- | :--- | :--- |
| `WHL_SPD` | `speed` | Convert to km/h |
| `AMB_AIR_TEMP` | `temp_ambient` | Celsius |
| `H_TOTAL_DIST` | `odometer` | Total distance in meters |
| `BATT_SOC` | `soc` | 0.0 to 100.0 |

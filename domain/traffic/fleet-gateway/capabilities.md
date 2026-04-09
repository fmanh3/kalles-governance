# Fleet Gateway - Capabilities

## 1. Domain Purpose
Fleet Gateway acts as the "Outer Ring" (Anti-Corruption Layer) for vehicle communication. It is responsible for ingesting raw telemetry data from various bus manufacturers (e.g., Volvo, BYD, Scania) and normalizing it into the system's internal "Digital Twin" format.

## 2. Core Capabilities

### 2.1 Multi-protocol Ingestion
*   Supports different communication standards (FMS, MQTT, WebHooks).
*   Handles authentication and decryption of incoming vehicle data streams.

### 2.2 Telemetry Normalization
*   Translates manufacturer-specific codes into standard internal signals:
    *   `pos_lat`, `pos_lon` (Coordinates)
    *   `state_of_charge` (%)
    *   `odometer` (km)
    *   `ambient_temp` (°C)
    *   `status_code` (Ready, Warning, Critical)

### 2.3 Command Proxy (V2)
*   Routes outbound commands from the system back to the physical vehicles (e.g., "Start Pre-heating", "Set Destination Display").

## 3. Interfaces
*   **Input:** Hardware Gateways (Vendor specific).
*   **Output:** Pub/Sub `traffic-telemetry` topic.

# Kalles Buss: Traffic Domain

## 1. Domain Overview
The `Traffic` domain is the operational core of Kalles Buss. It bridges the gap between the physical reality of buses driving on roads and the digital abstractions of schedules and contracts.

The fundamental architectural pattern here is the **Digital Twin**. We abstract the chaotic, hardware-specific signals from the vehicles into a clean, event-driven state machine that the rest of the enterprise (Billing, HR, Customer Apps) can consume safely.

## 2. Subdomains

### 2.1 Fleet Gateway (`fleet-gateway/`)
*   **Responsibility:** Hardware integration and telemetry normalization.
*   **Context:** This is the only domain that knows about vendor-specific Fleet Management Systems (FMS), CAN-bus protocols, or ITxPT standards. It ingests high-frequency, noisy data and publishes clean, low-frequency events.

### 2.2 Traffic Control (`traffic-control/`)
*   **Responsibility:** Maintaining the real-time Digital Twin of the fleet and managing the execution of the planned schedule.
*   **Context:** It compares "What *is* happening" (from the Fleet Gateway) with "What *should* be happening" (from the Planning/Scheduling domain). It detects deviations, manages dispatching, and triggers commercial SLA events.
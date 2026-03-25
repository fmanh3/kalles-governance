# Kalles Buss: Energy & Depot Domain

## 1. Domain Overview
The `Energy & Depot` domain manages the physical resting state of the fleet. Its primary goals are ensuring high vehicle availability for the `Traffic` domain while minimizing the operational costs associated with electricity and maintenance.

This domain sits at the intersection of operational planning (when does the bus need to leave?), HR (when does the driver arrive?), and financial optimization (when is electricity cheapest?).

## 2. Subdomains

### 2.1 Charger Gateway (`charger-gateway/`)
*   **Responsibility:** The hardware Anti-Corruption Layer for EV charging infrastructure.
*   **Context:** Communicates with physical charging stations using industry standards (OCPP). Translates hardware signals into internal events and executes charging commands.

### 2.2 Energy Management (`energy-management/`)
*   **Responsibility:** Smart charging, load balancing, and energy cost optimization.
*   **Context:** Uses AI agents to calculate optimal charging profiles based on spot prices, grid limits, and the required State of Charge (SOC) for the next scheduled trip.

### 2.3 Depot Operations (`depot-operations/`)
*   **Responsibility:** Yard management and vehicle preparation.
*   **Context:** Tracks the physical location of a bus within the depot (Parking, Wash, Workshop) and ensures it is physically ready (cleaned, inspected) before a driver claims it for a route.
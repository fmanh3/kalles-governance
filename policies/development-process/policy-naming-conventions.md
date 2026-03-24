# Policy: Naming Conventions

## 1. Python Codebase (PEP 8)
All Python code must strictly adhere to standard PEP 8 conventions. This is enforced automatically via tools like `Ruff`.
*   **Variables, Functions, Methods:** `snake_case` (e.g., `calculate_driver_rest_time`).
*   **Classes, Exceptions:** `PascalCase` (e.g., `RouteOptimizerAgent`).
*   **Constants:** `UPPER_SNAKE_CASE` (e.g., `MAX_SPEED_LIMIT_KMH`).

## 2. GCP Infrastructure & Resource Tagging
To support strict ownership, billing analysis, and security enforcement (LIS A.5.9), all GCP resources provisioned via Terraform must follow a standard naming and labeling convention.

*   **Naming Format:** `kb-{env}-{domain}-{resource_type}-{name}`
    *   *Example:* `kb-prod-hr-cloudrun-payroll`
    *   *Example:* `kb-dev-traffic-pubsub-bus_telemetry`

*   **Mandatory GCP Labels (LIS A.5.12 & GDPR):**
    *   `domain`: `traffic`, `hr`, `energy`, `finance`.
    *   `data_classification`: `public`, `internal`, `confidential`, `strictly_confidential`.
    *   `owner`: The name of the team or autonomous agent responsible for the resource.

## 3. Event Bus (Pub/Sub) Topics
Events represent domain facts and must be named consistently to ensure discoverability.

*   **Topic Format:** `[domain].[entity].[action]` (past tense).
    *   *Example:* `hr.driver.assigned`
    *   *Example:* `traffic.bus.arrived`
    *   *Example:* `energy.charger.failed`

## 4. Event Schema Metadata (GDPR 2.4)
Every JSON/Protobuf payload traversing the event bus must include top-level metadata fields to support programmatic privacy checks:
```json
{
  "metadata": {
    "event_id": "uuid",
    "timestamp": "iso8601",
    "purpose": "operational_routing",
    "legal_basis": "legitimate_interest"
  },
  "data": { ... }
}
```
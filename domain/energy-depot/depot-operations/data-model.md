# Depot Operations - Data Model & Flows

## 1. Internal Data Model (State)

### Entity: `DepotAsset`
*   `vehicle_id` (UUID)
*   `current_bay_id` (String) - e.g., "A-14"
*   `readiness_status` (Enum: Ready, Needs_Cleaning, In_Maintenance, Charging, Out_Of_Service)
*   `last_inspection_timestamp` (DateTime)

### Entity: `DepotTask`
*   `task_id` (UUID)
*   `vehicle_id` (UUID)
*   `task_type` (Enum: Clean_Interior, Wash_Exterior, Routine_Check, Move_To_Workshop)
*   `assigned_staff_id` (UUID, Optional)
*   `status` (Enum: Pending, In_Progress, Completed)

## 2. Information Flow (Driver Handover & Reassignment)

```mermaid
sequenceDiagram
    participant Driver (HR)
    participant Depot Operations
    participant Energy Management
    participant Traffic Control

    Note over Depot Operations: Morning Shift Start (04:30)
    Driver->>Depot Operations: Queries "Where is my bus?"
    Depot Operations->>Traffic Control: Get assignment for Driver X
    Traffic Control-->>Depot Operations: Assigned Bus 12
    
    Depot Operations->>Energy Management: Check Bus 12 SOC
    alt SOC is OK (>80%)
        Energy Management-->>Depot Operations: SOC 100%
        Depot Operations->>Driver: "Proceed to Bay A-12, Bus 12 is ready."
    else Charging Failed (SOC 15%)
        Energy Management-->>Depot Operations: SOC 15% (Error)
        Note over Depot Operations: Level 2 Agent triggers Reallocation
        Depot Operations->>Depot Operations: Find available equivalent Bus (Bus 99, SOC 95%)
        Depot Operations->>Traffic Control: Command `UpdateAssignment` (Bus 12 -> Bus 99)
        Depot Operations->>Driver: "ALERT: Bus changed. Proceed to Bay C-4 for Bus 99."
    end
```
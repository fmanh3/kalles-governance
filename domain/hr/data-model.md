# HR Domain - Data Model & Flows

## 1. Internal Data Model (State)

### Entity: `EmployeeProfile` (Core HR)
*   `employee_id` (UUID)
*   `home_depot_id` (String) - e.g., "Norrtälje"
*   `employment_status` (Enum: Active, Suspended, Terminated)
*   `certifications`:
    *   `drivers_license_expiry` (Date)
    *   `ykb_expiry` (Date)
    *   `medical_clearance_expiry` (Date)
*   `current_availability` (Enum: Available, On_Leave, Sick)

### Entity: `ShiftRoster` (Workforce Planning)
*   `shift_id` (UUID)
*   `employee_id` (UUID)
*   `date` (Date)
*   `planned_start` (DateTime)
*   `planned_end` (DateTime)
*   `assigned_trips` (List[UUID]) - Links to Traffic `Trip`
*   `status` (Enum: Draft, Published, Acknowledged, Executing, Completed)

### Entity: `DailyTimeLog` (Driver Operations)
*   `log_id` (UUID)
*   `employee_id` (UUID)
*   `shift_id` (UUID)
*   `events` (List[TimeEvent]):
    *   `event_type` (Enum: Clock_In, Driving_Start, Rest_Start, Clock_Out)
    *   `timestamp` (DateTime)
*   `accumulated_driving_minutes` (Int) - Tracks the 4.5h EU rule.

## 2. Information Flow (The 04:00 AM Sick Call)

```mermaid
sequenceDiagram
    participant Driver App
    participant Driver Ops
    participant Core HR
    participant Planning/Agent
    participant Traffic Control

    Note over Driver App: 04:00 AM
    Driver App->>Driver Ops: Submit `AcuteSickLeave`
    Driver Ops->>Core HR: Update Availability -> `Sick`
    
    Driver Ops->>Event Bus: Publish `DriverUnavailableForShift` (Shift 123)
    Event Bus->>Planning/Agent: Consume Event
    
    Note over Planning/Agent: Agent Resolution Level 2
    Planning/Agent->>Planning/Agent: Find Standby Driver at same Depot
    Planning/Agent->>Planning/Agent: Validate YKB/Rest limits for Standby
    
    Planning/Agent->>Event Bus: Publish `ShiftReassigned` (New Driver 99)
    Event Bus->>Traffic Control: Consume (Update Digital Twin)
    
    Planning/Agent->>Driver App (Standby): Push Notification: "Alert: You are assigned to route 676 at 05:30"
```
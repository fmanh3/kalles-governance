# HR & Workforce - Data Model

## 1. Internal State

### Entity: `Driver`
*   `id`: String (Primary Key)
*   `name`: String
*   `contact_email`: String
*   `ice_contact`: String
*   `bank_account`: String
*   `employment_form`: String
*   `vacation_days_saved`: Integer
*   `vacation_days_current`: Integer

### Entity: `Certification`
*   `id`: UUID
*   `driver_id`: String (FK to Driver)
*   `type`: String
*   `status`: Enum (Giltigt, Utgått, Godkänd)

### Entity: `Shift`
*   `id`: UUID
*   `driver_id`: String (FK to Driver)
*   `planned_start_time`: DateTime
*   `planned_end_time`: DateTime
*   `status`: Enum (SCHEDULED, ACTIVE, COMPLETED, CANCELLED, SICK)

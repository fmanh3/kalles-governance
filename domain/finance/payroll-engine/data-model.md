# Payroll Engine - Data Model

## 1. Domain Entities

### Entity: `SalaryRecord`
*   `driver_id`: String
*   `period`: String (YYYY-MM)
*   `base_amount`: Decimal
*   `ob_amount`: Decimal
*   `tax_deducted`: Decimal
*   `net_payout`: Decimal
*   `status`: Enum (DRAFT, APPROVED, PAID)
